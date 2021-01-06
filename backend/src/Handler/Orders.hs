{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Orders where

import Data.Aeson
import Data.Aeson.Types (Parser)
import qualified Data.HashMap.Strict as HM
import Data.Time
import qualified Data.Vector as V
import Database.Persist.Sql (toSqlKey)
import Import
import Model.OrderStatus
import System.IO.Unsafe

data PostOrder = PostOrder Order [ProductId]
  deriving (Show)

instance FromJSON PostOrder where
  parseJSON = withObject "Order" $ \obj -> do
    address <- obj .: "address"
    latitude <- obj .: "latitude"
    longitude <- obj .: "longitude"
    status <- obj .: "status" <|> return Pending
    productIdArray <- obj .: "products"
    productIds <- parseProductIdArray productIdArray
    -- TODO: Change this!
    let moment = unsafePerformIO getCurrentTime
    return (PostOrder (Order address latitude longitude moment status) productIds)

parseProductIdArray :: Value -> Parser [ProductId]
parseProductIdArray = withArray "ProductIds" $ \arr ->
  mapM parseProductId $ V.toList arr

parseProductId :: Value -> Parser ProductId
parseProductId = withObject "ProductId" $ \obj -> do
  productId <- obj .: "id"
  return (toSqlKey productId :: ProductId)

getOrdersR :: Handler TypedContent
getOrdersR = do
  orders <- runDB $ selectList [OrderStatus ==. Pending] [Asc OrderMoment]
  products <- runDB $ selectList [] [Asc ProductId]
  relationships <- runDB $ selectList [] [Asc OrderProductOrderId]

  let finalJson =
        reverse $
          foldr
            ( \order@(Entity orderId _) acc ->
                let relevantProductIds =
                      map (\(Entity _ orderProduct) -> orderProductProductId orderProduct) $
                        filter
                          (\(Entity _ orderProduct) -> orderProductOrderId orderProduct == orderId)
                          relationships
                    relevantProducts =
                      filter
                        (\(Entity productId _) -> productId `elem` relevantProductIds)
                        products
                 in acc ++ [encodeOrderWithProducts order relevantProducts]
            )
            []
            orders

  selectRep $ provideJson finalJson

encodeOrderWithProducts :: Entity Order -> [Entity Product] -> Value
encodeOrderWithProducts order products =
  case toJSON order of
    (Object orderObject) -> Object $ HM.insert "products" (toJSON products) orderObject
    _ -> Null

postOrdersR :: Handler Value
postOrdersR = do
  (PostOrder order productIds) <- requireCheckJsonBody :: Handler PostOrder
  insertedOrder <- runDB $ insert order
  let relationships = map (`OrderProduct` insertedOrder) productIds
  _ <- runDB $ insertMany relationships
  let finalObject = object ["orderId" .= insertedOrder, "productIds" .= productIds]
  sendResponseStatus status201 (toJSON finalObject)

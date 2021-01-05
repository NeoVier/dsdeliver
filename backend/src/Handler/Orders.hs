{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Handler.Orders where

import Import
import OrderStatus

getOrdersR :: Handler TypedContent
getOrdersR = do
  orders <- runDB $ selectList [OrderStatus ==. Pending] [Asc OrderMoment]
  products <- runDB $ selectList [] [Asc ProductId]
  relationships <- runDB $ selectList [] [Asc OrderProductOrderId]

  let finalJson = reverse $ foldr
        (\order@(Entity orderId _) acc ->
            let
                relevantProductIds =
                  map (\(Entity _ orderProduct) -> orderProductProductId orderProduct) $
                  filter (\(Entity _ orderProduct) -> orderProductOrderId orderProduct == orderId)
                  relationships
                relevantProducts =
                  filter (\(Entity productId _) -> productId `elem` relevantProductIds)
                  products

                finalObject = object [ "order" .= order, "products" .= relevantProducts ]
            in
            acc ++ [finalObject]
            ) [] orders

  selectRep $ provideJson finalJson


postOrdersR :: Handler Html
postOrdersR = error "Not yet implemented: postOrdersR"

module Handler.Products where

import Import

getProductsR :: Handler TypedContent
getProductsR = do
  products <- runDB $ selectList [] [Asc ProductName]
  selectRep $ provideJson products

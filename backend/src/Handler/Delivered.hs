{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Delivered where

import Import
import Model.OrderStatus


putDeliveredR :: OrderId -> Handler Value
putDeliveredR orderId = do
  updatedOrder <- runDB $ updateGet orderId [OrderStatus =. Delivered]
  returnJson $ (Entity orderId updatedOrder)


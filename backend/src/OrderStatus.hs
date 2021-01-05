{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module OrderStatus where

import ClassyPrelude.Yesod

data OrderStatus
  = Pending
  | Delivered
  deriving (Eq, Show, Read, Ord, Enum)

instance FromJSON OrderStatus where
  parseJSON (String x)
   | x == "Pending" = return Pending
   | x == "Delivered" = return Delivered
   | otherwise = fail "Invalid order status"
  parseJSON _ = fail "Invalid order status"


instance ToJSON OrderStatus where
  toJSON Pending = toJSON ("Pending" :: Text)
  toJSON Delivered = toJSON ("Delivered" :: Text)

derivePersistField "OrderStatus"

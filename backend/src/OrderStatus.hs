{-# LANGUAGE TemplateHaskell #-}

module OrderStatus where

import ClassyPrelude.Yesod

data OrderStatus
  = Pending
  | Delivered
  deriving (Eq, Show, Read, Ord)

derivePersistField "OrderStatus"
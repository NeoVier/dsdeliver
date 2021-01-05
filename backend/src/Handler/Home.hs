{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Handler.Home where

import Import
import OrderStatus

getHomeR :: Handler TypedContent
getHomeR = do
  date <- liftIO getCurrentTime
  selectRep $ provideJson $ Order "orderAddress" 0 0 date Pending
--    provideJson $ Product "productName" 0.23 "productDescription" "imageUri"
-- provideJson $ object ["name" .= ("testName" :: Text), "age" .= ("testAge" :: Text)]

postHomeR :: Handler Html
postHomeR = error "not implemented"

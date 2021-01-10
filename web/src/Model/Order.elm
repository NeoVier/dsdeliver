module Model.Order exposing (Order)

import LngLat exposing (LngLat)


type alias Order =
    { lngLat : LngLat
    , address : String
    , productIds : List Int
    }

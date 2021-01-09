module Api exposing (Feature, fetchMapbox, fetchProducts)

import Http
import Json.Decode as Decode exposing (Decoder)
import LngLat exposing (LngLat)
import Model.Product as Product exposing (Product)



-- OWN API
-- PUBLIC HELPERS


fetchProducts : (Result Http.Error (List Product) -> msg) -> Cmd msg
fetchProducts toMsg =
    Http.get
        { url = endpointUrl Products
        , expect = Http.expectJson toMsg (Decode.list productDecoder)
        }



-- INTERNAL


type ApiEndpoint
    = Products
    | Orders


endpointUrl : ApiEndpoint -> String
endpointUrl endpoint =
    String.join "/" (apiUrl :: endPointParts endpoint)


endPointParts : ApiEndpoint -> List String
endPointParts endpoint =
    case endpoint of
        Products ->
            [ "products" ]

        Orders ->
            [ "orders" ]


apiUrl : String
apiUrl =
    "https://localhost:5001"


productDecoder : Decoder Product
productDecoder =
    Decode.map5 Product
        (Decode.field "name" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "price" Decode.float)
        (Decode.field "imageUri" Decode.string)
        (Decode.field "id" Decode.int)



-- MAPBOX
-- PUBLIC HELPERS


fetchMapbox :
    { location : String, token : String }
    -> (Result Http.Error (List Feature) -> msg)
    -> Cmd msg
fetchMapbox urlTerms toMsg =
    Http.get
        { url = mapboxUrl urlTerms
        , expect = Http.expectJson toMsg <| Decode.field "features" (Decode.list decodeFeature)
        }


type alias Feature =
    { placeName : String, location : LngLat }



-- INTERNAL


mapboxUrl : { location : String, token : String } -> String
mapboxUrl { location, token } =
    "https://api.mapbox.com/geocoding/v5/mapbox.places/" ++ location ++ ".json?access_token=" ++ token


decodeFeature : Decoder Feature
decodeFeature =
    Decode.map2 Feature
        (Decode.field "place_name" Decode.string)
        (Decode.map2 LngLat
            (Decode.field "center" (Decode.index 0 Decode.float))
            (Decode.field "center" (Decode.index 1 Decode.float))
        )

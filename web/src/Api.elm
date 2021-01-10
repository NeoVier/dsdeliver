module Api exposing (Feature, fetchMapbox, fetchProducts, postOrder)

import Env
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import LngLat exposing (LngLat)
import Model.Order exposing (Order)
import Model.Product as Product exposing (Product)



-- OWN API
-- PUBLIC HELPERS


fetchProducts : (Result Http.Error (List Product) -> msg) -> Cmd msg
fetchProducts toMsg =
    Http.get
        { url = endpointUrl Products
        , expect = Http.expectJson toMsg (Decode.list productDecoder)
        }


postOrder : Order -> (Result Http.Error () -> msg) -> Cmd msg
postOrder order toMsg =
    Http.post
        { url = endpointUrl Orders
        , body = Http.jsonBody <| encodeOrder order
        , expect = Http.expectWhatever toMsg
        }



-- INTERNAL


type ApiEndpoint
    = Products
    | Orders


endpointUrl : ApiEndpoint -> String
endpointUrl endpoint =
    String.join "/" (apiUrl :: endpointParts endpoint)


endpointParts : ApiEndpoint -> List String
endpointParts endpoint =
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


encodeOrder : Order -> Value
encodeOrder { lngLat, address, productIds } =
    Encode.object
        [ ( "address", Encode.string address )
        , ( "latitude", Encode.float lngLat.lat )
        , ( "longitude", Encode.float lngLat.lng )
        , ( "productIds", Encode.list Encode.int productIds )
        ]



-- MAPBOX
-- PUBLIC HELPERS


fetchMapbox :
    String
    -> (Result Http.Error (List Feature) -> msg)
    -> Cmd msg
fetchMapbox searchString toMsg =
    Http.get
        { url = mapboxUrl searchString
        , expect = Http.expectJson toMsg <| Decode.field "features" (Decode.list decodeFeature)
        }


type alias Feature =
    { placeName : String, location : LngLat }



-- INTERNAL


mapboxUrl : String -> String
mapboxUrl location =
    "https://api.mapbox.com/geocoding/v5/mapbox.places/"
        ++ location
        ++ ".json?access_token="
        ++ Env.mapboxApiKey


decodeFeature : Decoder Feature
decodeFeature =
    Decode.map2 Feature
        (Decode.field "place_name" Decode.string)
        (Decode.map2 LngLat
            (Decode.field "center" (Decode.index 0 Decode.float))
            (Decode.field "center" (Decode.index 1 Decode.float))
        )

module Api exposing (fetchProducts)

import Http
import Json.Decode as Decode exposing (Decoder)
import LngLat exposing (LngLat)
import Model.Product as Product exposing (Product)



-- PUBLIC HELPERS


fetchProducts : (Result Http.Error (List Product) -> msg) -> Cmd msg
fetchProducts toMsg =
    Http.get
        { url = endpointUrl Products
        , expect = Http.expectJson toMsg (Decode.list productDecoder)
        }


fetchLocalMapbox :
    { location : String, token : String }
    -> (Result Http.Error LngLat -> msg)
    -> Cmd msg
fetchLocalMapbox urlTerms toMsg =
    Http.get
        { url = mapboxUrl urlTerms
        , expect = Http.expectJson toMsg LngLat.decodeFromObject
        }



-- INTERNAL


mapboxUrl : { location : String, token : String } -> String
mapboxUrl { location, token } =
    "https://api.mapbox.com/geocoding/v5/mapbox.places/" ++ location ++ ".json?access_token=" ++ token


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

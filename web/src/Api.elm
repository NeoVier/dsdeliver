module Api exposing (fetchProducts)

import Http
import Json.Decode as Decode exposing (Decoder)
import Model.Product as Product exposing (Product)



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
    "http://localhost:3000"


productDecoder : Decoder Product
productDecoder =
    Decode.map4 Product
        (Decode.field "name" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "price" Decode.float)
        (Decode.field "imageUri" Decode.string)

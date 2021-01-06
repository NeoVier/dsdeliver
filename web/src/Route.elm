module Route exposing (Route(..), fromUrl, linkToRoute)

import Element exposing (Element)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)



-- ROUTING


type Route
    = Home
    | Products


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map Products (Parser.s "products")
        ]



-- PUBLIC HELPERS


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser


linkToRoute : List (Element.Attribute msg) -> { route : Route, label : Element msg } -> Element msg
linkToRoute attrs { route, label } =
    Element.link attrs { url = toString route, label = label }



-- INTERNAL


toString : Route -> String
toString page =
    "/" ++ String.join "/" (routeToPieces page)


routeToPieces : Route -> List String
routeToPieces page =
    case page of
        Home ->
            []

        Products ->
            [ "products" ]

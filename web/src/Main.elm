module Main exposing (..)

import Browser
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )



-- MESSAGE


type Msg
    = NoOp



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout [ Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] <|
        Element.column [ Element.width Element.fill, Element.height Element.fill ]
            [ viewNavbar
            ]


primaryColor : Element.Color
primaryColor =
    Element.rgb255 0xDA 0x5C 0x5C


primaryHoverColor : Element.Color
primaryHoverColor =
    Element.rgb255 0xA7 0x4B 0x4B


darkColor : Element.Color
darkColor =
    Element.rgb255 0x26 0x32 0x38


secondaryColor : Element.Color
secondaryColor =
    Element.rgb255 0x9E 0x9E 0x9E


lightColor : Element.Color
lightColor =
    Element.rgb255 0xF5 0xF5 0xF5


viewNavbar : Element msg
viewNavbar =
    Element.row
        [ Region.navigation
        , Background.color primaryColor
        , Element.height <| Element.px 70
        , Element.width Element.fill
        , Element.paddingXY 45 0
        , Element.spacing 15
        ]
        [ Element.image [ Element.centerY ]
            { src = "/assets/logo.svg", description = "" }
        , Element.link
            [ Font.bold
            , Font.color <| Element.rgb 1 1 1
            , Font.size 24
            ]
            { url = "/", label = Element.text "DS Deliver" }
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

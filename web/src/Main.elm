module Main exposing (..)

import Browser
import Browser.Events
import Colors
import Component.Footer as Footer
import Component.Navbar as Navbar
import Dimmensions exposing (Dimmensions)
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Page.Home as Home
import Page.Order as Order



-- MODEL


type Route
    = Home
    | Order


type alias Model =
    { currRoute : Route, device : Element.DeviceClass }


init : Dimmensions -> ( Model, Cmd Msg )
init dimmensions =
    ( { currRoute = Home, device = Dimmensions.deviceClass dimmensions }, Cmd.none )



-- MESSAGE


type Msg
    = Resized Dimmensions



-- MAIN


main : Program Dimmensions Model Msg
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
    Element.layout
        [ Font.family [ Font.typeface "Open Sans", Font.sansSerif ]
        , Font.color Colors.dark
        ]
    <|
        Element.column [ Element.width Element.fill, Element.height Element.fill ]
            [ Navbar.view
            , case model.currRoute of
                Home ->
                    Home.view model.device

                Order ->
                    Order.view
            , Footer.view
            ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resized dimmensions ->
            ( { model | device = Dimmensions.deviceClass dimmensions }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize (\w h -> Resized { width = w, height = h })

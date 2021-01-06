module Main exposing (..)

import Browser
import Browser.Events
import Browser.Navigation as Nav
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
import Page.NotFound as NotFound
import Page.Products as Products
import Route exposing (Route)
import Url



-- MODEL


type alias Model =
    { currRoute : Maybe Route
    , navKey : Nav.Key
    , device : Element.DeviceClass
    }


init : Dimmensions -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init dimmensions url key =
    ( { currRoute = Route.fromUrl url, navKey = key, device = Dimmensions.deviceClass dimmensions }, Cmd.none )



-- MESSAGE


type Msg
    = Resized Dimmensions
    | ChangedUrl Url.Url
    | RequestedUrl Browser.UrlRequest



-- MAIN


main : Program Dimmensions Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = RequestedUrl
        }



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "DS Deliver"
    , body =
        [ Element.layout
            [ Font.family [ Font.typeface "Open Sans", Font.sansSerif ]
            , Font.color Colors.dark
            ]
          <|
            Element.column [ Element.width Element.fill, Element.height Element.fill ]
                [ Navbar.view
                , case model.currRoute of
                    Just Route.Home ->
                        Home.view model.device

                    Just Route.Products ->
                        Products.view

                    Nothing ->
                        NotFound.view
                , Footer.view
                ]
        ]
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedUrl url ->
            changeRouteTo (Route.fromUrl url) model

        RequestedUrl request ->
            case request of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        Resized dimmensions ->
            ( { model | device = Dimmensions.deviceClass dimmensions }, Cmd.none )


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    ( { model | currRoute = maybeRoute }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize (\w h -> Resized { width = w, height = h })

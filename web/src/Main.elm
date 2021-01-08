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
import MapCommands
import Page.Home as PHome
import Page.NotFound as PNotFound
import Page.Products as PProducts
import Route exposing (Route)
import Url



-- MODEL


type Page
    = Home
    | Products PProducts.Model
    | NotFound


type alias Model =
    { currPage : Page
    , navKey : Nav.Key
    , device : Element.DeviceClass
    , secrets : Secrets
    }


type alias Secrets =
    { mapbox : String }


type alias Flags =
    { secrets : Secrets
    , windowDimmensions : Dimmensions
    }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init { secrets, windowDimmensions } url key =
    case Route.fromUrl url of
        Just Route.Products ->
            let
                ( initialModel, cmd ) =
                    PProducts.init secrets.mapbox
            in
            ( { currPage = Products initialModel
              , navKey = key
              , device = Dimmensions.deviceClass windowDimmensions
              , secrets = secrets
              }
            , Cmd.map GotProductsMsg cmd
            )

        Just Route.Home ->
            ( { currPage = Home
              , navKey = key
              , device = Dimmensions.deviceClass windowDimmensions
              , secrets = secrets
              }
            , Cmd.none
            )

        Nothing ->
            ( { currPage = NotFound
              , navKey = key
              , device = Dimmensions.deviceClass windowDimmensions
              , secrets = secrets
              }
            , Cmd.none
            )



-- MESSAGE


type Msg
    = Resized Dimmensions
    | ChangedUrl Url.Url
    | RequestedUrl Browser.UrlRequest
    | GotProductsMsg PProducts.Msg



-- MAIN


main : Program Flags Model Msg
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
                , case model.currPage of
                    Home ->
                        PHome.view model.device

                    Products productsModel ->
                        PProducts.view productsModel

                    NotFound ->
                        PNotFound.view
                , Footer.view
                ]
        ]
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.currPage ) of
        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( RequestedUrl request, _ ) ->
            case request of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( Resized dimmensions, _ ) ->
            ( { model | device = Dimmensions.deviceClass dimmensions }, Cmd.none )

        ( GotProductsMsg productsMsg, Products productsModel ) ->
            let
                ( updatedModel, cmd ) =
                    PProducts.update productsModel productsMsg
            in
            ( { model | currPage = Products updatedModel }, Cmd.map GotProductsMsg cmd )

        -- Invalid messages
        ( GotProductsMsg _, _ ) ->
            ( model, Cmd.none )


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( { model | currPage = NotFound }, Cmd.none )

        Just Route.Products ->
            let
                ( initialModel, cmd ) =
                    PProducts.init model.secrets.mapbox
            in
            ( { model | currPage = Products initialModel }, Cmd.map GotProductsMsg cmd )

        Just Route.Home ->
            ( { model | currPage = Home }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize (\w h -> Resized { width = w, height = h })

module Page.Products exposing (Model, Msg, init, update, view)

import Api
import Colors
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes as Attr
import Html.Events
import Http
import Json.Decode as Decode
import LngLat exposing (LngLat)
import MapCommands
import Mapbox.Cmd.Option as MapOption
import Mapbox.Element as MapElem
import Mapbox.Style as MapStyle
import Model.Product as Product exposing (Product)



-- MODEL


type Model
    = Loading { mapboxApiKey : String }
    | WithData
        { products : List Product
        , location : LngLat
        , searchString : String
        , mapboxApiKey : String
        , features : Maybe (List Api.Feature)
        }
    | WithError


init : String -> ( Model, Cmd Msg )
init mapboxApiKey =
    ( Loading { mapboxApiKey = mapboxApiKey }, Api.fetchProducts GotProducts )



-- UPDATE


type Msg
    = GotProducts (Result Http.Error (List Product))
    | ChangedSearch String
    | ClickedSearch { searchString : String, mapboxApiKey : String }
    | GotSearch (Result Http.Error (List Api.Feature))
    | SelectedFeature Api.Feature


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case ( msg, model ) of
        ( GotProducts (Ok products), Loading { mapboxApiKey } ) ->
            let
                defaultLocation =
                    LngLat -49.640783 -27.199832
            in
            ( WithData
                { products = Product.exampleProduct2 :: products
                , location = defaultLocation
                , searchString = ""
                , mapboxApiKey = mapboxApiKey
                , features = Nothing
                }
            , MapCommands.jumpTo
                [ MapOption.center defaultLocation
                , MapOption.zoom 13
                ]
            )

        ( GotProducts (Err err), Loading _ ) ->
            ( WithError, Cmd.none )

        ( ChangedSearch newSearch, WithData wd ) ->
            ( WithData { wd | searchString = newSearch }, Cmd.none )

        ( ClickedSearch { searchString, mapboxApiKey }, WithData wd ) ->
            ( WithData wd
            , Api.fetchMapbox
                { location = searchString
                , token = mapboxApiKey
                }
                GotSearch
            )

        ( GotSearch (Ok features), WithData wd ) ->
            ( WithData { wd | features = Just features }
            , Cmd.none
            )

        ( GotSearch (Err _), WithData wd ) ->
            ( WithData { wd | searchString = "There was a problem" }, Cmd.none )

        ( SelectedFeature feature, WithData wd ) ->
            ( WithData
                { wd
                    | features = Nothing
                    , searchString = feature.placeName
                    , location = feature.location
                }
            , MapCommands.panTo [] feature.location
            )

        -- Invalid messages
        ( GotProducts _, _ ) ->
            ( model, Cmd.none )

        ( ChangedSearch _, _ ) ->
            ( model, Cmd.none )

        ( ClickedSearch _, _ ) ->
            ( model, Cmd.none )

        ( GotSearch _, _ ) ->
            ( model, Cmd.none )

        ( SelectedFeature _, _ ) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    Element.column [ Element.width Element.fill, Element.height Element.fill ]
        [ viewHeader
        , case model of
            Loading _ ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Loading"

            WithError ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Something went wrong"

            WithData { products, searchString, mapboxApiKey, features } ->
                Element.el
                    [ Element.width Element.fill
                    , Background.color Colors.light
                    , Element.paddingXY 100 50
                    ]
                <|
                    Element.column
                        [ Element.width <| Element.maximum 1200 Element.fill
                        , Element.centerX
                        ]
                        [ viewProductList products
                        , viewMap
                            { searchString = searchString
                            , mapboxApiKey = mapboxApiKey
                            }
                            features
                        ]
        ]


viewHeader : Element msg
viewHeader =
    let
        numberStyles =
            [ Font.color Colors.primary, Font.bold, Font.size 24, Element.paddingXY 15 0 ]
    in
    Element.row [ Element.paddingXY 100 20, Element.spacing 100, Element.centerX ]
        [ Element.column [ Font.bold, Font.size 36, Font.color Colors.primary ]
            [ Element.el [] <| Element.text "SIGA AS"
            , Element.el [] <| Element.text "ETAPAS"
            ]
        , Element.column
            [ Font.color Colors.secondary
            , Font.size 18
            , Element.width Element.fill
            , Element.spacing 10
            ]
            [ Element.paragraph []
                [ Element.el numberStyles <| Element.text "1"
                , Element.el [] <| Element.text "Selecione os produtos e a localização"
                ]
            , Element.paragraph []
                [ Element.el numberStyles <| Element.text "2"
                , Element.el [] <| Element.text "Depois clique em "
                , Element.el [ Font.bold ] <| Element.text "\"ENVIAR PEDIDO\""
                ]
            ]
        ]


viewProductList : List Product -> Element msg
viewProductList products =
    Element.wrappedRow
        [ Element.height Element.fill
        , Element.spacing 20
        , Element.paddingXY 0 50
        , Element.centerX
        , Element.htmlAttribute <| Attr.class "justify-center"
        ]
    <|
        List.map viewProductCard products


viewProductCard : Product -> Element msg
viewProductCard product =
    Element.column
        [ Background.color <| Element.rgb 1 1 1
        , Border.rounded 10
        , Element.padding 20
        , Element.spacing 20
        , Border.shadow { offset = ( 0, 4 ), size = 0, blur = 20, color = Element.rgba 0 0 0 0.25 }
        , Font.color Colors.secondary
        , Element.mouseOver [ Element.scale 1.01 ]
        , Element.width <| Element.maximum 300 Element.fill
        , Element.height Element.fill
        , Element.htmlAttribute <| Attr.class "product-card"
        ]
        [ Element.el
            [ Font.center
            , Element.width Element.fill
            , Font.color Colors.primary
            , Font.bold
            , Font.size 18
            ]
          <|
            Element.text product.name
        , Element.image [ Border.rounded 10, Element.clip, Element.centerX, Element.centerY, Element.width <| Element.px 220 ] { src = product.imageUri, description = product.name }
        , Element.el [ Font.bold, Font.color Colors.primary, Font.size 24 ] <|
            Element.text ("R$ " ++ Product.formatPrice product.price)
        , Element.el [ Element.width Element.fill, Element.height <| Element.px 2, Background.color <| Element.rgb255 0xE6 0xE6 0xE6 ] Element.none
        , Element.column [ Element.spacing 30, Element.height Element.fill ]
            [ Element.el [ Font.bold, Font.size 16 ] <| Element.text "Descrição"
            , Element.paragraph [ Font.size 14 ] [ Element.text product.description ]
            ]
        ]


viewMap :
    { searchString : String, mapboxApiKey : String }
    -> Maybe (List Api.Feature)
    -> Element Msg
viewMap ({ searchString, mapboxApiKey } as opts) maybeFeatures =
    Element.column
        [ Element.width Element.fill
        , Element.centerX
        , Element.paddingEach { top = 30, left = 10, right = 10, bottom = 10 }
        , Background.color <| Element.rgb 1 1 1
        , Element.spacing 20
        , Border.rounded 10
        , Border.shadow
            { offset = ( 0, 4 )
            , blur = 20
            , color = Element.rgba 0 0 0 0.25
            , size = 0
            }
        ]
        [ Element.el
            [ Element.centerX
            , Font.bold
            , Font.size 18
            , Font.color Colors.secondary
            ]
          <|
            Element.text "Selecione onde o pedido deve ser entregue"
        , Element.el
            [ Element.width Element.fill
            , Element.centerX
            , Element.height <| Element.px 500
            , Border.rounded 10
            , Element.clip
            , Background.color <| Colors.light
            , Element.inFront <| viewMapSearch opts maybeFeatures
            ]
          <|
            Element.html <|
                MapElem.map [ MapElem.id "my-map" ]
                    (MapStyle.FromUrl "mapbox://styles/mapbox/light-v10")
        ]


viewMapSearch : { searchString : String, mapboxApiKey : String } -> Maybe (List Api.Feature) -> Element Msg
viewMapSearch ({ searchString, mapboxApiKey } as opts) maybeFeatures =
    Element.column
        [ Element.moveDown 10
        , Element.width <| Element.fill
        , Element.paddingXY 10 0
        ]
        [ Input.search
            [ Element.paddingXY 50 20
            , Element.centerX
            , Font.bold
            , Font.size 18
            , Border.rounded 10
            , Border.color <| Element.rgba 0 0 0 0
            , Border.shadow
                { offset = ( 0, 4 )
                , size = 0
                , blur = 20
                , color = Element.rgba 0 0 0 0.25
                }
            , Element.inFront <|
                Input.button
                    [ Element.centerY
                    , Element.alignRight
                    , Element.height <| Element.fill
                    , Element.paddingXY 40 0
                    ]
                    { onPress = Just <| ClickedSearch opts
                    , label =
                        Element.image
                            []
                            { src = "./assets/search.svg"
                            , description = "search"
                            }
                    }
            , Element.htmlAttribute <|
                Html.Events.on "keyup"
                    (Decode.field "key" Decode.string
                        |> Decode.andThen
                            (\key ->
                                if key == "Enter" then
                                    Decode.succeed (ClickedSearch opts)

                                else
                                    Decode.fail "Not the enter key"
                            )
                    )
            ]
            { onChange = ChangedSearch
            , text = searchString
            , placeholder =
                Just <|
                    Input.placeholder [] <|
                        Element.text
                            "Selecione onde o pedido deve ser entregue"
            , label = Input.labelHidden "Selecione onde o pedido deve ser entregue"
            }
        , case maybeFeatures of
            Nothing ->
                Element.none

            Just features ->
                viewFeatures features
        ]


viewFeatures : List Api.Feature -> Element Msg
viewFeatures features =
    if List.isEmpty features then
        Element.el
            [ Element.width Element.fill
            , Element.moveDown 10
            , Background.color <| Element.rgb 1 1 1
            , Border.rounded 10
            , Element.padding 25
            ]
        <|
            Element.text "Nenhum resultado encontrado"

    else
        Element.column
            [ Element.width Element.fill
            , Element.height <| Element.minimum 300 <| Element.minimum (150 * List.length features) Element.fill
            , Element.moveDown 10
            , Background.color <| Element.rgb 1 1 1
            , Border.rounded 10
            , Element.clip
            , Element.scrollbarY
            ]
        <|
            List.map viewFeature features


viewFeature : Api.Feature -> Element Msg
viewFeature ({ placeName, location } as feature) =
    Input.button
        [ Element.width Element.fill
        , Element.paddingXY 50 20
        , Background.color <| Element.rgb 1 1 1
        , Border.color <| Colors.light
        , Border.width 1
        ]
        { onPress = Just (SelectedFeature feature)
        , label = Element.el [ Element.centerY ] <| Element.text placeName
        }

module Page.Products exposing (Model, Msg, init, update, view)

-- import Env

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
    = Loading
    | WithData
        { products : List Product
        , location : LngLat
        , searchString : String
        , features : Maybe (List Api.Feature)
        , selectedProducts : List Product
        , locationAddress : Maybe String
        , orderStatus : Maybe OrderStatus
        }
    | WithError


type OrderStatus
    = Success
    | Error String
    | Sending


init : ( Model, Cmd Msg )
init =
    ( Loading, Api.fetchProducts GotProducts )



-- UPDATE


type Msg
    = GotProducts (Result Http.Error (List Product))
    | ChangedSearch String
    | ClickedSearch String
    | GotSearch (Result Http.Error (List Api.Feature))
    | SelectedFeature Api.Feature
    | SelectedProduct Product
    | ClickedSendOrder
    | SentOrder (Result Http.Error ())
    | ClickedNewOrder


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case ( msg, model ) of
        ( GotProducts (Ok products), Loading ) ->
            let
                defaultLocation =
                    LngLat -49.640783 -27.199832
            in
            ( WithData
                { products = Product.exampleProduct2 :: products
                , location = defaultLocation
                , searchString = ""
                , features = Nothing
                , selectedProducts = []
                , locationAddress = Nothing
                , orderStatus = Nothing
                }
            , MapCommands.jumpTo
                [ MapOption.center defaultLocation
                , MapOption.zoom 13
                ]
            )

        ( GotProducts (Err err), Loading ) ->
            ( WithError, Cmd.none )

        ( ChangedSearch newSearch, WithData wd ) ->
            ( WithData { wd | searchString = newSearch }
            , Api.fetchMapbox newSearch GotSearch
            )

        ( ClickedSearch searchString, WithData wd ) ->
            ( WithData wd, Api.fetchMapbox searchString GotSearch )

        ( GotSearch (Ok features), WithData wd ) ->
            ( WithData { wd | features = Just features }
            , Cmd.none
            )

        ( GotSearch (Err err), WithData wd ) ->
            ( model, Cmd.none )

        ( SelectedFeature feature, WithData wd ) ->
            ( WithData
                { wd
                    | features = Nothing
                    , searchString = feature.placeName
                    , location = feature.location
                    , locationAddress = Just feature.placeName
                }
            , MapCommands.panTo [] feature.location
            )

        ( SelectedProduct newProduct, WithData wd ) ->
            if List.member newProduct wd.selectedProducts then
                ( WithData { wd | selectedProducts = List.filter (\p -> p /= newProduct) wd.selectedProducts }, Cmd.none )

            else
                ( WithData { wd | selectedProducts = newProduct :: wd.selectedProducts }, Cmd.none )

        ( ClickedSendOrder, WithData wd ) ->
            case wd.locationAddress of
                Nothing ->
                    ( WithData
                        { wd
                            | orderStatus =
                                Just <|
                                    Error "Selecione um endereço para poder enviar o pedido"
                        }
                    , Cmd.none
                    )

                Just address ->
                    let
                        order =
                            { lngLat = wd.location
                            , address = address
                            , productIds = List.map .id wd.selectedProducts
                            }
                    in
                    ( WithData { wd | orderStatus = Just Sending }, Api.postOrder order SentOrder )

        ( SentOrder (Ok ()), WithData wd ) ->
            ( WithData { wd | selectedProducts = [], orderStatus = Just Success }, Cmd.none )

        ( SentOrder (Err _), WithData wd ) ->
            ( WithData
                { wd
                    | orderStatus = Just <| Error "Ocorreu um erro ao processar pedido"
                }
            , Cmd.none
            )

        ( ClickedNewOrder, WithData wd ) ->
            ( WithData { wd | orderStatus = Nothing, selectedProducts = [] }, Cmd.none )

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

        ( SelectedProduct _, _ ) ->
            ( model, Cmd.none )

        ( ClickedSendOrder, _ ) ->
            ( model, Cmd.none )

        ( SentOrder _, _ ) ->
            ( model, Cmd.none )

        ( ClickedNewOrder, _ ) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Element Msg
view model =
    Element.column [ Element.width Element.fill, Element.height Element.fill ]
        [ viewHeader
        , case model of
            -- Loading _ ->
            Loading ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Loading"

            WithError ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Something went wrong"

            WithData wd ->
                let
                    isSent =
                        case wd.orderStatus of
                            Just Success ->
                                True

                            _ ->
                                False
                in
                Element.el
                    [ Element.width Element.fill
                    , Background.color Colors.light
                    , Element.paddingXY 100 50
                    ]
                <|
                    Element.column
                        [ Element.width <| Element.maximum 1200 Element.fill
                        , Element.centerX
                        , Element.spacing 50
                        ]
                        [ viewProductList
                            { allProducts = wd.products
                            , selectedProducts = wd.selectedProducts
                            }
                        , viewMap wd.searchString
                            wd.features
                        , viewSummary wd.selectedProducts wd.orderStatus
                        ]
        ]



-- HEADER


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



-- PRODUCTS


viewProductList : { allProducts : List Product, selectedProducts : List Product } -> Element Msg
viewProductList { allProducts, selectedProducts } =
    Element.wrappedRow
        [ Element.height Element.fill
        , Element.spacing 20
        , Element.centerX
        , Element.htmlAttribute <| Attr.class "justify-center"
        ]
    <|
        List.map (\p -> viewProductCard p (List.member p selectedProducts)) allProducts


viewProductCard : Product -> Bool -> Element Msg
viewProductCard product isSelected =
    Input.button [ Element.height Element.fill ]
        { onPress = Just <| SelectedProduct product
        , label =
            Element.column
                [ Element.padding 20
                , Element.spacing 20
                , Element.mouseOver [ Element.scale 1.01 ]
                , Element.width <| Element.maximum 300 Element.fill
                , Element.height Element.fill
                , Element.htmlAttribute <| Attr.class "product-card"
                , Background.color <| Element.rgb 1 1 1
                , Border.rounded 10
                , Border.color <|
                    if isSelected then
                        Colors.primary

                    else
                        Element.rgba 0 0 0 0
                , Border.width 3
                , Border.shadow { offset = ( 0, 4 ), size = 0, blur = 20, color = Element.rgba 0 0 0 0.25 }
                , Font.color Colors.secondary
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
                    Element.text (Product.formatPrice product.price)
                , Element.el [ Element.width Element.fill, Element.height <| Element.px 2, Background.color <| Element.rgb255 0xE6 0xE6 0xE6 ] Element.none
                , Element.column [ Element.spacing 30, Element.height Element.fill ]
                    [ Element.el [ Font.bold, Font.size 16 ] <| Element.text "Descrição"
                    , Element.paragraph [ Font.size 14 ] [ Element.text product.description ]
                    ]
                ]
        }



-- MAP


viewMap : String -> Maybe (List Api.Feature) -> Element Msg
viewMap searchString maybeFeatures =
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
            , Element.inFront <| viewMapSearch searchString maybeFeatures
            ]
          <|
            Element.html <|
                MapElem.map [ MapElem.id "my-map" ]
                    (MapStyle.FromUrl "mapbox://styles/mapbox/light-v10")
        ]


viewMapSearch : String -> Maybe (List Api.Feature) -> Element Msg
viewMapSearch searchString maybeFeatures =
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
                    { onPress = Just <| ClickedSearch searchString
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
                                    Decode.succeed (ClickedSearch searchString)

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
            , Font.center
            , Font.color Colors.secondary
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



-- SUMMARY


viewSummary : List Product -> Maybe OrderStatus -> Element Msg
viewSummary products maybeOrderStatus =
    let
        isSuccess =
            case maybeOrderStatus of
                Just Success ->
                    True

                _ ->
                    False

        boxStyles =
            [ Element.width Element.fill
            , Element.padding 20
            , Border.rounded 10
            , Font.color <| Element.rgb 1 1 1
            ]

        buttonStyles =
            [ Element.alignRight
            , Element.height Element.fill
            , Element.paddingXY 40 20
            , Element.mouseOver [ Background.color Colors.light ]
            , Background.color <| Element.rgb 1 1 1
            , Border.rounded 10
            , Font.center
            , Font.size 18
            , Font.bold
            ]
    in
    if isSuccess then
        Element.row (Background.color Colors.success :: boxStyles) <|
            [ Element.el [ Font.bold, Font.size 18 ] <| Element.text "Pedido enviado com sucesso"
            , Input.button
                (Font.color Colors.success :: buttonStyles)
                { onPress = Just ClickedNewOrder
                , label = Element.text "Fazer outro pedido"
                }
            ]

    else
        let
            isLoading =
                case maybeOrderStatus of
                    Just Sending ->
                        True

                    _ ->
                        False
        in
        Element.column [ Element.width Element.fill, Element.spacing 10 ]
            [ Element.row
                (Background.color Colors.primary :: boxStyles)
                [ Element.column [ Element.width Element.fill, Element.spacing 10 ]
                    [ Element.paragraph []
                        [ Element.el [ Font.bold, Font.size 16 ] <| Element.text <| String.fromInt <| List.length products
                        , Element.el [ Font.size 11 ] <| Element.text " PEDIDOS SELECIONADOS"
                        ]
                    , Element.paragraph [ Font.size 18 ]
                        [ Element.el [ Font.bold ] <| Element.text <| Product.formatPrice <| List.sum <| List.map .price products
                        , Element.el [] <| Element.text " VALOR TOTAL"
                        ]
                    ]
                , Input.button
                    (Font.color Colors.primary :: buttonStyles)
                    { onPress =
                        if isLoading then
                            Nothing

                        else
                            Just ClickedSendOrder
                    , label =
                        if isLoading then
                            Element.text "ENVIANDO"

                        else
                            Element.text "FAZER PEDIDO"
                    }
                ]
            , case maybeOrderStatus of
                Just (Error err) ->
                    Element.el [ Font.color Colors.primary, Element.paddingXY 20 0 ] <|
                        Element.text err

                _ ->
                    Element.none
            ]

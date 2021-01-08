module Page.Products exposing (Model, Msg, init, update, view)

import Api
import Colors
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html.Attributes as Attr
import Http
import Model.Product as Product exposing (Product)



-- MODEL


type Model
    = Loading
    | WithData { products : List Product }
    | WithError


init : ( Model, Cmd Msg )
init =
    ( Loading, Api.fetchProducts GotProducts )



-- UPDATE


type Msg
    = GotProducts (Result Http.Error (List Product))


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        GotProducts (Ok products) ->
            ( WithData { products = Product.exampleProduct2 :: products }, Cmd.none )

        GotProducts (Err err) ->
            ( WithError, Cmd.none )



-- VIEW


view : Model -> Element msg
view model =
    Element.column [ Element.width Element.fill, Element.height Element.fill ]
        [ viewHeader
        , case model of
            Loading ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Loading"

            WithError ->
                Element.el [ Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Something went wrong"

            WithData { products } ->
                viewProductList products
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
    Element.el [ Element.width <| Element.fill, Background.color Colors.light ] <|
        Element.wrappedRow
            [ Element.height Element.fill
            , Element.width <| Element.maximum 1200 Element.fill
            , Element.spacing 20
            , Element.paddingXY 100 50
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

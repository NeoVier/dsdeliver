module Page.Products exposing (..)

import Colors
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Model.Product as Product exposing (Product)



-- VIEW


view : Element msg
view =
    Element.column [ Element.width Element.fill, Element.height Element.fill ]
        [ viewHeader
        , viewProductList <| List.repeat 6 Product.exampleProduct
        ]


viewHeader : Element msg
viewHeader =
    let
        numberStyles =
            [ Font.color Colors.primary, Font.bold, Font.size 24, Element.paddingXY 15 0 ]
    in
    Element.row [ Element.paddingXY 100 20, Element.spacing 100, Element.alignRight ]
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
        , Element.width Element.fill
        , Background.color Colors.light
        , Element.spacing 20
        , Element.paddingXY 100 20
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
        , Element.column [ Element.spacing 30 ]
            [ Element.el [ Font.bold, Font.size 16 ] <| Element.text "Descrição"
            , Element.el [ Font.size 14 ] <| Element.text product.description
            ]
        ]

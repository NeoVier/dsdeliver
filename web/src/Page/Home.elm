module Page.Home exposing (view)

import Colors
import Component.Navbar as Navbar
import Dimmensions
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region



-- VIEW


view : Element.DeviceClass -> Element msg
view deviceClass =
    Element.row
        [ Element.width Element.fill
        , Element.height Element.fill
        , Element.centerX
        ]
        [ Element.column [ Element.centerX, Element.spacing 45 ]
            [ Element.textColumn [ Font.bold, Region.heading 1, Font.size 55 ]
                [ Element.el [] <| Element.text "Faça seu pedido"
                , Element.el [] <| Element.text "que entregamos"
                , Element.el [] <| Element.text "para você!"
                ]
            , Element.textColumn [ Font.color Colors.secondary ]
                [ Element.el [] <| Element.text "Escolha o seu pedido e em poucos minutos"
                , Element.el [] <| Element.text "levaremos na sua porta"
                ]
            , Element.link
                [ Font.color Colors.light
                , Font.bold
                , Background.color Colors.primary
                , Element.paddingXY 30 25
                , Border.rounded 10
                ]
                { url = "/order", label = Element.text "FAZER PEDIDO" }
            ]
        , if Dimmensions.isSmall deviceClass then
            Element.none

          else
            Element.image [ Element.centerX ] { src = "/assets/home.svg", description = "" }
        ]

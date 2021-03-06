module Component.Navbar exposing (view)

import Colors
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Route



-- VIEW


view : Element msg
view =
    Element.row
        [ Region.navigation
        , Background.color Colors.primary
        , Element.height <| Element.px 70
        , Element.width Element.fill
        , Element.paddingXY 45 0
        , Element.spacing 15
        ]
        [ Element.image [ Element.centerY ]
            { src = "/assets/logo.svg", description = "" }
        , Route.linkToRoute
            [ Font.bold
            , Font.color <| Element.rgb 1 1 1
            , Font.size 24
            ]
            { route = Route.Home, label = Element.text "DS Deliver" }
        ]

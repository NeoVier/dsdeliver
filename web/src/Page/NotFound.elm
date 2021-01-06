module Page.NotFound exposing (view)

import Element exposing (Element)



-- VIEW


view : Element msg
view =
    Element.el [ Element.height Element.fill, Element.centerX, Element.paddingXY 0 100 ] <| Element.text "Page not found :("

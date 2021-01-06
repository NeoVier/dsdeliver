module Dimmensions exposing (Dimmensions, deviceClass, isSmall)

import Element


type alias Dimmensions =
    { width : Int, height : Int }


deviceClass : Dimmensions -> Element.DeviceClass
deviceClass dimmensions =
    (Element.classifyDevice dimmensions).class


isSmall : Element.DeviceClass -> Bool
isSmall class =
    case class of
        Element.Phone ->
            True

        Element.Tablet ->
            True

        Element.Desktop ->
            False

        Element.BigDesktop ->
            False

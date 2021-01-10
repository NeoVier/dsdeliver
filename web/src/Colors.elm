module Colors exposing (dark, light, primary, primaryHover, secondary, success)

import Element


primary : Element.Color
primary =
    Element.rgb255 0xDA 0x5C 0x5C


primaryHover : Element.Color
primaryHover =
    Element.rgb255 0xA7 0x4B 0x4B


dark : Element.Color
dark =
    Element.rgb255 0x26 0x32 0x38


secondary : Element.Color
secondary =
    Element.rgb255 0x9E 0x9E 0x9E


light : Element.Color
light =
    Element.rgb255 0xF5 0xF5 0xF5


success : Element.Color
success =
    Element.rgb255 0x55 0xB5 0x56

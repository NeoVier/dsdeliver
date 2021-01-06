module Component.Footer exposing (..)

import Colors
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region



-- VIEW


view : Element msg
view =
    let
        iconHeight =
            Element.height <| Element.px 40
    in
    Element.column
        [ Region.footer
        , Background.color Colors.dark
        , Font.color Colors.light
        , Element.paddingXY 20 30
        , Element.centerX
        , Element.spacing 30
        , Element.width Element.fill
        ]
        [ Element.paragraph [ Element.centerX, Font.center ]
            [ Element.text "App desenvolvido durante a 2ª ed. do evento "
            , Element.el [ Font.bold ] <| Element.text "Semana DevSuperior"
            ]
        , Element.row [ Element.centerX, Element.spacing 20 ]
            [ Element.newTabLink []
                { url = "https://www.youtube.com/c/DevSuperior"
                , label =
                    Element.image [ iconHeight ]
                        { src = "/assets/social-media/youtube.svg"
                        , description = "Canal youtube"
                        }
                }
            , Element.newTabLink []
                { url = "https://www.linkedin.com/school/devsuperior/"
                , label =
                    Element.image [ iconHeight ]
                        { src = "/assets/social-media/linkedin.svg"
                        , description = "Perfil LinkedIn"
                        }
                }
            , Element.newTabLink []
                { url = "https://www.instagram.com/devsuperior.ig/"
                , label =
                    Element.image [ iconHeight ]
                        { src = "/assets/social-media/instagram.svg"
                        , description = "Perfil Instagram"
                        }
                }
            ]
        ]

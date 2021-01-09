module Model.Product exposing (Product, exampleProduct, exampleProduct2, formatPrice)

-- TYPE


type alias Product =
    { name : String
    , description : String
    , price : Float
    , imageUri : String
    , id : Int
    }



-- PUBLIC HELPERS


formatPrice : Float -> String
formatPrice price =
    "R$ "
        ++ String.fromFloat price
        |> addComma
        |> normalizeZeros



-- INTERNAL


addComma : String -> String
addComma price =
    if String.contains "." price then
        String.replace "." "," price

    else
        price ++ ","


normalizeZeros : String -> String
normalizeZeros price =
    let
        portions =
            String.split "," price
    in
    case ( List.head portions, List.head <| List.drop 1 portions ) of
        ( Just beforeComma, Just afterComma ) ->
            if String.length afterComma == 2 then
                beforeComma ++ "," ++ afterComma

            else if String.length afterComma < 2 then
                beforeComma ++ "," ++ afterComma ++ String.repeat (2 - String.length afterComma) "0"

            else
                beforeComma ++ "," ++ String.left 2 afterComma

        _ ->
            ""



-- TESTING


exampleProduct : Product
exampleProduct =
    { name = "Pizza Bacon"
    , description = "Pizza bacon"
    , price = 29.9
    , imageUri = "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_bacon.jpg"
    , id = 1
    }


exampleProduct2 : Product
exampleProduct2 =
    { name = "Pizza sem Bacon"
    , description = "Pizza sem bacon. Essa é uma descrição mais longa para testar o aplicativo"
    , price = 29.9
    , imageUri = "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_bacon.jpg"
    , id = 1
    }

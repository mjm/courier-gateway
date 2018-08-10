module Views.Icon exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)


type IconStyle
    = Solid
    | Brand


icon : IconStyle -> String -> Html msg
icon style name =
    span [ class "icon" ]
        [ i [ class <| (iconStyleClass style) ++ " fa-" ++ name ] [] ]


iconStyleClass : IconStyle -> String
iconStyleClass style =
    case style of
        Solid ->
            "fas"

        Brand ->
            "fab"
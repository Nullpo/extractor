module BootstrapUtils exposing (bbutton, col, footer)

import Bootstrap.Button as Button exposing (button)
import Bootstrap.Grid as Grid
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Msg exposing (Msg)

bbutton text_ style onclick =
    button [style, Button.onClick onclick] [ text text_ ]

col =
    Grid.col [] << List.singleton

footerStyle = [
        style "position" "fixed",
        style "bottom" "0",
        style "left" "auto",
        style "width" "100%",
        style "max-width" "inherit",
        style "padding-bottom" "10px",
        style "background-color" "#FAFAFA",
        style "padding-top" "20px",
        style "border-top" "#C0C0C0 solid 2px"
    ]

footer: List (Html Msg) -> Html Msg
footer fn
    = Grid.container footerStyle [
        Grid.row [] [
            Grid.col [] fn
        ]
    ]
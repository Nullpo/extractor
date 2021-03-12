module BootstrapUtils exposing (..)

import Bootstrap.Button as Button exposing (button)
import Bootstrap.Grid as Grid
import Html exposing (text)
import Html.Attributes exposing (class)

bbutton text_ style onclick =
    button [style, Button.onClick onclick] [ text text_ ]

col =
    Grid.col [] << List.singleton
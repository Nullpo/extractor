module ExtractionSum exposing (..)

import Bootstrap.Grid as Grid exposing (Column)
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import DateTimeUtils exposing (toHumanDateTime)
import ExtractionUtils exposing (isExtractionFromThisDay)
import Extraction exposing (Extraction)
import Html exposing (Html)
import Msg exposing (Msg)
import Time exposing (Posix)
import Time.Extra exposing (epoch)

amount x = x.amount

sum numericExtractions =
    Grid.col [] [Html.text ("∑ " ++ ((String.fromInt (List.foldl (+) 0 numericExtractions)) ++ " ml"))]

time now =
        Grid.col  [Col.textAlign Text.alignXsRight] [
            if (Time.Extra.compare now epoch) == EQ then
                Html.text ""
            else
                Html.text (toHumanDateTime now)
        ]



sumLastDay: Posix -> List Extraction -> List (Column Msg)
sumLastDay now extractions =
    let
        okExtractions = (List.filter (isExtractionFromThisDay now) extractions)
        numericExtractions = List.filterMap (String.toInt << amount) okExtractions
    in
    [
        sum numericExtractions,
        time now
    ]

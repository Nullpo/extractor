module ExtractionSum exposing (..)

import DateTimeUtils exposing (isExtractionFromThisDay)
import Extraction exposing (Extraction)
import Html exposing (Html)
import Msg exposing (Msg)
import Time exposing (Posix)

amount x = x.amount

sumLastDay: Posix -> List Extraction -> List (Html Msg)
sumLastDay now extractions =
    let
        okExtractions = (List.filter (isExtractionFromThisDay now) extractions)
        numericExtractions = List.filterMap (String.toInt << amount) okExtractions
    in
    [
        Html.text "Sumatoria extracciones: ",
        Html.text ((String.fromInt (List.foldl (+) 0 numericExtractions)) ++ " ml")
    ]

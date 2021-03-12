module ExtractionSumComponent exposing (..)

import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid exposing (Column)
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import BootstrapUtils exposing (col)
import DateTimeUtils exposing (toHumanDateTime)
import ExtractionUtils exposing (isExtractionFromThisDay)
import Extraction exposing (Extraction)
import Html exposing (Html, text)
import Msg exposing (ExtractionSumType(..), Msg(..))
import Time exposing (Posix)
import Time.Extra exposing (epoch)

amount x = x.amount

sumComponent numericExtractions =
    (col << Html.text) ("∑ " ++ ((String.fromInt (List.foldl (+) 0 numericExtractions)) ++ " ml"))

timeComponent now =
        Grid.col  [Col.textAlign Text.alignXsRight] [
            if (Time.Extra.compare now epoch) == EQ then
                Html.text ""
            else
                Html.text (toHumanDateTime now)
        ]

changeExpectedAmount = Change


totalExpectedComponent: Int -> Html Msg
totalExpectedComponent =
    text << (++) "x 8 = " << String.fromInt << (*) 8

expectedComponent: Int -> Column Msg
expectedComponent value =
    (col << Input.number) [
            Input.onInput (ExtractionSumMsg << changeExpectedAmount << String.toInt), Input.placeholder "ml x toma",
            Input.value (String.fromInt value)
        ]


sumLastDay: Posix -> List Extraction -> Int -> List (Column Msg)
sumLastDay now extractions expected =
    let
        okExtractions = (List.filter (isExtractionFromThisDay now) extractions)
        numericExtractions = List.filterMap (String.toInt << amount) okExtractions
    in
    [
        sumComponent numericExtractions,
        expectedComponent expected,
        col (totalExpectedComponent expected),
        timeComponent now
    ]

changeAmountPerTake: ExtractionSumType -> Int
changeAmountPerTake value =
    case value of
        Change maybeInt -> case maybeInt of
            Just a -> a
            Nothing -> 0


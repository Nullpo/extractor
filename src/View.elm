module View exposing (view)

import AppModel exposing (FullModel)
import Bootstrap.Grid as Grid
import BootstrapUtils exposing (col)
import DateTimeUtils exposing (toHtmlDateTime)
import ExtractionListComponent exposing (extractionListComponent)
import ExtractionListModel exposing (addToModel)
import ExtractionSumComponent exposing (sumLastDay)
import Html exposing (Html)
import Html.Attributes exposing (style)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (newExtractionComponent)
import Time.Extra exposing (toIso8601DateTime)

onCreate20MinutesBefore: FullModel -> Msg
onCreate20MinutesBefore model =
    let
        newDate = (toHtmlDateTime
                    << Time.Extra.addMinutes -20)
                    model.time
    in
        ExtractionListMsg (addToModel ({amount = model.view.amount, date = newDate}))

view: FullModel -> Html Msg
view model =
  let
    extractions = model.extractions
    new = model.view
    time = model.time
    expected = model.expectedAmountPerTake
    onCreate = ExtractionListMsg (addToModel new)
  in
    Html.div [] [
        Grid.container [] [
            Grid.row [] (sumLastDay time extractions expected),
            Grid.row [] [
                Grid.col [] (extractionListComponent extractions)
            ]
        ],
        footer onCreate (onCreate20MinutesBefore model)
    ]

footerStyle = [
        style "position" "absolute",
        style "bottom" "0",
        style "left" "auto",
        style "width" "100%",
        style "max-width" "inherit",
        style "padding-bottom" "10px"
    ]

footer: Msg -> Msg -> Html Msg
footer a b
    = Grid.container footerStyle [
        Grid.row [] [
            Grid.col [] (newExtractionComponent a b)
        ]
    ]
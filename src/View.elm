module View exposing (view)

import AppModel exposing (FullModel)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import BootstrapUtils exposing (col, footer)
import DateTimeUtils exposing (toHtmlDateTime)
import ExtractionListComponent exposing (extractionListComponent)
import ExtractionListModel exposing (addToModel)
import ExtractionSumComponent exposing (sumLastDay)
import Html exposing (Html, text)
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
        Grid.container [ style "margin-top" "5px", style "padding-bottom" "12em" ] [
            Grid.row [] (sumLastDay time extractions expected),
            Grid.row [] [
                Grid.col [] (extractionListComponent extractions)
            ],
            Grid.row [] [
                Grid.col [ Col.textAlign Text.alignXsCenter ] [ text "-- Fin de la lista --"]
            ]
        ],
        footer (newExtractionComponent onCreate (onCreate20MinutesBefore model))
    ]


module View exposing (view)

import AppModel exposing (FullModel)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import ExtractionListComponent exposing (extractionListComponent)
import ExtractionListModel exposing (addToModel)
import ExtractionSum exposing (sumLastDay)
import Html exposing (Html, div)
import Iso8601 exposing (fromTime, toTime)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (newExtractionComponent)
import Time
import Time.Extra exposing (toIso8601DateTime)

onCreate20MinutesBefore: FullModel -> Msg
onCreate20MinutesBefore model =
    let
        newDate = (String.slice 0 16
                    << toIso8601DateTime (Time.customZone (-3 * 60) [])
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
    onCreate = ExtractionListMsg (addToModel new)
  in
    Grid.container [] [
        Grid.row [] [
            Grid.col [] (sumLastDay time extractions)
        ],
        Grid.row [] [
            Grid.col [] (extractionListComponent extractions)
        ],
        Grid.row [] [
            Grid.col [] (newExtractionComponent onCreate (onCreate20MinutesBefore model))
        ]
    ]
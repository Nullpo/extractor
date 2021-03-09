module View exposing (view)

import AppModel exposing (FullModel)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import ExtractionListComponent exposing (extractionListComponent)
import ExtractionListModel exposing (addToModel)
import ExtractionSum exposing (sumLastDay)
import Html exposing (Html, div)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (newExtractionComponent)

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
            Grid.col [] (newExtractionComponent onCreate)
        ]
    ]
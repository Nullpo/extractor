module View exposing (view)

import AppModel exposing (FullModel)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import ExtractionListComponent exposing (extractionListComponent)
import ExtractionListModel exposing (addToModel)
import Html exposing (Html, div)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (newExtractionComponent)

view: FullModel -> Html Msg
view model =
  let
    extractions = model.extractions
    new = model.view
    onCreate = ExtractionListMsg (addToModel new)
  in
    Grid.container [] [
        CDN.stylesheet,
        Grid.row [] [
            Grid.col [] (extractionListComponent extractions)
        ],
        Grid.row [] [
            Grid.col [] (newExtractionComponent onCreate)
        ]
    ]


  --  div []
  --      (
  --          (extractionListComponent extractions) ++
  --          (newExtractionComponent onCreate)
  --      )
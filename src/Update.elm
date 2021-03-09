module Update exposing (update)

import AppModel exposing (FullModel)
import ExtractionListModel exposing (updateExtractionList)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (updateNewExtraction)
import Ports exposing (saveState)

changeAndSave msg model =
    let
        extractions = updateExtractionList msg model.extractions
    in
        ({extractions = extractions, view = model.view, time = model.time}, saveState extractions)

update: Msg -> FullModel -> (FullModel, Cmd Msg)
update msg model =
    case msg of
        ExtractionListMsg modelMsg ->
            changeAndSave modelMsg model
        ExtractionNewMsg viewMsg ->
            ({extractions = model.extractions, view = (updateNewExtraction viewMsg model.view), time = model.time}, Cmd.none)
        OnTime posix ->
            ({extractions = model.extractions, view = model.view, time = posix}, Cmd.none)

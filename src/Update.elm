module Update exposing (update)

import AppModel exposing (FullModel)
import DateTimeUtils exposing (toLocalTimezone)
import ExtractionListModel exposing (updateExtractionList)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (updateNewExtraction)
import Ports exposing (saveState)

changeAndSave msg model =
    let
        extractions = updateExtractionList msg model.extractions
    in
        (extractions, saveState { model | extractions = extractions})

update: Msg -> FullModel -> (FullModel, Cmd Msg)
update msg model =
    case msg of
        ExtractionListMsg modelMsg ->
            let
                (extractions, cmd) = changeAndSave modelMsg model
            in
                ({ model |
                    extractions = extractions,
                    error = Nothing
                }, cmd)
        ExtractionNewMsg viewMsg ->
            ({ model |
                view = (updateNewExtraction viewMsg model.view),
                error = Nothing
            }, Cmd.none)
        OnTime posix ->
            ({ model | time = toLocalTimezone posix }, Cmd.none)

-- -- Time.millisToPosix 1615284999999
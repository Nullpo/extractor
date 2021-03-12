module Update exposing (update)

import AppModel exposing (FullModel)
import DateTimeUtils exposing (toLocalTimezone)
import ExtractionListModel exposing (updateExtractionList)
import ExtractionSumComponent exposing (changeAmountPerTake)
import Msg exposing (Msg(..))
import NewExtractionComponent exposing (updateNewExtraction)
import Ports exposing (saveState)


save model =
    let
        cmd = saveState model
    in
        (model, cmd)

cleanError model =
    { model | error = Nothing }

nocmd model = (model, Cmd.none)

update: Msg -> FullModel -> (FullModel, Cmd Msg)
update msg model =
    case msg of
        ExtractionListMsg modelMsg ->
            (save << cleanError) { model | extractions = updateExtractionList modelMsg model.extractions }
        ExtractionNewMsg viewMsg ->
            (nocmd << cleanError) { model | view = (updateNewExtraction viewMsg model.view) }
        OnTime posix ->
            (nocmd) { model | time = toLocalTimezone posix }
        ExtractionSumMsg sum ->
            (save << cleanError) ({ model | expectedAmountPerTake = changeAmountPerTake sum })


-- -- Time.millisToPosix 1615284999999
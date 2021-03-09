module Init exposing (..)

import AppModel exposing (FullModel)
import Msg exposing (Msg)
import NewExtractionComponent exposing (defaultNewExtraction)
import Ports exposing (loadState)
import Time

init: Maybe String -> (FullModel, Cmd Msg)
init flags =
    let
        state =
            case flags of
                Just config -> loadState config
                Nothing -> {
                               extractions = [],
                               expectedAmountPerDay = 0,
                               error = Nothing
                           }
    in
        ({
            extractions = state.extractions,
            view = defaultNewExtraction,
            expectedAmountPerDay = state.expectedAmountPerDay,
            error = state.error,
            time = (Time.millisToPosix 0)
            }, Cmd.none)

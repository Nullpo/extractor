module Init exposing (..)

import AppModel exposing (FullModel)
import Msg exposing (Msg)
import NewExtractionComponent exposing (defaultNewExtraction)
import Ports exposing (loadState)
import Time

init: Maybe String -> (FullModel, Cmd Msg)
init flags =
    let
        extractions =
            case flags of
                Just config -> loadState config
                Nothing -> []
    in
        ({ extractions = extractions, view = defaultNewExtraction, time = (Time.millisToPosix 0) }, Cmd.none)

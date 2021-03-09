module AppModel exposing (..)

import Extraction exposing (ModelType)
import NewExtractionComponent exposing (NewExtractionModel)
import Time exposing (Posix)

type alias FullModel = {
        extractions: ModelType,
        view: NewExtractionModel,
        time: Posix
    }

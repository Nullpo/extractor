module AppModel exposing (..)

import Extraction exposing (Extraction)
import NewExtractionComponent exposing (NewExtractionModel)
import Time exposing (Posix)

type alias FullModel = {
        extractions: List Extraction,
        expectedAmountPerTake: Int,
        error: Maybe String,
        view: NewExtractionModel,
        time: Posix
    }

module AppModel exposing (..)

import Extraction exposing (ModelType)
import NewExtractionComponent exposing (NewExtractionModel)

type alias FullModel = {
        extractions: ModelType,
        view: NewExtractionModel
    }

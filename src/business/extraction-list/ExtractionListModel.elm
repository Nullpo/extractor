module ExtractionListModel exposing (addExtraction, removeExtraction, addToModel, updateExtractionList, removeFromModel)

import Extraction exposing (ModelType)
import Msg exposing (ModelMsgType(..))

excludeSameExtraction x y =
    not (x.date == y.date && x.amount == y.amount)

excludeFrom extractions extraction =
    (List.filter (excludeSameExtraction extraction)) extractions

addExtraction extractions extraction =
    extractions ++ [extraction]

removeExtraction extractions extraction =
    excludeFrom extractions extraction

addToModel = Add
removeFromModel = Remove

updateExtractionList: ModelMsgType -> ModelType -> ModelType
updateExtractionList msg model =
    let
        dummy = (Debug.toString >> (Debug.log "Hola")) msg
        dos = Debug.log "Hola" "Chau"
    in
        case msg of
        Add extraction -> addExtraction model extraction
        Remove extraction -> removeExtraction model extraction
        Load extractions -> extractions

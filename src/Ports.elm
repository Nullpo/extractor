port module Ports exposing (storeState, saveState, loadState)

import AppModel exposing (FullModel)
import Extraction exposing (Extraction, ModelType, SavedStateType, extractionsDecoder, extractionsEncoder)
import Json.Decode as Decode exposing (Decoder, decodeString, field)
import Json.Encode as Encode exposing (Value)

port storeState : String -> Cmd msg

saveState : FullModel -> Cmd msg
saveState posts =
    -- Encode.list extractionEncoder posts
    Encode.object (stateEncoder posts)
        |> Encode.encode 0
        |> storeState


stateEncoder : FullModel -> List (String, Value)
stateEncoder model =
            [
                ( "extractions", extractionsEncoder model.extractions ),
                ( "expectedAmountPerDay", Encode.int model.expectedAmountPerTake )
            ]


stateDecoder : Decoder SavedStateType
stateDecoder =
    Decode.map2 SavedStateType
        (field "extractions" extractionsDecoder)
        (field "expectedAmountPerDay" Decode.int)

loadState : String -> ModelType
loadState receivedJson =
    case decodeString stateDecoder receivedJson of
        Ok posts ->
            {
                extractions = posts.extractions,
                expectedAmountPerDay = posts.expectedAmountPerDay,
                error = Nothing
            }
        Err err ->
            {
                extractions = [],
                expectedAmountPerDay = 0,
                error = (Just << Debug.toString) err
            }

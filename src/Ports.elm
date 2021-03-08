port module Ports exposing (storeState, saveState, loadState)

import Extraction exposing (ModelType, stateDecoder, stateEncoder)
import Json.Decode exposing (decodeString)
import Json.Encode as Encode

port storeState : String -> Cmd msg

saveState : ModelType -> Cmd msg
saveState posts =
    Encode.list stateEncoder posts
        |> Encode.encode 0
        |> storeState

loadState : String -> ModelType
loadState postsJson =
    case decodeString stateDecoder postsJson of
        Ok posts ->
            posts
        Err _ ->
            []
module Extraction exposing (..)

import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode

type alias ModelType = List Extraction

stateEncoder : Extraction -> Encode.Value
stateEncoder post =
    Encode.object
        [
            ( "date", Encode.string post.date ),
            ( "amount", Encode.string post.amount )
        ]

extractionDecoder : Decoder Extraction
extractionDecoder =
    Decode.succeed Extraction
        |> required "date" string
        |> required "amount" string

stateDecoder : Decoder (List Extraction)
stateDecoder =
    list extractionDecoder

type alias Extraction =
    { date: String,
      amount: String
    }
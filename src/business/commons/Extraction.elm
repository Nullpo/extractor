module Extraction exposing (extractionsEncoder, extractionsDecoder, SavedStateType, ModelType, Extraction)

import Json.Decode as Decode exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode exposing (Value)

type alias SavedStateType = {
        extractions: List Extraction,
        expectedAmountPerDay: Int
    }

type alias ModelType = {
       extractions: List Extraction,
       expectedAmountPerDay: Int,
       error: Maybe String
   }

extractionEncoder : Extraction -> Encode.Value
extractionEncoder extraction =
    Encode.object
        [
            ( "date", Encode.string extraction.date ),
            ( "amount", Encode.string extraction.amount )
        ]

extractionsEncoder: List Extraction -> Value
extractionsEncoder extractions =
    Encode.list extractionEncoder extractions

extractionDecoder : Decoder Extraction
extractionDecoder =
    Decode.succeed Extraction
        |> required "date" string
        |> required "amount" string

extractionsDecoder : Decoder (List Extraction)
extractionsDecoder =
    list extractionDecoder

type alias Extraction =
    { date: String,
      amount: String
    }
module Msg exposing (..)
import Extraction exposing (Extraction)

type ModelMsgType = Add Extraction | Remove Extraction | Load (List Extraction)
type ViewMsgType = Date String | Amount String
type Msg = ExtractionListMsg ModelMsgType | ExtractionNewMsg ViewMsgType

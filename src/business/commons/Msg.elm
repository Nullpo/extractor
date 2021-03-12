module Msg exposing (..)
import Extraction exposing (Extraction)
import Time

type ModelMsgType = Add Extraction | Remove Extraction | Load (List Extraction)
type ViewMsgType = Date String | Amount String
type ExtractionSumType = Change (Maybe Int)

type Msg =
    ExtractionListMsg ModelMsgType
    | ExtractionNewMsg ViewMsgType
    | ExtractionSumMsg ExtractionSumType
    | OnTime Time.Posix
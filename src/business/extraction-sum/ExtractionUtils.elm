module ExtractionUtils exposing (isExtractionFromThisDay)

import DateTimeUtils exposing (getDayRange, isInRange)
import Extraction exposing (Extraction)
import Iso8601 exposing (toTime)
import Time exposing (Posix)
import Time.Extra

isExtractionFromThisDay: Posix -> Extraction -> Bool
isExtractionFromThisDay now extraction =
    case toTime (extraction.date ++ ":00") of
        Ok posixExtractionTime -> isInRange (getDayRange now) posixExtractionTime
        Err error ->
            let
                dummy = (Debug.log "Error " << Debug.toString) ({error=error, value = extraction.date})
            in False

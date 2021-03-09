module DateTimeUtils exposing (isExtractionFromThisDay)

import Extraction exposing (Extraction)
import Iso8601 exposing (toTime)
import Time exposing (Posix)
import Time.Extra

addEleven = Time.Extra.addHours 11

isAfterStart: Posix -> Bool
isAfterStart posix =
    let
        limit = addEleven (Time.Extra.startOfDay Time.utc posix)
    in
        case (Time.Extra.compare limit posix) of
            LT -> True
            EQ -> False
            GT -> False

getRangeStartingToday now =
    (
            (addEleven << Time.Extra.startOfDay Time.utc) now,
            (addEleven << Time.Extra.endOfDay Time.utc) now
    )

getRangeEndingToday now =
    getRangeStartingToday (Time.Extra.addDays -1 now)

getDayRange: Posix -> (Posix, Posix)
getDayRange now =
        case (isAfterStart now) of
            True -> getRangeStartingToday now
            False -> getRangeEndingToday now


isInRange: (Posix, Posix) -> Posix -> Bool
isInRange (start, end) extractionDate =
        (isAfter start extractionDate) && (isBefore end extractionDate)

isAfter: Posix -> Posix -> Bool
isAfter start now =
    case (Time.Extra.compare start now) of
            LT -> True
            EQ -> False
            GT -> False

isBefore: Posix -> Posix -> Bool
isBefore end now =
    case (Time.Extra.compare end now) of
            LT -> False
            EQ -> True
            GT -> True

isExtractionFromThisDay: Posix -> Extraction -> Bool
isExtractionFromThisDay now extraction =
    case toTime (extraction.date ++ ":00") of
        Ok posixExtractionTime -> isInRange (getDayRange now) posixExtractionTime
        Err error ->
            let
                dummy = (Debug.log "Error " << Debug.toString) ({error=error, value = extraction.date})
            in False

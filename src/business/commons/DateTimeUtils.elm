module DateTimeUtils exposing (toLocalTimezone, isInRange, getDayRange, toHumanDateTime, toHtmlDateTime)

import DateFormat exposing (format)
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

getRangeStartingToday: Posix -> (Posix, Posix)
getRangeStartingToday now =
    (
            (addEleven << Time.Extra.startOfDay Time.utc) now,
            (addEleven << Time.Extra.endOfDay Time.utc) now
    )

getRangeEndingToday now =
    getRangeStartingToday (Time.Extra.addDays -1 now)

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

toLocalTimezone = Time.Extra.addHours -3


toHumanDateTime: Posix -> String
toHumanDateTime = format "HH:mm dd/MM/yyyy" Time.utc

toHtmlDateTime: Posix -> String
toHtmlDateTime = format "yyyy-MM-ddTHH:mm" Time.utc

isInRange: (Posix, Posix) -> Posix -> Bool
isInRange (start, end) extractionDate =
        (isAfter start extractionDate) && (isBefore end extractionDate)

getDayRange: Posix -> (Posix, Posix)
getDayRange now =
        case (isAfterStart now) of
            True -> getRangeStartingToday now
            False -> getRangeEndingToday now
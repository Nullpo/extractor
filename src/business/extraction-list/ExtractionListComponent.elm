module ExtractionListComponent exposing (..)
import Bootstrap.Button as Button exposing (button)
import Bootstrap.Badge exposing (badgeSuccess)
import Bootstrap.Table as Table
import BootstrapUtils exposing (bbutton)
import DateFormat exposing (format)
import Extraction exposing (Extraction, ModelType)
import Html exposing (Html, text)
import ExtractionListModel exposing (removeFromModel)
import Iso8601 exposing (toTime)
import Msg exposing (Msg(..))
import Time

printExtractionList extraction =
    let
        posixTime = toTime (extraction.date ++ ":00")

        dateTime = case posixTime of
            Ok value ->
                {date = format "dd-MM" Time.utc value, time = format "HH:mm" Time.utc value}
            Err error ->
                let
                    dummy = ( (Debug.log "time") << Debug.toString) posixTime
                in
                    {date ="Error: ", time = (Debug.toString error)}
    in
    [
        Table.td [] [text dateTime.date],
        Table.td [] [text dateTime.time],
        Table.td [] [badgeSuccess [] [ text extraction.amount ]],
        Table.td [] [bbutton "Eliminar" Button.primary ((ExtractionListMsg << removeFromModel) extraction)]
    ]

extractionListComponent: ModelType -> List (Html Msg)
extractionListComponent model =
    let
        sortModel = (List.reverse << List.sortBy .date) model
    in
    [
        Table.simpleTable (
            Table.simpleThead [Table.th [] [text "Fecha"], Table.th [] [text "Hora"], Table.th [] [text "ml"], Table.th [] []],
            Table.tbody [] (List.map (Table.tr [] << printExtractionList) sortModel)
        )
    ]


    -- List.map (Grid.row [] << printExtractionList)

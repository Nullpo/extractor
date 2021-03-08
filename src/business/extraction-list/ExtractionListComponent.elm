module ExtractionListComponent exposing (..)
import Bootstrap.Button as Button exposing (button)
import Bootstrap.Badge exposing (badgeSuccess)
import Bootstrap.Table as Table
import DateFormat exposing (format)
import Extraction exposing (Extraction, ModelType)
import Html exposing (Html, text)
import ExtractionListModel exposing (removeFromModel)
import Iso8601 exposing (toTime)
import Msg exposing (Msg(..))
import Time

bbutton text_ style onclick =
    button [style, Button.onClick onclick] [ text text_ ]

printExtractionList extraction =
    let
        posixTime = toTime extraction.date
        time = case posixTime of
            Ok value ->
                format "dd-MM HH:mm" Time.utc value
            Err error ->
                let
                    dummy = (Debug.log << Debug.toString) error
                in
                    "Error"
    in
    [
        Table.td [] [text time],
        Table.td [] [badgeSuccess [] [ text extraction.amount ]],
        Table.td [] [bbutton "Eliminar" Button.primary ((ExtractionListMsg << removeFromModel) extraction)]
    ]

extractionListComponent: ModelType -> List (Html Msg)
extractionListComponent model =
    [
        Table.simpleTable (
            Table.simpleThead [Table.th [] [text "Fecha"], Table.th [] [text "ml"], Table.th [] []],
            Table.tbody [] (List.map (Table.tr [] << printExtractionList) model)
        )
    ]


    -- List.map (Grid.row [] << printExtractionList)

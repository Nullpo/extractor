module ExtractionListComponent exposing (..)
import Bootstrap.Grid as Grid exposing (Column)
import Bootstrap.Button as Button exposing (button)
import Bootstrap.Badge as Badge exposing (badgeSuccess)

import Bootstrap.Table as Table
import Extraction exposing (Extraction, ModelType)
import Html exposing (Html, text)
import ExtractionListModel exposing (removeFromModel)
import Msg exposing (Msg(..))

bbutton text_ style onclick =
    button [style, Button.onClick onclick] [ text text_ ]

printExtractionList extraction =
    [
        Table.td [] [text extraction.date],
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

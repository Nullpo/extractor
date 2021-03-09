module NewExtractionComponent exposing (newExtractionComponent, NewExtractionModel, defaultNewExtraction, updateNewExtraction)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import BootstrapUtils exposing (bbutton)
import Html exposing (Html, button, input, text)
import Html.Attributes exposing (placeholder, type_)
import Html.Events exposing (onClick, onInput)
import Msg exposing (Msg(..), ViewMsgType(..))
import Bootstrap.Form.Input as Input

type alias NewExtractionModel = {
        date: String,
        amount: String
    }

amountView = Amount
dateView = Date
defaultNewExtraction = { date = "", amount = ""}

updateNewExtraction: ViewMsgType -> NewExtractionModel -> NewExtractionModel
updateNewExtraction msg model =
    case msg of
    Date date -> { date = date, amount = model.amount }
    Amount amount -> { date = model.date, amount = amount }

dateComponent =
    (Input.datetimeLocal [ Input.onInput (ExtractionNewMsg << dateView), Input.placeholder "fecha"])

amountComponent =
    (Input.number [ Input.onInput (ExtractionNewMsg << amountView), Input.placeholder "mililitros"])

addComponent text onAddExtraction =
    bbutton text Button.primary onAddExtraction

newExtractionComponent: Msg -> Msg -> List (Html Msg)
newExtractionComponent onAddExtraction onAddDelayedExtraction =
    [
        Form.group [] [dateComponent],
        Form.group [] [amountComponent],
        Grid.row [] [
            Grid.col [Col.textAlign Text.alignXsLeft ] [addComponent "Agregar" onAddExtraction],
            Grid.col [Col.textAlign Text.alignXsRight ] [addComponent "20 mins antes" onAddDelayedExtraction]
        ]
    ]


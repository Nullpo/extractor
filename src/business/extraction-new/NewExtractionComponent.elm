module NewExtractionComponent exposing (newExtractionComponent, NewExtractionModel, defaultNewExtraction, updateNewExtraction)

import Bootstrap.Form as Form
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

addComponent onAddExtraction =
    (button [ onClick onAddExtraction ] [ text "Agregar" ])

newExtractionComponent: Msg -> List (Html Msg)
newExtractionComponent onAddExtraction =
    [
        Form.group [] [dateComponent],
        Form.group [] [amountComponent],
        Form.group [] [addComponent onAddExtraction]
    ]


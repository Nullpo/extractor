module Main exposing (..)
import AppModel exposing (FullModel)
import Browser
import Init exposing (init)
import Msg exposing (Msg(..))
import Time
import Update exposing (update)
import View exposing (view)

main : Program (Maybe String) FullModel Msg
main =
  Browser.element {
            init = init,
            update = update,
            view = view,
            subscriptions = subscriptions
        }

subscriptions : FullModel -> Sub Msg
subscriptions model =
  Time.every 1000 OnTime

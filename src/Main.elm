-- port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CssModules exposing (css)
import Json.Decode as Decode
import Json.Encode as Encode


styles =
    css "../style.css" -- relative to main Elm source directory
        { list = "list" -- string value should match CSS class name 
        ,another = "another"
        }
main =
  Browser.element {init = init, update = update, view = view, subscriptions = subscriptions}


-- MODEL

type alias ToDo = 
    {description: String
    ,completed: Bool
    ,editing: Bool
    ,id: Int}

type alias Model = 
  {
    entries: List ToDo
    ,inputText: String
  }
init : () -> (Model, Cmd msg)
init _ =
    ({entries = []
    ,inputText=""}
      -- [Just {
      -- description="hahaha"
      -- ,completed= False
      -- ,editing=False 
      -- ,id=1},
      -- Just {
      -- description="xixixi"
      -- ,completed= False
      -- ,editing=False 
      -- ,id=2}
      -- ]
      ,Cmd.none)


-- UPDATE

type Msg = AddEntry String
  |InputText String

update :  Msg->Model->(Model, Cmd msg)
update msg model=
  case msg of 
    AddEntry string ->
      let 
        entry = 
          {description=string
          ,completed= False
          ,editing=False 
          ,id=1}
      in
        ({model | entries = entry::model.entries},Cmd.none)
    InputText string ->
      ({model| inputText = string},Cmd.none)
-- VIEW

view : Model -> Html Msg
view model =
        
        -- Debug.log (Debug.toString (styles.class .list))
        div[][
          div[][
            input[type_ "text", name "things to do", onInput InputText, onEnter (AddEntry model.inputText)][]
            ,button[onClick (AddEntry model.inputText)][text "Add"]
          ]
          --below cannot be written as ui[][List.map xxxx], has to use <|.
          ,ul[styles.class .list] <| 
            List.map (\entry -> 
                        -- case entry of 
                        --   Just a ->
                            li[][text entry.description]
                          -- Nothing ->
                          --   li[][text "nothing"]
                            ) model.entries
        ]
     
    
subscriptions : Model -> Sub msg
subscriptions model = 
  Sub.none

--Helper

onEnter: msg -> Attribute msg
onEnter msg=
  keyCode
    |> Decode.andThen
      (\key ->
        if key == 13 then
          Decode.succeed msg
        else
          Decode.fail "not enter"
      )
    |> on "keyup"

-- port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import CssModules exposing (css)


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

type alias Model = List (Maybe ToDo)
init : () -> (Model, Cmd msg)
init _ =
  ([] 
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
       (Just entry::model, Cmd.none)
-- VIEW

view : Model -> Html Msg
view todolist =
        --below cannot be written as ui[][List.map xxxx], has to use <|.
        -- Debug.log (Debug.toString (styles.class .list))
        div[][
          div[][
            input[type_ "text", name "things to do"][]
            ,button[onClick (AddEntry "newitem")][text "Add"]
          ]
          ,ul[styles.class .list] <| 
            List.map (\x -> 
                        case x of 
                          Just a ->
                            li[][text a.description]
                          Nothing ->
                            li[][]) todolist
        ]
     
    
subscriptions : Model -> Sub msg
subscriptions model = 
  Sub.none
-- 
-- import Browser
-- import Html exposing (..)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (onInput, onClick)



-- -- MAIN


-- main =
--   Browser.sandbox { init = init, update = update, view = view }



-- -- MODEL


-- type alias Model =
--   { name : String
--   , password : String
--   , passwordAgain : String
--   , age : Int
--   , isOk : String
--   }


-- init : Model
-- init =
--   Model "" "" "" 0 ""



-- -- UPDATE


-- type Msg
--   = Name String
--   | Password String
--   | PasswordAgain String
--   | Age String
--   | IsOk String


-- update : Msg -> Model -> Model
-- update msg model =
--   case msg of
--     Name name ->
--       { model | name = name }

--     Password password ->
--       { model | password = password }

--     PasswordAgain password ->
--       { model | passwordAgain = password }

--     Age age ->
--       { model | age = Maybe.withDefault 0 (String.toInt age) }

--     IsOk string ->
--       { model | isOk = string}


-- -- VIEW


-- view : Model -> Html Msg
-- view model =
--   div []
--     [ div []
--       [ viewInput "text" "Name" model.name Name
--       , viewInput "text" "Age" (String.fromInt model.age) Age
--       , viewInput "password" "Password" model.password Password
--       , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
--       , viewInput ""
--       ]
--     , button [onClick IsOk] [text "Submit"]]
    


-- viewInput : String -> String -> String -> (String -> msg) -> Html msg
-- viewInput t p v toMsg =
--   input [ type_ t, placeholder p, value v, onInput toMsg ] []


-- viewValidation : Model -> Html msg
-- viewValidation model =
--   if model.password == model.passwordAgain then
--     div [ style "color" "green" ] [ text "OK" ]
--   else
--     div [ style "color" "red" ] [ text "Passwords do not match!" ]

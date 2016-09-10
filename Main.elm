module Main exposing (..)

import Html exposing (..)
import Html.App exposing (program)
import Html.Attributes exposing (src, title, class, id, type')
import Html.Events exposing (on)
import Json.Decode as JD
import Ports exposing (ImagePortData, fileSelected, fileContentRead)

type Msg
  = ImageSelected
  | ImageRead ImagePortData

type alias Image =
  { contents : String
  , filename : String
  }

type alias Model =
  { id : String
  , mImage : Maybe Image
  }

main : Program Never
main =
  program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

init : ( Model, Cmd Msg )
init =
  ( { id = "ImageInputId"
    , mImage = Nothing
    }
  , Cmd.none
  )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ImageSelected ->
      ( model
      , fileSelected model.id
      )
    ImageRead data ->
      let
        newImage =
          { contents = data.contents
          , filename = data.filename
          }
      in
        ( { model | mImage = Just newImage }
        , Cmd.none
        )

view : Model -> Html Msg
view model =
  let
    imagePreview =
      case model.mImage of
        Just i ->
          viewImagePreview i
        Nothing ->
          text ""
  in
    div [ class "imageWrapper" ]
      [ input
        [ type' "file"
        , id model.id
        , on "change"
          (JD.succeed ImageSelected)
        ]
        []
      , imagePreview
      ]

viewImagePreview : Image -> Html Msg
viewImagePreview image =
  img
    [ src image.contents
    , title image.filename
    ]
    []

subscriptions : Model -> Sub Msg
subscriptions model =
 fileContentRead ImageRead

module Main exposing
    ( Image
    , Model
    , Msg(..)
    , init
    , main
    , subscriptions
    , update
    , view
    , viewImagePreview
    )

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, id, src, title, type_)
import Html.Events exposing (on)
import Json.Decode as JD
import Ports exposing (ImagePortData, fileContentRead, fileSelected)


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


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : flags -> ( Model, Cmd Msg )
init _ =
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
            [ type_ "file"
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

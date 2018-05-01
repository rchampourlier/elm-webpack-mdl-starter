module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Button as Button
import Material.Options as Options


-- component import example

import Components.Hello exposing (hello)


-- APP


main : Program Never Model Msg
main =
    Html.program { init = ( initModel, Cmd.none ), view = view, update = update, subscriptions = Material.subscriptions Mdl }



-- MODEL


type alias Model =
    { value : Int
    , mdl : Material.Model
    }


initModel : Model
initModel =
    { value = 0
    , mdl = Material.model
    }



-- UPDATE


type Msg
    = NoOp
    | Increment
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            let
                newValue =
                    model.value + 1
            in
                ( { model | value = newValue }, Cmd.none )

        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ -- inline CSS (literal)
          div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "jumbotron" ]
                    [ img [ src "static/img/elm.jpg", style styles.img ] [] -- inline CSS (via var)
                    , hello model.value
                    , p [] [ text ("Elm Webpack Starter") ]
                    ]
                , div []
                    [ Button.render Mdl
                        [ 0 ]
                        model.mdl
                        [ Button.raised
                        , Options.onClick Increment
                        ]
                        [ text "Increment" ]
                    ]
                ]
            ]
        ]



-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }

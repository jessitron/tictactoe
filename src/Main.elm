module Main exposing (main)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


type Move
    = X
    | O


type TicTacToe
    = TicTacToe ( ( Maybe Move, Maybe Move, Maybe Move ), ( Maybe Move, Maybe Move, Maybe Move ), ( Maybe Move, Maybe Move, Maybe Move ) )


type Msg
    = MakeMove ( Int, Int ) Move


type alias Model =
    TicTacToe


emptyBoard : TicTacToe
emptyBoard =
    TicTacToe
        ( ( Nothing, Nothing, Nothing )
        , ( Nothing, Nothing, Nothing )
        , ( Nothing, Nothing, Nothing )
        )


update : Msg -> Model -> Model
update msg ((TicTacToe ( ( a1, a2, a3 ), brow, crow )) as model) =
    case msg of
        MakeMove ( 1, 1 ) move ->
            TicTacToe ( ( Just move, a2, a3 ), brow, crow )

        _ ->
            model


draw : Maybe Move -> Html msg
draw move =
    case move of
        Nothing ->
            Html.text ""

        Just xo ->
            xo |> toString |> Html.text


cellStyle =
    style [ ( "border", "1px solid rebeccapurple" ) ]


borderStyle =
    style [ ( "border", "1px solid black" ) ]


view : TicTacToe -> Html Msg
view (TicTacToe board) =
    case board of
        ( ( a1, a2, a3 ), ( b1, b2, b3 ), ( c1, c2, c3 ) ) ->
            Html.table [ borderStyle ]
                [ Html.tr []
                    [ Html.td
                        [ onClick (MakeMove ( 1, 1 ) X)
                        , cellStyle
                        ]
                        [ draw a1 ]
                    , Html.td [ onClick (MakeMove ( 1, 1 ) O), cellStyle ] [ draw a2 ]
                    , Html.td [ cellStyle ] [ draw a3 ]
                    ]
                , Html.tr []
                    [ Html.td [ cellStyle ] [ draw b1 ]
                    , Html.td [ cellStyle ] [ draw b2 ]
                    , Html.td [ cellStyle ] [ draw b3 ]
                    ]
                , Html.tr []
                    [ Html.td [ cellStyle ] [ draw c1 ]
                    , Html.td [ cellStyle ] [ draw c2 ]
                    , Html.td [ cellStyle ] [ draw c3 ]
                    ]
                ]


main =
    Html.beginnerProgram
        { model = emptyBoard
        , update = update
        , view = view
        }

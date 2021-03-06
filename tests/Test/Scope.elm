module Test.Scope exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Vm.Scope as Scope
    exposing
        ( Scope
        , Binding(..)
        )
import Vm.Type as Type


scopes : Test
scopes =
    describe "Commands that get or set variables"
        [ describe "make"
            [ test "sets variable in root scope" <|
                \_ ->
                    let
                        scope =
                            Scope.empty
                                |> Scope.make "x" (Type.Word "word")
                    in
                        scope
                            |> Scope.thing "x"
                            |> Expect.equal (Just <| Defined <| Type.Word "word")
            ]
        , describe "local"
            [ test "sets variable in local scope" <|
                \_ ->
                    let
                        scope =
                            Scope.empty
                                |> Scope.pushLocalScope 0
                                |> Scope.local "x"
                    in
                        scope
                            |> Scope.thing "x"
                            |> Expect.equal (Just Undefined)
            ]
        ]

(************************************************************************************)
(* The MIT License (MIT)                                                            *)
(*                                                                                  *)
(* Copyright (c) 2015 Jeremy Letang (letang.jeremy@gmail.com)                       *)
(*                                                                                  *)
(* Permission is hereby granted, free of charge, to any person obtaining a copy of  *)
(* this software and associated documentation files (the "Software"), to deal in    *)
(* the Software without restriction, including without limitation the rights to     *)
(* use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of *)
(* the Software, and to permit persons to whom the Software is furnished to do so,  *)
(* subject to the following conditions:                                             *)
(*                                                                                  *)
(* The above copyright notice and this permission notice shall be included in all   *)
(* copies or substantial portions of the Software.                                  *)
(*                                                                                  *)
(* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR       *)
(* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS *)
(* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR   *)
(* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER   *)
(* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN          *)
(* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.       *)
(************************************************************************************)

open OUnit
open Http
open Bytes

let test_from_string _ =
    assert_equal Method.Get (Method.from_string "GET");
    assert_equal Method.Post (Method.from_string "Post");
    assert_equal (Method.Unknown "hello") (Method.from_string "hello");
;;

let test_to_string _ =
    assert_equal "GET" (Method.to_string Method.Get);
    assert_equal "hello" (Method.to_string (Method.Unknown "hello"));
;;

let test_is_safe _ =
    assert_equal true (Method.is_safe Method.Get);
    assert_equal true (Method.is_safe Method.Head);
    assert_equal true (Method.is_safe Method.Options);
    assert_equal true (Method.is_safe Method.Trace);
;;

let test_is_not_safe _ =
    assert_equal false (Method.is_safe Method.Post);
    assert_equal false (Method.is_safe Method.Put);
    assert_equal false (Method.is_safe Method.Patch);
    assert_equal false (Method.is_safe Method.Delete);
    assert_equal false (Method.is_safe Method.Connect);
    assert_equal false (Method.is_safe (Method.Unknown "blah"));
;;

let test_is_idempotent _ =
    assert_equal true (Method.is_idempotent Method.Get);
    assert_equal true (Method.is_idempotent Method.Head);
    assert_equal true (Method.is_idempotent Method.Options);
    assert_equal true (Method.is_idempotent Method.Trace);
    assert_equal true (Method.is_idempotent Method.Post);
    assert_equal true (Method.is_idempotent Method.Delete);
;;

let test_is_not_idempotent _ =
    assert_equal false (Method.is_idempotent Method.Patch);
    assert_equal false (Method.is_idempotent Method.Put);
    assert_equal false (Method.is_idempotent Method.Connect);
    assert_equal false (Method.is_idempotent (Method.Unknown "blah"));
;;

let suite = "Http.Method suite" >::: ["test_from_string" >:: test_from_string;
                                      "test_to_string" >:: test_to_string;
                                      "test_is_safe" >:: test_is_safe;
                                      "test_is_not_safe" >:: test_is_not_safe;
                                      "test_is_idempotent" >:: test_is_idempotent;
                                      "test_is_not_idempotent" >:: test_is_not_idempotent]

let _ =
  run_test_tt_main suite
;;

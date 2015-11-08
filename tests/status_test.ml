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

let test_of_int _ =
  assert_equal Status.NotFound (Status.of_int 404);
  assert_equal (Status.Unknown 2000) (Status.of_int 2000);
;;

let test_is_informational _ =
    assert_equal true (Status.is_informational Status.Processing);
    assert_equal false (Status.is_informational Status.NotFound);
;;

let test_is_success _ =
    assert_equal true (Status.is_success Status.Accepted);
    assert_equal false (Status.is_success Status.InternalServerError);
;;

let test_is_redirection _ =
    assert_equal true (Status.is_redirection Status.UseProxy);
    assert_equal false (Status.is_redirection Status.NotFound);
;;

let test_is_client_error _ =
    assert_equal true (Status.is_client_error Status.NotFound);
    assert_equal false (Status.is_client_error Status.Processing);
;;

let test_is_server_error _ =
    assert_equal true (Status.is_server_error Status.BadGateway);
    assert_equal false (Status.is_server_error Status.NotFound);
;;

let suite = "Http.Status suite" >::: ["test_of_int" >:: test_of_int;
                                      "test_is_informational" >:: test_is_informational;
                                      "test_is_success" >:: test_is_success;
                                      "test_is_redirection" >:: test_is_redirection;
                                      "test_is_client_error" >:: test_is_client_error;
                                      "test_is_server_error" >:: test_is_server_error]

let _ =
  run_test_tt_main suite
;;

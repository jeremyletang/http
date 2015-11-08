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

open Bytes
open OUnit
open Http

let test_http_version_of_string_valid_11 _ =
  assert_equal (Some Version.Http11) (Version.of_bytes "http/1.1");;
let test_http_version_of_string_valid_11_capitalized _ =
  assert_equal (Some Version.Http11) (Version.of_bytes "HTTP/1.1");;
let test_http_version_of_string_valid_10 _ =
  assert_equal (Some Version.Http10) (Version.of_bytes "http/1.0");;
let test_http_version_of_string_invalid _ =
  assert_equal None (Version.of_bytes "BLAH");;

let suite = "Http.Version suite" >::: ["test_http_version_of_string_valid_11" >:: test_http_version_of_string_valid_11;
                                      "test_http_version_of_string_valid_11_capitalized" >:: test_http_version_of_string_valid_11_capitalized;
                                      "test_http_version_of_string_valid_10" >:: test_http_version_of_string_valid_10;
                                      "test_http_version_of_string_invalid" >:: test_http_version_of_string_invalid]

let _ =
  run_test_tt_main suite
;;
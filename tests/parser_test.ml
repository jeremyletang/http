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
open List

let ok_req = Bytes.of_string
"GET / HTTP/1.1\r\nHost: localhost:8080\r
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r
Cookie: _ga=GA1.1.644163142.1438692001\r
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.5.17\r
Accept-Language: en-us\r
Accept-Encoding: gzip, deflate\r
Connection: keep-alive\r
\r
hello world";;


let test_split_empty _ = assert_equal 0 (List.length (Parser.split ""));;
let test_split_long _ = assert_equal 10 (List.length (Parser.split ok_req));;
let test_split_short _ = assert_equal 1 (List.length (Parser.split "GET /home HTTP/1.1\r\n"));;
let test_split_crlf_only _ = assert_equal 1 (List.length (Parser.split "\r\n"));;
let test_split_cr_only _ = assert_equal 1 (List.length (Parser.split "\r"));;

let test_make_headers _ =
  assert_equal 7 (List.length (Parser.make_headers (Parser.split ok_req)));;

let test_make_headers_empty _ =
  assert_equal 0 (List.length (Parser.make_headers (Parser.split "")));;

let test_remove_crlf_prefix_mixed _ =
  assert_equal "GET / HTTP/1.1\r\n" (Parser.remove_crlf_prefix "\r\n\r\n\r\nGET / HTTP/1.1\r\n");;
let test_remove_crlf_prefix_empty _ = assert_equal "" (Parser.remove_crlf_prefix "");;
let test_remove_crlf_prefix_dont_remove_lf _ = assert_equal "\n" (Parser.remove_crlf_prefix "\n");;
let test_remove_only_crlf_prefix _ = assert_equal "" (Parser.remove_crlf_prefix "\r\n");;
let test_remove_crlf_prefix_with_only_lf_prefix_do_nothing _ =
  assert_equal "\nGET / HTTP/1.1\r\n" (Parser.remove_crlf_prefix "\nGET / HTTP/1.1\r\n");;

let test_remove_lf_prefix_multiple _ =
  assert_equal "GET / HTTP/1.1\r\n" (Parser.remove_lf_prefix "\n\n\n\nGET / HTTP/1.1\r\n");;
let test_remove_lf_prefix_one _ = assert_equal "" (Parser.remove_lf_prefix "\n");;
let test_remove_lf_prefix_empty _ = assert_equal "" (Parser.remove_lf_prefix "");;
let test_remove_lf_prefix_on_crlf_only_fo_nothing _ =
  assert_equal "\r\n" (Parser.remove_lf_prefix "\r\n");;
let test_remove_lf_prefix_on_valid_request_with_crlf_prefix _ =
  assert_equal "\r\nGET / HTTP/1.1\r\n" (Parser.remove_lf_prefix "\r\nGET / HTTP/1.1\r\n");;

let test_remove_blank_prefix_mixed _ =
  assert_equal "GET / HTTP/1.1\r\n" (Parser.remove_blank_prefix "\r\n\n\r\n\n\nGET / HTTP/1.1\r\n");;
let test_remove_blank_prefix_only_lf _ = assert_equal "" (Parser.remove_blank_prefix "\n");;
let test_remove_blank_prefix_empty _ =  assert_equal "" (Parser.remove_blank_prefix "");;
let test_remove_blank_prefix_long_empty _ =
  assert_equal "" (Parser.remove_blank_prefix "\n\r\n\r\n\r\n\n");;
let test_remove_blank_prefix_only_crlf _ =  assert_equal "" (Parser.remove_blank_prefix "\r\n");;
let test_remove_blank_prefix_simple_crlf _ =
  assert_equal "GET / HTTP/1.1\r\n" (Parser.remove_blank_prefix "\r\nGET / HTTP/1.1\r\n");;

let test_build_request_line_valid_ok _ =
  let ok1 = Parser.split "GET /home HTTP/1.1\r\n" in
  assert_equal (Some "GET", Some "/home", Some "HTTP/1.1") (Parser.build_request_line ok1);;
let test_build_request_line_valid_ok_sanitized _ =
  let ok2 = Parser.split "GET     /home      HTTP/1.1\r\n" in
  assert_equal (Some "GET", Some "/home", Some "HTTP/1.1") (Parser.build_request_line ok2);;
let test_build_request_line_not_ok_version_invalid _ =
  let not_ok1 = Parser.split "GET /home \r\n" in
  assert_equal (Some "GET", Some "/home", None) (Parser.build_request_line not_ok1);;
let test_build_request_line_not_ok_version_path_invalid _ =
  let not_ok2 = Parser.split "GET     \r\n" in
  assert_equal (Some "GET", None, None) (Parser.build_request_line not_ok2);;
let test_build_request_line_not_ok_nothing_valid _ =
  let not_ok3 = Parser.split "   \r\n" in
  assert_equal (None, None, None) (Parser.build_request_line not_ok3);;
let test_build_request_line_nothing_valid_empty _ =
  let not_ok4 = Parser.split "" in
  assert_equal (None, None, None) (Parser.build_request_line not_ok4);;

let test_make_body _ =
  let b = Parser.make_body (Parser.split (Parser.remove_blank_prefix ok_req)) in
  assert_equal (Some "hello world") b;
;;

let suite = "Http.Parser suite" >::: ["test_split_empty" >:: test_split_empty;
                                      "test_split_long" >:: test_split_long;
                                      "test_split_short" >:: test_split_short;
                                      "test_split_crlf_only" >:: test_split_crlf_only;
                                      "test_split_cr_only" >:: test_split_cr_only;
                                      "test_make_headers" >:: test_make_headers;
                                      "test_make_headers_empty" >:: test_make_headers_empty;
                                      "test_remove_crlf_prefix_mixed" >:: test_remove_crlf_prefix_mixed;
                                      "test_remove_crlf_prefix_empty" >:: test_remove_crlf_prefix_empty;
                                      "test_remove_crlf_prefix_dont_remove_lf" >:: test_remove_crlf_prefix_dont_remove_lf;
                                      "test_remove_only_crlf_prefix" >:: test_remove_only_crlf_prefix;
                                      "test_remove_crlf_prefix_with_only_lf_prefix_do_nothing" >:: test_remove_crlf_prefix_with_only_lf_prefix_do_nothing;
                                      "test_remove_lf_prefix_multiple" >:: test_remove_lf_prefix_multiple;
                                      "test_remove_lf_prefix_one" >:: test_remove_lf_prefix_one;
                                      "test_remove_lf_prefix_empty" >:: test_remove_lf_prefix_empty;
                                      "test_remove_lf_prefix_on_crlf_only_fo_nothing" >:: test_remove_lf_prefix_on_crlf_only_fo_nothing;
                                      "test_remove_lf_prefix_on_valid_request_with_crlf_prefix" >:: test_remove_lf_prefix_on_valid_request_with_crlf_prefix;
                                      "test_remove_blank_prefix_mixed" >:: test_remove_blank_prefix_mixed;
                                      "test_remove_blank_prefix_only_lf" >:: test_remove_blank_prefix_only_lf;
                                      "test_remove_blank_prefix_empty" >:: test_remove_blank_prefix_empty;
                                      "test_remove_blank_prefix_long_empty" >:: test_remove_blank_prefix_long_empty;
                                      "test_remove_blank_prefix_only_crlf" >:: test_remove_blank_prefix_only_crlf;
                                      "test_remove_blank_prefix_simple_crlf" >:: test_remove_blank_prefix_simple_crlf;
                                      "test_build_request_line_valid_ok" >:: test_build_request_line_valid_ok;
                                      "test_build_request_line_valid_ok_sanitized" >:: test_build_request_line_valid_ok_sanitized;
                                      "test_build_request_line_not_ok_version_invalid" >:: test_build_request_line_not_ok_version_invalid;
                                      "test_build_request_line_not_ok_version_path_invalid" >:: test_build_request_line_not_ok_version_path_invalid;
                                      "test_build_request_line_not_ok_nothing_valid" >:: test_build_request_line_not_ok_nothing_valid;
                                      "test_build_request_line_nothing_valid_empty" >:: test_build_request_line_nothing_valid_empty;
                                      "test_make_body" >:: test_make_body]


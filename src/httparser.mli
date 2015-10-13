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

type http_version = Http10 | Http11

type request =
  { verb : string option; path : string option; version : http_version option;
    headers : (string * string) list; body : bytes option }

type response =
  { code: int option; reason: string option; version: string option;
    headers: (string * string) list; body: bytes option }

(* Split the request in line with \r\n as delimiter *)
val split : bytes -> bytes list

(* Remove blank lines before begining of the content *)
val remove_blank_prefix : bytes -> bytes
(* Remove lines containing only \r\n before the begining of the content *)
val remove_crlf_prefix : bytes -> bytes
(* Remove line scontaining only \n before the begining of the content *)
val remove_lf_prefix : bytes -> bytes

(* Create an http_version from a string *)
val http_version_of_bytes : bytes -> http_version option

(* Retrieve information from the request first line: verb, path, version *)
val build_request_line : bytes list -> string option * string option * string option

(* Create a list which contains all the headers from the request/response as a list of key, value *)
val make_headers : bytes list -> (bytes * bytes) list

(* Make the request / reponse body *)
val make_body : bytes list ->  bytes option

(* Create a new request from a bytes buffer *)
val make_request : bytes -> request

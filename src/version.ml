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

type t = Http09 | Http10 | Http11 | Http20

let of_bytes buf =
  match Bytes.uppercase buf with
  | "HTTP/0.9" -> Some Http09
  | "HTTP/1.0" -> Some Http10
  | "HTTP/1.1" -> Some Http11
  | "HTTP/2.0" -> Some Http20
  | _ -> None
;;

let of_string = function
  | "HTTP/0.9" -> Some Http09
  | "HTTP/1.0" -> Some Http10
  | "HTTP/1.1" -> Some Http11
  | "HTTP/2.0" -> Some Http20
  | _ -> None
;;

let as_string = function
  | Http09 -> "HTTP/0.9"
  | Http10 -> "HTTP/1.0"
  | Http11 -> "HTTP/1.1"
  | Http20 -> "HTTP/2.0"
;;

let is_valid v = match of_string v with
  | Some _ -> true
  | _ -> false
;;
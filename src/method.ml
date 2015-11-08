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

open String

type t = Options | Get | Head | Post | Put | Delete | Trace | Connect | Patch | Unknown of string

let of_string s =
  match String.uppercase s with
  | "OPTIONS" -> Options
  | "GET" -> Get
  | "HEAD" -> Head
  | "POST" -> Post
  | "PUT" -> Put
  | "DELETE" -> Delete
  | "TRACE" -> Trace
  | "CONNECT" -> Connect
  | "PATCH" -> Patch
  | _ -> Unknown s
;;

let to_string = function
  | Options -> "OPTIONS"
  | Get -> "GET"
  | Head -> "HEAD"
  | Post -> "POST"
  | Put -> "PUT"
  | Delete -> "DELETE"
  | Trace -> "TRACE"
  | Connect -> "CONNECT"
  | Patch -> "PATCH"
  | Unknown s -> s
;;

let is_safe = function
  | Get | Head | Options | Trace -> true
  | _ -> false
;;

let is_idempotent = function
  | Get | Head | Options | Trace| Post | Delete -> true
  | _ -> false
;;

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
open Printf
open List

let cr = '\r';;
let ln = '\n';;
let crlf = Bytes.of_string "\r\n";;

type http_version = Http10 | Http11

type request =
  { verb : string option; path : string option; version : http_version option;
    headers : (string * string) list; body : string option }

type response =
  { code: int option; reason: string option; version: string option;
    headers: (string * string) list; body: string option }

let rec remove_crlf_prefix buf =
  let len = Bytes.length buf in
  if len >= 2 then
    if Bytes.get buf 0 == '\r' && Bytes.get buf 1 == '\n' then
      remove_crlf_prefix (Bytes.sub buf 2 (len - 2))
    else buf
  else buf
;;

let rec remove_lf_prefix buf =
  let len = Bytes.length buf in
  if len >= 1 then
    if Bytes.get buf 0 == '\n' then remove_lf_prefix (Bytes.sub buf 1 (len - 1))
    else buf
  else buf
;;

let rec remove_blank_prefix buf =
  let len = Bytes.length buf in
  let cleaned = remove_crlf_prefix (remove_lf_prefix buf) in
  match Bytes.length cleaned with
  | l when l == len -> cleaned
  | _ -> remove_blank_prefix cleaned
;;

let split buf =
  let split_if_next buf lst from =
    let cr_pos = Bytes.index_from buf from '\r' in
    let lf_pos = Bytes.index_from buf from '\n' in
    let len = Bytes.length buf in
    if lf_pos == (cr_pos + 1) then
      if lf_pos + 1 > len then "", (Bytes.sub buf 0 (lf_pos - 1)) :: lst, 0
      else Bytes.sub buf (lf_pos + 1) (len - (lf_pos + 1)), (Bytes.sub buf 0 (lf_pos - 1)) :: lst, 0
    else buf, lst, lf_pos + 1
  in
  let rec split_ buf lst from =
    if Bytes.length buf > 0 && Bytes.contains_from buf from '\r' && Bytes.contains_from buf from '\n' then
      match split_if_next buf lst from with a, b, c -> split_ a b c
    else match Bytes.length buf with 0 -> lst | _ -> buf :: lst
  in List.rev (split_ buf [] 0)
;;

let make_headers raw =
  let rec make_headers_rec raw hds =
    match raw with
    | hd::tl ->
      if Bytes.contains hd ':' then
        let i = Bytes.index hd ':' in
        let k = Bytes.sub hd 0 i in
        let v = Bytes.sub hd i ((Bytes.length hd) - i) in
        make_headers_rec tl ((Bytes.trim k, Bytes.trim v) :: hds)
      else if Bytes.length hd == 0 then hds
      else make_headers_rec tl hds
    | [] -> hds
  in List.rev (make_headers_rec raw [])
;;

let http_version_of_bytes buf =
  match Bytes.uppercase buf with
  | "HTTP/1.1" -> Some Http11
  | "HTTP/1.0" -> Some Http10
  | _ -> None
;;

let build_request_line raw_list =
  let split_first_token buf =
    let len = Bytes.length buf in
    match Bytes.contains buf ' ' with
    | true ->
      let idx = Bytes.index buf ' ' in
      Some (Bytes.sub buf 0 (idx)), Bytes.sub buf idx (len - idx)
    | _ ->
      (match len with
       | 0 -> None, ""
       | _ -> Some (Bytes.sub buf 0 len), "")
  in
  match raw_list with
  | hd::tl ->
    let verb, rest = split_first_token (Bytes.trim hd) in
    let path, rest = split_first_token (Bytes.trim rest) in
    let version = match Bytes.trim rest with "" -> None | v -> Some v in
    verb, path, version
  | [] -> None, None, None
;;

let make_body raw_list =
  (* List.iter (printf "%s") raw_list; *)
  let rec skip_headers = function
    | [] -> []
    | hd::tl when Bytes.length hd == 0 -> tl
    | _::tl -> skip_headers tl
  in match skip_headers raw_list with [] -> None | hd::_ -> Some hd
;;

let make_request buf =
  let raw_list = split (remove_blank_prefix buf) in
  let verb, path, version = build_request_line raw_list in
  let headers = make_headers raw_list in
  let body = make_body raw_list in

  let real_version = match version with
  | Some v -> http_version_of_bytes v
  | None -> None
  in

  { verb = verb; path = path; version = real_version; headers = headers; body = body }
;;


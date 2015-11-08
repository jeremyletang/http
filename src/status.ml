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

type t =
  (* 1xx Informational *)
  | Continue (* 100 *)
  | SwitchingProtocols (* 101 *)
  | Processing (* 102 *)
  (* 2xx Success *)
  | Ok (* 200 *)
  | Created (* 201 *)
  | Accepted (* 202 *)
  | NonAuthoritativeInformation (* 203 *)
  | NoContent (* 204 *)
  | ResetContent (* 205 *)
  | PartialContent (* 206 *)
  | MultiStatus (* 207 *)
  | AlreadyReported (* 208 *)
  | IMUsed (* 226 *)
  (* 3xx Redirection *)
  | MultipleChoices (* 300 *)
  | MovedPermanently (* 301 *)
  | Found (* 302 *)
  | SeeOther (* 303 *)
  | NotModified (* 304 *)
  | UseProxy (* 305 *)
  | SwitchProxy (* 306 *)
  | TemporaryRedirect (* 307 *)
  | PermanentRedirect (* 308 *)
  (* 4xx Client Error *)
  | BadRequest (* 400 *)
  | Unauthorized (* 401 *)
  | PaymentRequired (* 402 *)
  | Forbidden (* 403 *)
  | NotFound (* 404 *)
  | MethodNotAllowed (* 405 *)
  | NotAcceptable (* 406 *)
  | ProxyAuthenticationRequired (* 407 *)
  | RequestTimeout (* 408 *)
  | Conflict (* 409 *)
  | Gone (* 410 *)
  | LengthRequired (* 411 *)
  | PreconditionFailed (* 412 *)
  | PayloadTooLarge (* 413 *)
  | RequestURITooLong (* 414 *)
  | UnsupportedMediaType (* 415 *)
  | RequestedRangeNotSatisfiable (* 416 *)
  | ExpectationFailed (* 417 *)
  | ImATeapot (* 418 *)
  | AuthenticationTimeout (* 419 *)
  | MisdirectedRequest (* 421 *)
  | UnprocessableEntity (* 422 *)
  | Locked (* 423 *)
  | FailedDependency (* 424 *)
  | UpgradeRequired (* 426 *)
  | PreconditionRequired (* 428 *)
  | TooManyRequests (* 429 *)
  | RequestHeaderFieldsTooLarge (* 431 *)
  | UnavailableForLegalReasons (* 451 *)
  (* 5xx Server Error *)
  | InternalServerError (* 500 *)
  | NotImplemented (* 501 *)
  | BadGateway (* 502 *)
  | ServiceUnavailable (* 503 *)
  | GatewayTimeout (* 504 *)
  | HTTPVersionNotSupported (* 505 *)
  | VariantAlsoNegotiates (* 506 *)
  | InsufficientStorage (* 507 *)
  | LoopDetected (* 508 *)
  | NotExtended (* 510 *)
  | NetworkAuthenticationRequired (* 511 *)
  | UnknownError (* 520 *)
  | OriginConnectionTimeOut (* 522 *)
  | NetworkReadTimeoutError (* 598 *)
  | NetworkConnectTimeoutError (* 599 *)
  (* Others *)
  | Unknown of int

let of_int = function
  | 100 -> Continue
  | 101 -> SwitchingProtocols
  | 102 -> Processing
  | 200 -> Ok
  | 201 -> Created
  | 202 -> Accepted
  | 203 -> NonAuthoritativeInformation
  | 204 -> NoContent
  | 205 -> ResetContent
  | 206 -> PartialContent
  | 207 -> MultiStatus
  | 208 -> AlreadyReported
  | 226 -> IMUsed
  | 300 -> MultipleChoices
  | 301 -> MovedPermanently
  | 302 -> Found
  | 303 -> SeeOther
  | 304 -> NotModified
  | 305 -> UseProxy
  | 306 -> SwitchProxy
  | 307 -> TemporaryRedirect
  | 308 -> PermanentRedirect
  | 400 -> BadRequest
  | 401 -> Unauthorized
  | 402 -> PaymentRequired
  | 403 -> Forbidden
  | 404 -> NotFound
  | 405 -> MethodNotAllowed
  | 406 -> NotAcceptable
  | 407 -> ProxyAuthenticationRequired
  | 408 -> RequestTimeout
  | 409 -> Conflict
  | 410 -> Gone
  | 411 -> LengthRequired
  | 412 -> PreconditionFailed
  | 413 -> PayloadTooLarge
  | 414 -> RequestURITooLong
  | 415 -> UnsupportedMediaType
  | 416 -> RequestedRangeNotSatisfiable
  | 417 -> ExpectationFailed
  | 418 -> ImATeapot
  | 419 -> AuthenticationTimeout
  | 421 -> MisdirectedRequest
  | 422 -> UnprocessableEntity
  | 423 -> Locked
  | 424 -> FailedDependency
  | 426 -> UpgradeRequired
  | 428 -> PreconditionRequired
  | 429 -> TooManyRequests
  | 431 -> RequestHeaderFieldsTooLarge
  | 451 -> UnavailableForLegalReasons
  | 500 -> InternalServerError
  | 501 -> NotImplemented
  | 502 -> BadGateway
  | 503 -> ServiceUnavailable
  | 504 -> GatewayTimeout
  | 505 -> HTTPVersionNotSupported
  | 506 -> VariantAlsoNegotiates
  | 507 -> InsufficientStorage
  | 508 -> LoopDetected
  | 510 -> NotExtended
  | 511 -> NetworkAuthenticationRequired
  | 520 -> UnknownError
  | 522 -> OriginConnectionTimeOut
  | 598 -> NetworkReadTimeoutError
  | 599 -> NetworkConnectTimeoutError
  | c -> Unknown c
;;

let as_int = function
  | Continue -> 100
  | SwitchingProtocols -> 101
  | Processing -> 102
  | Ok -> 200
  | Created -> 201
  | Accepted -> 202
  | NonAuthoritativeInformation -> 203
  | NoContent -> 204
  | ResetContent -> 205
  | PartialContent -> 206
  | MultiStatus -> 207
  | AlreadyReported -> 208
  | IMUsed -> 226
  | MultipleChoices -> 300
  | MovedPermanently -> 301
  | Found -> 302
  | SeeOther -> 303
  | NotModified -> 304
  | UseProxy -> 305
  | SwitchProxy -> 306
  | TemporaryRedirect -> 307
  | PermanentRedirect -> 308
  | BadRequest -> 400
  | Unauthorized -> 401
  | PaymentRequired -> 402
  | Forbidden -> 403
  | NotFound -> 404
  | MethodNotAllowed -> 405
  | NotAcceptable -> 406
  | ProxyAuthenticationRequired -> 407
  | RequestTimeout -> 408
  | Conflict -> 409
  | Gone -> 410
  | LengthRequired -> 411
  | PreconditionFailed -> 412
  | PayloadTooLarge -> 413
  | RequestURITooLong -> 414
  | UnsupportedMediaType -> 415
  | RequestedRangeNotSatisfiable -> 416
  | ExpectationFailed -> 417
  | ImATeapot -> 418
  | AuthenticationTimeout -> 419
  | MisdirectedRequest -> 421
  | UnprocessableEntity -> 422
  | Locked -> 423
  | FailedDependency -> 424
  | UpgradeRequired -> 426
  | PreconditionRequired -> 428
  | TooManyRequests -> 429
  | RequestHeaderFieldsTooLarge -> 431
  | UnavailableForLegalReasons -> 451
  | InternalServerError -> 500
  | NotImplemented -> 501
  | BadGateway -> 502
  | ServiceUnavailable -> 503
  | GatewayTimeout -> 504
  | HTTPVersionNotSupported -> 505
  | VariantAlsoNegotiates -> 506
  | InsufficientStorage -> 507
  | LoopDetected -> 508
  | NotExtended -> 510
  | NetworkAuthenticationRequired -> 511
  | UnknownError -> 520
  | OriginConnectionTimeOut -> 522
  | NetworkReadTimeoutError -> 598
  | NetworkConnectTimeoutError -> 599
  | Unknown c -> c
;;

let as_string = function
  | Continue -> "Continue"
  | SwitchingProtocols -> "Switching Protocols"
  | Processing -> "Processing"
  | Ok -> "Ok"
  | Created -> "Created"
  | Accepted -> "Accepted"
  | NonAuthoritativeInformation -> "Non Authoritative Information"
  | NoContent -> "No Content"
  | ResetContent -> "Reset Content"
  | PartialContent -> "Partial Content"
  | MultiStatus -> "Multi Status"
  | AlreadyReported -> "Already Reported"
  | IMUsed -> "IM Used"
  | MultipleChoices -> "Multiple Choices"
  | MovedPermanently -> "Moved Permanently"
  | Found -> "Found"
  | SeeOther -> "See Other"
  | NotModified -> "Not Modified"
  | UseProxy -> "Use Proxy"
  | SwitchProxy -> "Switch Proxy"
  | TemporaryRedirect -> "Temporary Redirect"
  | PermanentRedirect -> "Permanent Redirect"
  | BadRequest -> "Bad Request"
  | Unauthorized -> "Unauthorized"
  | PaymentRequired -> "Payment Required"
  | Forbidden -> "Forbidden"
  | NotFound -> "Not Found"
  | MethodNotAllowed -> "Method Not Allowed"
  | NotAcceptable -> "Not Acceptable"
  | ProxyAuthenticationRequired -> "Proxy Authentication Required"
  | RequestTimeout -> "Request Timeout"
  | Conflict -> "Conflict"
  | Gone -> "Gone"
  | LengthRequired -> "Length Required"
  | PreconditionFailed -> "Precondition Failed"
  | PayloadTooLarge -> "Payload Too Large"
  | RequestURITooLong -> "Request URI Too Long"
  | UnsupportedMediaType -> "Unsupported Media Type"
  | RequestedRangeNotSatisfiable -> "Requested Range Not Satisfiable"
  | ExpectationFailed -> "Expectation Failed"
  | ImATeapot -> "I'm a Teapot"
  | AuthenticationTimeout -> "Authentication Timeout"
  | MisdirectedRequest -> "MisdirectedRequest"
  | UnprocessableEntity -> "Unprocessable Entity"
  | Locked -> "Locked"
  | FailedDependency -> "FailedDependency"
  | UpgradeRequired -> "UpgradeRequired"
  | PreconditionRequired -> "Precondition Required"
  | TooManyRequests -> "Too Many Requests"
  | RequestHeaderFieldsTooLarge -> "Request Header Fields Too Large"
  | UnavailableForLegalReasons -> "Unavailable For Legal Reasons"
  | InternalServerError -> "Internal Server Error"
  | NotImplemented -> "Not Implemented"
  | BadGateway -> "Bad Gateway"
  | ServiceUnavailable -> "Service Unavailable"
  | GatewayTimeout -> "Gateway Timeout"
  | HTTPVersionNotSupported -> "HTTP Version Not Supported"
  | VariantAlsoNegotiates -> "Variant Also Negotiates"
  | InsufficientStorage -> "Insufficient Storage"
  | LoopDetected -> "Loop Detected"
  | NotExtended -> "Not Extended"
  | NetworkAuthenticationRequired -> "Network Authentication Required"
  | UnknownError -> "Unknown Error"
  | OriginConnectionTimeOut -> "Origin Connection Time Out"
  | NetworkReadTimeoutError -> "Network Read Timeout Error"
  | NetworkConnectTimeoutError -> "Network Connect Timeout Error"
  | Unknown c -> string_of_int c
;;

let is_informational = function
  | c when as_int c >= as_int Continue && as_int c <= as_int Processing -> true
  | _ -> false
;;

let is_success = function
  | c when as_int c >= as_int Ok && as_int c <= as_int IMUsed -> true
  | _ -> false
;;

let is_redirection = function
  | c when as_int c >= as_int MultipleChoices && as_int c <= as_int PermanentRedirect -> true
  | _ -> false
;;

let is_client_error = function
  | c when as_int c >= as_int BadRequest && as_int c <= as_int UnavailableForLegalReasons -> true
  | _ -> false
;;

let is_server_error = function
  | c when as_int c >= as_int InternalServerError && as_int c <= as_int NetworkConnectTimeoutError -> true
  | _ -> false
;;
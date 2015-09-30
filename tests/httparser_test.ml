open OUnit
open Httparser

let test_f test_ctx =
    assert_equal 42 (Httparser.f 40 2)
;;

let suite = "OUnit Example" >::: ["test_f" >:: test_f]

let _ =
    run_test_tt_main suite
;;

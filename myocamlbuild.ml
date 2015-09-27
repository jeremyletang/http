open Ocamlbuild_plugin
open Command

let () =
  dispatch begin function
  | After_rules -> ocaml_lib ~extern:true ~dir:"+OUnit" "ounit";
  | _ -> ()
  end
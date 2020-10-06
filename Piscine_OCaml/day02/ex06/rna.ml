type phosphate = string
type deoxyribose = string
type nucleobase = A | T | C | G | U | None
type nucleotide = {
  phosphate: phosphate;
  deoxyribose: deoxyribose;
  nucleobase: nucleobase
}
type helix = nucleotide list
type rna = nucleobase

let generate_nucleotide (c:char) :nucleotide =
  let set_nucleobase =
    match c with
    | 'A' -> A
    | 'T' -> T
    | 'C' -> C
    | 'G' -> G
    | 'U' -> U
    | _ -> None
  in {
    phosphate = "phosphate";
    deoxyribose = "deoxyribose";
    nucleobase = set_nucleobase
  }

let nucleobase_value n =
  match n with
  | A -> "A"
  | T -> "T"
  | C -> "C"
  | G -> "G"
  | U -> "U"
  | _ -> "None"

let stringify_nucleotide nuc =
  "phosphate: " ^ nuc.phosphate ^ "\ndeoxyribose: " ^ nuc.deoxyribose ^ "\n" ^ "nucleobase: " ^ (nucleobase_value nuc.nucleobase)
 
let generate_helix n = 
  let rand_nucleotide rand =
    match rand with
    | 0 -> 'A'
    | 1 -> 'T'
    | 2 -> 'C'
    | 3 -> 'G'
    | _ -> 'U'
  in
  let rec loop_create_helix ?(index=0) lst = 
    match index with
    | x when index = n -> lst
    | _ -> loop_create_helix ~index:(index + 1) (lst @ [generate_nucleotide (rand_nucleotide (Random.int 4))])
  in
  match n with
  | x when x < 0 -> []
  | _ -> loop_create_helix []

let complementary_helix helix =
  let associat_nucleobase nucleobase =
    match nucleobase with
    | A -> 'T'
    | T -> 'A'
    | C -> 'G'
    | G -> 'C'
    | _ -> 'U'
  in
  let rec loop_read_helix helix lst =
    match helix with
    | [] -> lst
    | s::q -> loop_read_helix q (lst @ [generate_nucleotide (associat_nucleobase s.nucleobase)])
  in
  loop_read_helix helix []

let rec stringify_helix ?(str="") helix =
  match helix with
  | [] -> str
  | s::q -> stringify_helix ~str:(str ^ (stringify_nucleotide s) ^ "\n") q

let generate_rna helix =
  let select_rna nucleobase =
    match nucleobase with
    | A -> U
    | T -> A
    | C -> G
    | G -> C
    | _ -> None
  in
  let rec create_rna ?(lst=[]) helix =
    match helix with
    | [] -> lst
    | s::q -> create_rna ~lst:(lst @ [select_rna s.nucleobase]) q
  in
  create_rna helix

let rec stringify_rna ?(str="") rna =
  match rna with
  | [] -> str
  | s::q -> stringify_rna ~str:(str ^ (nucleobase_value s)) q

let rec generate_helix_by_char ?(lst=[]) c =
  match c with
  | [] -> lst
  | s::q -> generate_helix_by_char ~lst:(lst @ [generate_nucleotide s]) q

let main () =
  Random.self_init ();
  print_endline (stringify_rna (generate_rna (generate_helix_by_char ['A';'T';'C';'G';'A'])))

let () = main ()

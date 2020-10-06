type phosphate = string
type deoxyribose = string
type nucleobase = A | T | C | G | U | None
type nucleotide = {
  phosphate: phosphate;
  deoxyribose: deoxyribose;
  nucleobase: nucleobase
}
type helix = nucleotide list

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

let stringify_nucleotide nuc =
  let nucleobase_value n = match n with
  | A -> "A"
  | T -> "T"
  | C -> "C"
  | G -> "G"
  | U -> "U"
  | _ -> "None"
  in
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
    | []    -> str
    | s::q  -> stringify_helix ~str:(str ^ (stringify_nucleotide s) ^ "\n") q

let main () =
  Random.self_init ();
  print_endline (stringify_helix (generate_helix (-1)));
  print_endline (stringify_helix (generate_helix 0));
  print_endline (stringify_helix (generate_helix 2));
  print_endline (stringify_helix (generate_helix 3));
  let helixs = (generate_helix 5) in
    print_endline "complementary test:";
    print_endline (stringify_helix helixs);
    print_endline (stringify_helix (complementary_helix helixs))

let () = main ()

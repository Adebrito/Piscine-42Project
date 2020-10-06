type phosphate = string
type deoxyribose = string
type nucleobase = A | T | C | G | U | None
type nucleotide = {
  phosphate: phosphate;
  deoxyribose: deoxyribose;
  nucleobase: nucleobase
}

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


let () =
  print_endline (stringify_nucleotide (generate_nucleotide 'a'));
  print_endline (stringify_nucleotide (generate_nucleotide 'A'));
  print_endline (stringify_nucleotide (generate_nucleotide 'C'));
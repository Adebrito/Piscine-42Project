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
type aminoacid = Stop | Ala | Arg | Asn | Asp | Cys | Gln | Glu | Gly | His | Ile | Leu | Lys | Met | Phe | Pro | Ser | Thr | Trp | Tyr | Val
type protein = aminoacid list 

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
  let rand_nucleotide =
    function
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

let associat_nucleobase nucleobase =
  match nucleobase with
  | A -> 'T'
  | T -> 'A'
  | C -> 'G'
  | G -> 'C'
  | _ -> 'U'

let rec complementary_helix ?(lst=[]) helix =
  match helix with
  | [] -> lst
  | s::q -> complementary_helix ~lst:(lst @ [generate_nucleotide (associat_nucleobase s.nucleobase)]) q

let rec stringify_helix ?(str="") helix =
  match helix with
  | [] -> str
  | s::q -> stringify_helix ~str:(str ^ (stringify_nucleotide s) ^ "\n") q

let select_rna nucleobase =
  match nucleobase with
  | A -> U
  | T -> A
  | C -> G
  | G -> C
  | _ -> None

let rec generate_bases_triplets ?(lst=[]) rna =
  match rna with
  | rna1::rna2::rna3::q -> generate_bases_triplets ~lst:(lst @ [(rna1, rna2, rna3)]) q
  | _ -> lst

let rec generate_rna ?(lst=[]) helix =
  match helix with
  | [] -> lst
  | s::q -> generate_rna ~lst:(lst @ [select_rna s.nucleobase]) q

let rec stringify_rna ?(str="") rna =
  match rna with
  | [] -> str
  | s::q -> stringify_rna ~str:(str ^ (nucleobase_value s)) q

let rec generate_helix_by_char ?(lst=[]) c =
  match c with
  | [] -> lst
  | s::q -> generate_helix_by_char ~lst:(lst @ [generate_nucleotide s]) q

let string_of_aminoacid aminoacid =
  match aminoacid with
  | Stop -> "End of translation"
  | Ala  -> "Alanine"
  | Arg  -> "Arginine"
  | Asn  -> "Asparagine"
  | Asp  -> "Aspartique"
  | Cys  -> "Cysteine"
  | Gln  -> "Glutamine"
  | Glu  -> "Glutamique"
  | Gly  -> "Glycine"
  | His  -> "Histidine"
  | Ile  -> "Isoleucine"
  | Leu  -> "Leucine"
  | Lys  -> "Lysine"
  | Met  -> "Methionine"
  | Phe  -> "Phenylalanine"
  | Pro  -> "Proline"
  | Ser  -> "Serine"
  | Thr  -> "Threonine"
  | Trp  -> "Tryptophane"
  | Tyr  -> "Tyrosine"
  | Val  -> "Valine"

let stringify_triplets (rna1, rna2, rna3) = (nucleobase_value rna1) ^ (nucleobase_value rna2) ^ (nucleobase_value rna3) ^ " "

let rec string_of_triplets ?(str="") triplets =
  match triplets with
  | [] -> str
  | s::q -> string_of_triplets ~str:(str ^ (stringify_triplets s)) q

let rec string_of_protein ?(str="") protein =
    match protein with
    | [] -> str
    | s::q -> string_of_protein ~str:(str ^ (string_of_aminoacid s ) ^ " ") q

let rec create_protein ?(lst=[]) rna =
  match rna with
  | rna1::rna2::rna3::q when rna1 = (U, A, A) && rna2 = (U, A, G) && rna3 = (U, G, A) -> lst @ [Stop]
  | rna1::rna2::rna3::rna4::q when rna1 = (G, C, A) && rna2 = (G, C, C) && rna3 = (G, C, G) && rna4 = (G, C, U) -> create_protein ~lst:(lst @ [Ala]) q
  | rna1::rna2::rna3::rna4::rna5::rna6::q when rna1 = (A, G, A) && rna2 = (A, G, G) && rna3 = (C, G, A) && rna4 = (C, G, C) && rna5 = (C, G, G) && rna6 = (C, G, U) -> create_protein ~lst:(lst @ [Arg]) q
  | rna1::rna2::q when rna1 = (A, C, C) && rna2 = (A, A, U) -> create_protein ~lst:(lst @ [Asn]) q
  | rna1::rna2::q when rna1 = (G, A, C) && rna2 = (G, A, U) -> create_protein ~lst:(lst @ [Asp]) q
  | rna1::rna2::q when rna1 = (U, G, C) && rna2 = (U, G, U) -> create_protein ~lst:(lst @ [Cys]) q
  | rna1::rna2::q when rna1 = (C, A, A) && rna2 = (C, A, G) -> create_protein ~lst:(lst @ [Gln]) q
  | rna1::rna2::q when rna1 = (C, A, A) && rna2 = (G, A, G) -> create_protein ~lst:(lst @ [Glu]) q
  | rna1::rna2::rna3::rna4::q when rna1 = (G, G, A) && rna2 = (G, G, C) && rna3 = (G, G, G) && rna4 = (G, G, U) -> create_protein ~lst:(lst @ [Gly]) q
  | rna1::rna2::q when rna1 = (C, A, C) && rna2 = (C, A, U) -> create_protein ~lst:(lst @ [His]) q
  | rna1::rna2::rna3::q when rna1 = (A, U, A) && rna2 = (A, U, C) && rna3 = (A, U, U) -> lst @ [Ile]
  | rna1::rna2::rna3::rna4::rna5::rna6::q when rna1 = (C, U, A) && rna2 = (C, U, C) && rna3 = (C, U, G) && rna4 = (C, U, U) && rna5 = (U, U, A) && rna6 = (U, U, G) -> create_protein ~lst:(lst @ [Leu]) q
  | rna1::rna2::q when rna1 = (A, A, A) && rna2 = (A, A, G) -> create_protein ~lst:(lst @ [Lys]) q
  | rna1::q when rna1 = (A, U, G) -> create_protein ~lst:(lst @ [Met]) q
  | rna1::rna2::q when rna1 = (U, U, C) && rna2 = (U, U, U) -> create_protein ~lst:(lst @ [Phe]) q
  | rna1::rna2::rna3::rna4::q when rna1 = (C, C, C) && rna2 = (C, C, A) && rna3 = (C, C, G) && rna4 = (C, C, U) -> create_protein ~lst:(lst @ [Pro]) q
  | rna1::rna2::rna3::rna4::rna5::rna6::q when rna1 = (U, C, A) && rna2 = (U, C, C) && rna3 = (U, C, G) && rna4 = (U, C, U) && rna5 = (A, G, U) && rna6 = (A, G, C) -> create_protein ~lst:(lst @ [Ser]) q
  | rna1::rna2::rna3::rna4::q when rna1 = (A, C, A) && rna2 = (A, C, C) && rna3 = (A, C, G) && rna4 = (A, C, U) -> create_protein ~lst:(lst @ [Thr]) q
  | rna1::q when rna1 = (U, G, G) -> create_protein ~lst:(lst @ [Trp]) q
  | rna1::rna2::q when rna1 = (U, A, C) && rna2 = (U, A, U) -> create_protein ~lst:(lst @ [Tyr]) q
  | rna1::rna2::rna3::rna4::q when rna1 = (G, U, A) && rna2 = (G, U, C) && rna3 = (G, U, G) && rna4 = (G, U, U) -> create_protein ~lst:(lst @ [Val]) q
  | _ -> lst

(* let rec helix_of_string ?(helix=[]) str =
  match str with
  | "" -> helix
  | s::q -> helix_of_string ~helix:(helix @ generate_helix_by_char [((char_of_string s))]) q *)

let helix_of_string str =
  let len = String.length str
  in    
    let rec aux ?(helix=[]) index =
      match index with
      | x when len = index -> helix
      | _ -> aux ~helix:(helix @ (generate_helix_by_char [str.[index]])) (index + 1)
    in
  aux 0

let life str = 
  let helix = (helix_of_string str) in
    print_endline ("--------- HELIX ---------\n" ^ stringify_helix helix);
    let rna = (generate_rna helix) in
      print_endline ("--------- rna ---------\n" ^ stringify_rna rna);
      let triplets = (generate_bases_triplets rna) in
        print_endline ("--------- TRIPLETS ---------\n" ^ string_of_triplets triplets);
        let protein = (create_protein triplets) in
          print_endline ("--------- PROTEINS ---------\n" ^ string_of_protein protein)

let main () =
  Random.self_init ();
  life "";
  life "CATCAGCACCAATACTACATTATCACT"

let () = main ()
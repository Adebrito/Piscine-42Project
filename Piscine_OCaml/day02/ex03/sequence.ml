let sequence n =
  let rec processing lst count acc =
    match lst with
    | [] -> acc
    | previous::current::next when previous = current -> (processing (current::next) (count + 1) acc)
    | previous::current::next ->  (processing (current::next) 0 (acc @ [((count + 1), previous)]))
    | current::next -> (processing (next) 0 (acc @ [((count + 1), current)]))
  in
  let lst_to_tuple (a,b) = [(string_of_int a);b] in
  let rec create_new_lst lst_processing new_lst =
    match lst_processing with
    | [] -> new_lst
    | s::q -> (create_new_lst q (new_lst @ (lst_to_tuple s)))
  in
  let rec processing_string final_lst str =
    match final_lst with
    | [] -> str
    | s::q -> processing_string q (str ^ s)
  in
  let rec sequence_aux index lst =
    match index with
    | x when x = n -> processing_string lst ""
    | _ -> sequence_aux (index + 1) (create_new_lst (processing lst 0 []) [])
  in
  match n with
  | x when x < 0 -> ""
  | _ -> sequence_aux 0 ["1"]

let main () =
  print_endline (sequence (-42));
  print_endline (sequence 0);
  print_endline (sequence 1);
  print_endline (sequence 2);
  print_endline (sequence 3);
  print_endline (sequence 4);
  print_endline (sequence 5);
  print_endline (sequence 6);
  print_endline (sequence 7)

let () = main ()
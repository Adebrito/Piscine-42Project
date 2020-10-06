let encode lst =
  let rec processing lst count acc =
    match lst with
    | [] -> acc
    | previous::current::next when previous = current -> (processing (current::next) (count + 1) acc)
    | previous::current::next ->  (processing (current::next) 0 (acc @ [((count + 1), previous)]))
    | current::next -> (processing (next) 0 (acc @ [((count + 1), current)]))
  in
  processing lst 0 []

let main () =
  let print_tuple_string (a, b) = print_string "("; print_int a; print_string ", "; print_string (b ^ ") " ) in
  let print_tuple_int (a, b) = print_string "("; print_int a; print_string ", "; print_string ((string_of_int b) ^ ") " ) in
  let rec print f lst =
    match lst with
    | [] -> print_string "\n"
    | s::q -> f s; print f q
  in
  print print_tuple_string (encode ["a"; "a"; "a"; "a"; "b"; "b"; "b"; "c"]);
  print print_tuple_int (encode [ 1; 1; 1; 1; 2; 2; 2; 42])
let () = main()

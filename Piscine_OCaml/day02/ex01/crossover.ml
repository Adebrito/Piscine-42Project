let crossover lst_a lst_b =
  let rec find el search_in =
    match search_in with
    | [] -> false
    | s::q -> (s = el) || find el q
  in
  let rec compare lst acc =
    match lst with
    | [] -> acc
    | current::next when (find current lst_b) && not (find current acc) -> (compare (next) (acc @ [(current)]))
    | current::next -> (compare (next) acc)
  in
  compare lst_a []

let main () =
  let print_crossover_string lst =
    print_string "(";
    let rec print lst = 
      match lst with
      | s::q when (q <> []) -> print_string ("\"" ^ s ^ "\",");  print q;
      | s::q -> print_string ("\"" ^ s ^ "\"");  print q;
      | [] -> print_string ")\n"
    in
    print lst
  in

  let print_crossover_int lst =
    print_string "(";
    let rec print lst = 
      match lst with
      | s::q when (q <> []) -> print_string ("\"" ^ (string_of_int s) ^ "\",");  print q;
      | s::q -> print_string ("\"" ^ (string_of_int s) ^ "\"");  print q;
      | [] -> print_string ")\n"
    in
    print lst
  in

  print_crossover_string (crossover ["a"; "a"; "b"; "c"] [ "a"; "c"]);
  print_crossover_string (crossover ["a"; "a"; ""; "c"; "d"] [ "a"; ""; "c"; "b"; "d"]);
  print_crossover_int (crossover [10; 1; 20; 25] [ 10; 10; 25; 42]);
  print_crossover_int (crossover [10; 10; 20; 25] [])

let () = main()

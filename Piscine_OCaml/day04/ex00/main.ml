let () =
  let rec print lst =
    match lst with
    | [] -> ()
    | s::q -> print_string ((Color.toStringVerbose s) ^ " : " ^ (Color.toString s) ^ "\n"); print q
  in
  print Color.all
  
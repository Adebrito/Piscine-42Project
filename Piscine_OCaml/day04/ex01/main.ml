let () = 
  let rec print lst =
    match lst with
    | [] -> ()
    | s::q -> print_string ("value nb :" ^ (string_of_int (Value.toInt s)) ^ " -> " ^ (Value.toStringVerbose s) ^ " : " ^ (Value.toString s) ^ "\n"); print q
  in
  print Value.all;

  print_endline ("previous T13 " ^ (Value.toStringVerbose (Value.previous Value.As)));
  print_endline ("next T2 " ^ (Value.toStringVerbose (Value.next Value.T2)));

  try
    print_endline ("previous T2 " ^ (Value.toStringVerbose (Value.previous Value.T2)))
  with e -> 
    print_endline ("There was an error: " ^ (Printexc.to_string e));
  try
    print_endline ("next T13 " ^ (Value.toStringVerbose (Value.next Value.As)))
  with e -> 
    print_endline ("There was an error: " ^ (Printexc.to_string e));

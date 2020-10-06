let iter f x n =
  let rec shedule_fun i a = if n = i then a else shedule_fun (i + 1) (f a) in
  if n < 0 then -1
  else if n = 0 then x
  else shedule_fun 0 x

let main () =
  print_endline (string_of_int (iter (fun x -> x * x) 2 4));
  print_endline (string_of_int (iter (fun x -> x * 2) 2 4));
  print_endline (string_of_int (iter (fun x -> x * x) 42 0));
  print_endline (string_of_int (iter (fun x -> x + x) 1 10));
  print_endline (string_of_int (iter (fun x -> x + x) 1 (-10)))

let () = main()

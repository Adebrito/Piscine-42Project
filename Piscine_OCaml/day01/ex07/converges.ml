let converges f x n =
  let rec shedule_fun i a a2 =
    if a = a2 then true
    else if n < i then false
    else shedule_fun (i + 1) (f a) (a)
  in
      
  if n <= 0 then false
  else shedule_fun 0 x 0

let main () =
  print_endline (string_of_bool (converges (( * ) 2) 2 5));
  print_endline (string_of_bool (converges (fun x -> x / 2) 2 3));
  print_endline (string_of_bool (converges (fun x -> x / 2) 2 2))

let () = main()
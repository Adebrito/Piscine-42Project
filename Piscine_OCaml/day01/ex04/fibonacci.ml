let fibonacci n = 
	let rec cal index acc1 acc2 =
    if index <= 0 then acc1 else cal (index - 1) (acc2) (acc1 + acc2)
  in 
	cal n 0 1

let main () =
  print_endline (string_of_int (fibonacci 0));
  print_endline (string_of_int (fibonacci 1));
  print_endline (string_of_int (fibonacci 2));
  print_endline (string_of_int (fibonacci 5));
  print_endline (string_of_int (fibonacci 7));
  print_endline (string_of_int (fibonacci 9));
  print_endline (string_of_int (fibonacci 11));
  print_endline (string_of_int (fibonacci 16))

let () = main()
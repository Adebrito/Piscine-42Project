let repeat_x n =
  let rec print_x ?(str="") index =
    if index = 0
      then str
      else print_x ~str:(str ^ "x") (index - 1)
  in
  if n < 0
    then "ERROR"
    else print_x n

let main () =
  print_endline (repeat_x 1 );
  print_endline (repeat_x (-27));
  print_endline (repeat_x 0 );
  print_endline (repeat_x 10 )

let () = main()
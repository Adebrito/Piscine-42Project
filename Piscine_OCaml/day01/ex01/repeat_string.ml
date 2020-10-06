let repeat_string ?(str="x") n =
  let rec print ?(tmp="") index =
    if index = 0
      then tmp
      else print ~tmp:(tmp ^ str) (index - 1)
  in
  if n < 0
    then "ERROR"
    else print n

let main () =
  print_endline (repeat_string ~str:"Toto" 2 );
  print_endline (repeat_string (-27));
  print_endline (repeat_string 2 );
  print_endline (repeat_string ~str:"what" 10 )

let () = main()
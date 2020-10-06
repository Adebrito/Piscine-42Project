

let ft_rot_n n src =
  let trim x max =
    if x > max
    then (x - 26)
    else x
  in
  let rot c =
    let new_c = char_of_int ((int_of_char c) + (n mod 26)) in
    if (c >= 'A' && c <= 'Z')
      then char_of_int (trim (int_of_char new_c) (int_of_char 'Z'))
    else if (c >= 'a' && c <= 'z')
      then char_of_int (trim (int_of_char new_c) (int_of_char 'z'))
    else c
  in
  String.map rot src

let main () =
  print_endline (ft_rot_n 1 "abcdefghijklmnopqrstuvwxyz");
  print_endline (ft_rot_n 27 "abcdefghijklmnopqrstuvwxyz");
  print_endline (ft_rot_n 0 "abcdefghijklmnopqrstuvwxyz");
  print_endline (ft_rot_n 2 "OI2EAS67B9");
  print_endline (ft_rot_n 1 "");
  print_endline (ft_rot_n 1 "NBzlk qnbjr ");
  print_endline (ft_rot_n 13 "SALUT TOI")

let () = main()
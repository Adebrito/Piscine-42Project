

let ft_print_comb2 () =
  let first_digit = 0 in
  let second_digit = first_digit + 1 in
  let format_print_nb nb =
    if nb < 10
      then print_int 0;
    print_int nb
  in
  let rec print_comb fd sd =
    format_print_nb fd; print_char ' '; format_print_nb sd;
    if fd < 98 then
      begin
        print_string ", ";
        if sd < 99 then
          print_comb fd (sd + 1)
        else
          print_comb (fd + 1) (fd + 2)
      end
  in
  print_comb first_digit second_digit;
  print_string "\n"

let main () =
  ft_print_comb2 ()

let () = main()
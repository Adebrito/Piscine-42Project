let ft_print_comb () =
  let first_digit = 0 in
  let second_digit = first_digit + 1 in
  let third_digit = second_digit + 1 in
  let rec print_comb fd sd td =
    print_int fd; print_int sd; print_int td;
    if fd < 7 then
      begin
        print_string ", ";
        if td < 9 then
          print_comb fd sd (td + 1)
        else if sd < 8 then
          print_comb fd (sd + 1) (sd + 2)
        else print_comb (fd + 1) (fd + 2) (fd + 3)
      end
  in
  print_comb first_digit second_digit third_digit;
  print_string "\n"

let main () =
  ft_print_comb ()

let () = main()
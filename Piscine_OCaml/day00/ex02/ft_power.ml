let rec ft_power x power =
  if power < 1
  then 1
  else x * ft_power x (power - 1)

  let main () =
  begin
    print_string "test [2, 4]  :";
    print_int (ft_power 2 4);
    print_char '\n';

    print_string "test [3, 0]  :";
    print_int (ft_power 3 0);
    print_char '\n';

    print_string "test [0, 5]  :";
    print_int (ft_power 0 5);
    print_char '\n';

    print_string "test [42, 1] :";
    print_int (ft_power 42 1);
    print_char '\n';
  end

let () = main()
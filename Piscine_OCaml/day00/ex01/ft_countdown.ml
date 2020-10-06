let rec ft_countdown x =
  if x <= 0
  then
    begin
      print_int 0;
      print_char '\n'
    end
  else
    begin
      print_int x ;
      print_char '\n';
      ft_countdown (x - 1)
    end

let main () =
  begin
    print_endline "test [5]:";
    ft_countdown (5);
    print_endline "test [-42]:";
    ft_countdown (-42);
    print_endline "test [0]:";
    ft_countdown (0)
  end

let () = main()
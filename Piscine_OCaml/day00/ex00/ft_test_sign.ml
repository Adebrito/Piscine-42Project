let ft_test_sign x =
  if x >= 0
  then print_endline "positive"
  else print_endline "negative"
  
let main () =
  begin
    ft_test_sign (42);
    ft_test_sign (-42);
    ft_test_sign (0)
  end

let () = main()
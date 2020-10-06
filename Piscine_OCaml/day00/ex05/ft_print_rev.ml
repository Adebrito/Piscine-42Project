let ft_print_rev src =
  let len = String.length src in
  let rec print_rev index =
    if 0 <> index
    then
      let new_index = index - 1 in
        print_char (src.[new_index]);
        print_rev new_index
    else print_char '\n'
  in
  print_rev len

let main () =
  ft_print_rev "Hello word !";
  ft_print_rev "";
  ft_print_rev "0123456789"

let () = main()
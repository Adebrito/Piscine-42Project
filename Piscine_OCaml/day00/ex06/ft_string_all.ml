let ft_string_all f src =
  let len = String.length src in
  let rec check_by_f index =
    if index = len
      then true
      else
        begin
          if f (src.[index])
          then check_by_f (index + 1)
          else false
        end
  in
  if len = 0 
    then false
    else check_by_f 0

let main () =
  let is_digit c = c >= '0' && c <= '9' in

  print_endline (string_of_bool (ft_string_all is_digit "Hello word !"));
  print_endline (string_of_bool (ft_string_all is_digit ""));
  print_endline (string_of_bool (ft_string_all is_digit "0123456789"))

let () = main()
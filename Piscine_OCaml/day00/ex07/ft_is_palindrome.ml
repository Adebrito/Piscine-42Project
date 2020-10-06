let is_alpha c = c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z'

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

let ft_is_palindrome src =
  let len = String.length src in
  let rec is_palindrome lhs rhs  = 
    if src.[lhs] == src.[rhs]
      then
        if lhs >= rhs
          then true
          else is_palindrome (lhs + 1) (rhs - 1)
      else false
  in
  if len = 0
    then true
  else if ft_string_all is_alpha src
    then is_palindrome 0 (len - 1)
  else false

let main () =
  print_endline (string_of_bool (ft_is_palindrome "Hello word !"));
  print_endline (string_of_bool (ft_is_palindrome "radar"));
  print_endline (string_of_bool (ft_is_palindrome "0110"));
  print_endline (string_of_bool (ft_is_palindrome "AA"));
  print_endline (string_of_bool (ft_is_palindrome "madam"));
  print_endline (string_of_bool (ft_is_palindrome "car"));
  print_endline (string_of_bool (ft_is_palindrome ""));
  print_endline (string_of_bool (ft_is_palindrome "a"))

let () = main()
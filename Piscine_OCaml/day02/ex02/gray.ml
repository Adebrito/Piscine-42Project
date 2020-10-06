let gray n =
  let gray_encode b = b lxor (b lsr 1) in
  let print_digit n len =
    match (n land (1 lsl (len - 1))) with
    | 0 -> print_int 0
    | _ -> print_int 1
  in
  let rec print_byte n len =
    match len with
    | 0 -> print_char ' '
    | _ -> print_digit n len; print_byte n (len - 1)
  in
  let rec cal_max n acc =
    match n with
    | x when x <= 0 -> acc + 1
    | _ -> cal_max (n-1) (acc + (1 lsl (n - 1)))
  in
  let max = (cal_max n 0) in
  let rec gray_aux index =
    match index with
    | x when x = max -> print_char '\n'
    | _ -> (print_byte (gray_encode index) n); gray_aux (index + 1)
  in
  match n with
  | x when x <= 0 -> print_char '\n'
  | _ ->  gray_aux 0

let main () = 
  gray 1;
  gray 2;
  gray 3;
  gray 4;
  gray (-1)

let () = main ()

let ft_sum f x n =
  let rec cal (i:int) (a:float) :float =
    if n < i then a else cal (i + 1)  (a +. (f i))
  in
  if n < x then nan else cal x 0.

let main () =
  print_endline (string_of_float (ft_sum (fun i -> float_of_int (i * i)) 1 10));
  print_endline (string_of_float (ft_sum (fun i -> float_of_int (i * i)) 1 1));
  print_endline (string_of_float (ft_sum (fun i -> float_of_int (i * i)) 5 4))

let () = main()

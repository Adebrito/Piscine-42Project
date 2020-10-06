let leibniz_pi (accuracy:float) =
  let (pi:float) = (4. *. atan 1.) in
  let abs (x:float) :float = if x > 0. then x else (x *. -1.) in
  let my_pi (i:float) = 4. *. ( -1. ** i /. ( 2. *. i +. 1.) ) in
  let rec cal (index:int) (sum:float) :int =
    if (abs (sum -. pi)) < accuracy
      then index
      else cal (index + 1) (sum +. (my_pi (float_of_int index) ))
  in
  if accuracy < 0. then (-1) else cal 0 0.

let main () =
  print_endline (string_of_int (leibniz_pi (-0.1)));
  print_endline (string_of_int (leibniz_pi 1.));
  print_endline (string_of_int (leibniz_pi 1e-1));
  print_endline (string_of_int (leibniz_pi 1e-4))

let () = main()

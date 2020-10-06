let sum (x:float) (y:float) = 
  x +. y

let () =
  Printf.printf "1. + 2. : %f \n" (sum 1.42 2.42);
  Printf.printf "0. + 0. : %f \n" (sum 0. 0.);
  Printf.printf "-1. + 2. : %f \n" (sum (-1.) 2.);
  Printf.printf "1e-9 + 1e-5 : %f \n" (sum (1e-9) (1e-5))

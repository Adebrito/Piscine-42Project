let trim (min:int) (test:int) (max:int) =
  match test with
  | x when x <= min -> min
  | x when x >= max -> max
  | x -> x
  
let eu_dist (a:float array) (b: float array) :float =
  let rec cal ?(acc=0.) i =
    let new_acc = (acc +. ((a.(i) -. b.(i)) ** 2.)) in
      match i with
      | 0 -> sqrt new_acc
      | _ -> cal ~acc:new_acc (i - 1)
  in
  match (Array.length a) with
  | x when x <> 0 && x = (Array.length b) -> cal (x - 1)
  | _ -> 0.

let () =
  print_endline (string_of_float (eu_dist [|1.5; 1.5; 1.5|] [|2.; 2.; 2.|]));
  print_endline (string_of_float (eu_dist [|0.; 0.; 0.|] [|2.; 2.; 2.|]));
  print_endline (string_of_float (eu_dist [|0.; 0.; 0.|] [|0.; 0.; 0.|]));
  print_endline (string_of_float (eu_dist [|0.; 0.; 0.|] [|0.; 0.; 0.; 0.|]));
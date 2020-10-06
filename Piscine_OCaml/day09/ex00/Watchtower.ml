module type Watchtower =
  sig
    type hour = int
    val zero : hour
    val add : hour -> hour -> hour
    val sub : hour -> hour -> hour
  end

module Watchtower =
  struct
    type hour = int
    let zero = (12:hour)
    let add (x:hour) (y:hour) =
      match (((x + y) mod 12)) with
      | 0 -> zero
      | x -> x
    let sub (x:hour) (y:hour) = 
      match ((12 + (x - y)) mod 12) with
      | 0 -> zero
      | x -> x
  end

let () =
  let hour_0:Watchtower.hour = Watchtower.zero in
    print_endline (string_of_int hour_0);
    let hour_10:Watchtower.hour = 10 
    and hour_42:Watchtower.hour = 42 in
      print_string "10 + 42 = ";
      print_endline (string_of_int (Watchtower.add hour_10 hour_42));
    let hour_3:Watchtower.hour = 3 
    and hour_2:Watchtower.hour = 2 in
      print_string "3 + 2 = ";
      print_endline (string_of_int (Watchtower.add hour_3 hour_2));
      print_string "2 - 3 = ";
      print_endline (string_of_int (Watchtower.sub hour_2 hour_3));
    let hour_8:Watchtower.hour = 8
    and hour_2:Watchtower.hour = 2 in
      print_string "8 - 2 = ";
      print_endline (string_of_int (Watchtower.sub hour_8 hour_2));
      print_string "8 - 8 = ";
      print_endline (string_of_int (Watchtower.sub hour_8 hour_8));
    let hour_6:Watchtower.hour = 6 in
      print_string "6 + 6 = ";
      print_endline (string_of_int (Watchtower.add hour_6 hour_6))

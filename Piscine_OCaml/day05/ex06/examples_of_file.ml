let create_tuple_ionosphere (el: string array) = ([|float_of_string el.(0);float_of_string el.(1);float_of_string el.(2);|], el.(3))

let rec read ?(ionosphere=[]) ic =
  try
    let s = String.trim (input_line ic) in
      match s with
      | line ->
        begin
          let elements = (Array.of_list (String.split_on_char ',' line)) in
          if (Array.length elements) = 4
          then read ~ionosphere:(ionosphere @ [create_tuple_ionosphere elements]) ic
          else read ~ionosphere:(ionosphere) ic
        end
  with
  | Sys_error err -> begin (Printf.printf "Something went wrong: %s\n" err); [] end
  | End_of_file -> ionosphere

let escape_first_line ic =
  try
    ignore (input_line ic);
    true
  with
  | Sys_error err -> begin (Printf.printf "Something went wrong: %s\n" err); false end
  | End_of_file -> false
  

let examples_of_file name =
  try
  let ic = open_in name in
    if escape_first_line ic
      then
        begin
          let arrayElements = read ic in
            close_in ic;
            arrayElements
        end
      else begin Printf.printf "empty file"; [] end
  with
  | Sys_error err -> (Printf.printf "Something went wrong: %s\n" err); []
  | Failure err -> (Printf.printf "Failure: %s\n" err); []

let string_of_ionosphere (point, lettre) = (Printf.sprintf "X: %f Y: %f Z: %f lettre: %s " point.(0) point.(1) point.(2) lettre)

let main argc argv =
match argc with
| x when x = 2 -> 
  begin
    let listIonosphere = (examples_of_file argv.(1)) in
      List.iter (function x -> Printf.printf "element %s \n" (string_of_ionosphere x)) listIonosphere
  end
| _ -> Printf.printf "./a.out nameFile \n"

let () =
let argv = Sys.argv in
main (Array.length argv) argv
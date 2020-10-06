let () =
  new TNT.tnt |> function x -> x#to_string |> print_endline;
  new Water.water |> function x -> x#to_string |> print_endline;
  new Ethanol.ethanol |> function x -> x#to_string |> print_endline;
  new Carbon_dioxyde.carbon_dioxyde |> function x -> x#to_string |> print_endline;
  let glucose = (new Glucose.glucose) and proto = (new Dinitrogen_oxide.dinitrogen_oxide) in
    print_endline (glucose#to_string ^ " = " ^ proto#to_string ^ " " ^ (string_of_bool (glucose#equal proto)));
    print_endline (glucose#to_string ^ " = " ^ glucose#to_string ^ " " ^ (string_of_bool (glucose#equal glucose)))




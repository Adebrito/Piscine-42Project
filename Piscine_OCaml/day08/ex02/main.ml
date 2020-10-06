let () =
  new Methane.methane |> function x -> x#to_string |> print_endline;
  new Octane.octane |> function x -> x#to_string |> print_endline;
  new Ethane.ethane |> function x -> x#to_string |> print_endline

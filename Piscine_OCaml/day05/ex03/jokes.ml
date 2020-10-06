let read name all =
    let ic = open_in name in
    try
      while true do
        let s = String.trim (input_line ic) in
        match s with
        | "" -> ()
        | line when (String.contains line ';') -> all := !all ^ (line)
        | line -> all := !all ^ (line) ^ "\n"
      done;
    with
    | Sys_error err -> (Printf.printf "Something went wrong: %s\n" err);
    | End_of_file -> ();
    close_in ic

let main argc argv =
  match argc with
  | x when x = 2 -> 
    begin
      let all = ref "" in
      try
        read argv.(1) all;
        let arrayOfJoke = Array.of_list (String.split_on_char ';' !all) in
          match (Array.length arrayOfJoke) with
          | x when (x-1 <= 0) && (arrayOfJoke.(0) = "") -> print_endline "No joke dub"
          | x when x = 1 -> print_endline arrayOfJoke.(0)
          | x -> print_endline arrayOfJoke.(Random.int(x - 1))
      with
      | Sys_error err -> (Printf.printf "Something went wrong: %s\n" err);
      | Failure err -> (Printf.printf "Failure: %s\n" err)
    end
  | _ -> Printf.printf "./a.out nameFile \n"

let () =
  Random.self_init ();
  let argv = Sys.argv in
  main (Array.length argv) argv
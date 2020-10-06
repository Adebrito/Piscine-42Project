let my_sleep () = Unix.sleep 1

let main argc argv =
  match argc with
  | x when x = 2 -> 
      begin
        let time =
          try (int_of_string argv.(1))
          with _ -> 0
        in
        for i = time downto 1 do
          my_sleep ()
        done
      end
  | _ -> ()

let () =
  let argv = Sys.argv in
  main (Array.length argv) argv
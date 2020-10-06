let game (creature:Creature.creature) interface =
  let rec game_loop ?(time=Sys.time()) ?(pressed=false) () =
    if not creature#is_alive then begin interface#final_scope; end
    else 
    begin 
      if (((Sys.time ()) -. time) >= 1.0)
      then
        begin
          ignore creature#fatality;
          interface#update_scope;
          game_loop ()
        end
      else
        begin
          match Graphics.button_down () with
          | x when (x =true && pressed = false)  ->
            begin
              ignore creature#manage_click;
              interface#update_scope;
              game_loop ~pressed:true ()
            end
          | x when (x =true && pressed = true)   -> game_loop ~time:time ~pressed:true ()
          | x when (x = false && pressed = true) -> interface#update_scope; game_loop ~time:time ()
          | _                                    -> game_loop ~time:time ()
        end
      end
    in
    game_loop ();
    Graphics.read_key ()

  
let rec start_game creature = 
  let interface = new Gfx.gfx creature in
  print_endline creature#to_string;
  let key = game creature interface in
  if key = 'y' || key = 'Y' then 
    begin 
      ignore(creature#side_effects (100, 100, 100, 100)); 
      start_game (creature)
    end

let main () =
  try start_game new Creature.creature
  with e -> 
    let msg = Printexc.to_string e 
      and stack = Printexc.get_backtrace () in
      Printf.eprintf "there was an error: %s%s\n" msg stack


let _ = main ()


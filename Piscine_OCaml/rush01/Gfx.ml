(* gfx.ml *)

(* Helpers Section *)

let drawsection (x: int) (y: int) (size: int) (str: string) (gauge: int) =
  let select_color =
    match gauge with
    | x when x >= 75 -> Graphics.green
    | x when x >= 33 -> Graphics.yellow
    | _ -> Graphics.red
    in
  Graphics.moveto (x - (size / 2)) (y - (size / 8));
  (* Draw Gauge *)
  Graphics.set_color Graphics.white;
  Graphics.fill_rect (x - (size / 2)) (y - (size / 8)) size 30;
  Graphics.set_color select_color;
  Graphics.fill_rect (x - (size / 2)) (y - (size / 8)) ((size * gauge) / 100) 30;
  Graphics.set_color Graphics.black;
  Graphics.lineto (x - (size / 2)) (y + (size / 8));
  Graphics.lineto (x + (size / 2)) (y + (size / 8));
  Graphics.lineto (x + (size / 2)) (y - (size / 8));
  Graphics.lineto (x - (size / 2)) (y - (size / 8));
  Graphics.moveto (x - (size / 4) + 10) (y + 25);
  Graphics.draw_string str      (* Draw Label *)

(* Class Section *)

class gfx creature =
object (self)
       initializer
       let _ =
         Graphics.open_graph " 800x600";
         Graphics.set_window_title "TOMIGOTCHI";
         ignore(Graphics.background = Graphics.rgb 151 160 155); (* FIXME *)
         Graphics.clear_graph ()
           in ()
       (* Internals *)
       method private update_state = (
         (* Harcoded version / Faster for 4 element
            but less idiomatic
          *)
         drawsection 140 550 125 "HEALTH" creature#get_health;
         drawsection 290 550 125 "ENERGY" creature#get_energy;
         drawsection 440 550 125 "HYGIENE" creature#get_hygiene;
         drawsection 590 550 125 "HAPPY" creature#get_happiness
       )

       method private draw_buttons creature =
        List.iter (function (el:Action.action) -> el#draw_button) creature#get_actions

       method private draw_game_over =
        Graphics.moveto 300 300;
        Graphics.set_color Graphics.red;
        Graphics.set_font "-*-fixed-medium-r-semicondensed--50-*-*-*-*-*-iso8859-1";
        Graphics.draw_string "GAME OVER";
        Graphics.set_font "fixed";
        Graphics.set_color Graphics.magenta;
        Graphics.moveto 330 250;
        Graphics.draw_string "Play a new game ? Y (YES)";
        Graphics.set_color Graphics.black

       method private update_image = (
          Images.lire_image "assets/pika_pixal_art_resize.png"
            |> function img -> (Graphics.draw_image (Graphics.make_image img) 250 200)
       )

       method private update_triggers =
        self#draw_buttons creature

       (* Public *)
       method update_scope = (

         self#update_image;
         self#update_state;
         self#update_triggers;
         Unix.sleepf 0.1
       )

       method final_scope = (
         self#update_state;
         self#update_triggers;
         self#draw_game_over;
         Unix.sleepf 0.1
       )
end

type basic_meters = (int * int * int * int)

class virtual action (side_effects:basic_meters) = 
  object (self)
    val virtual _x:int
    val virtual _y:int
    val virtual _height:int
    val virtual _width:int
    val virtual _name:string
    val virtual _margin:int
  

    method get_values_side_effects = side_effects

    method get_x = _x
    method get_y = _y
    method get_height = _height
    method get_width = _width
    method get_name = _name
    method get_margin = _margin

    method is_click x y = if (x > self#get_x && ( x < (self#get_x + self#get_width) )) && (y > self#get_y && ( y < (self#get_y + self#get_height) )) then true else false

    method draw_button_click_and_return_values_side_effects =
      Graphics.set_line_width 3;
      Graphics.fill_rect self#get_x self#get_y self#get_height self#get_width;
      Graphics.moveto (self#get_x + self#get_margin ) (self#get_y + 20);
      Graphics.set_color Graphics.white;
      Graphics.draw_string self#get_name;
      Graphics.set_color Graphics.black;
      self#get_values_side_effects

    method draw_button =
      Graphics.set_line_width 3;
      Graphics.set_color Graphics.white;
      Graphics.fill_rect self#get_x self#get_y self#get_height self#get_width;
      Graphics.set_color Graphics.black;
      Graphics.draw_rect self#get_x self#get_y self#get_height self#get_width;
      Graphics.moveto (self#get_x + self#get_margin ) (self#get_y + 20);
      Graphics.draw_string self#get_name

    method virtual exec: unit
    
    method to_string =
      let (health, energy, hygiene, happiness) = side_effects in
        "Button " ^ self#get_name
        ^ ": { position: { x:" ^ (string_of_int self#get_x)
        ^ ", y: " ^ (string_of_int self#get_y) 
        ^ ", height: " ^ (string_of_int self#get_height) 
        ^ ", width: " ^ (string_of_int self#get_width) 
        ^ ", name: \"" ^ self#get_name ^ "\" }, "
        ^ "side_effects: {"
        ^ " health: " ^ (string_of_int health)
        ^ ", energy: " ^ (string_of_int energy)
        ^ ", hygiene: " ^ (string_of_int hygiene)
        ^ ", happiness: " ^ (string_of_int happiness)
        ^ "} }"

  end
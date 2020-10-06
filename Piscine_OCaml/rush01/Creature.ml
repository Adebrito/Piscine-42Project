let string_to_stat str = 
let lst = String.split_on_char ';' str
   in match List.length lst with 
   | 4 -> 
            let int_lst = List.map (fun x -> int_of_string x) lst 
           in (List.nth int_lst 0 , List.nth int_lst 1, List.nth int_lst 2, List.nth int_lst 3)
   | _ -> (0, 0, 0, 0)

let load_file file = 
   match (Sys.file_exists file && not (Sys.is_directory file)) with
    | true -> 
            begin 
               let ic = open_in file
                in try
                    let ret = string_to_stat (input_line ic)
                    in close_in ic;
                    ret
                with e -> close_in ic; (100,100,100,100)
            end 
    | false -> (100,100,100,100)


class creature =
  object (self)

  val  mutable _health:int = 100
  val  mutable _energy:int = 100
  val  mutable _hygiene:int = 100
  val  mutable _happiness:int = 100
  val _actions: Action.action list = [ (new Eat.eat); (new Thender.thender);
                                      (new Bath.bath); (new Kill.kill); 
                                      (new Dance.dance); (new Sleep.sleep); ]

  initializer begin
    self#update (load_file "save.itama")
  end

  method get_health = _health
  method get_energy = _energy
  method get_hygiene = _hygiene
  method get_happiness = _happiness
  method get_actions = _actions

  method set_health = function health -> _health <- health
  method set_energy = function energy -> _energy <- energy
  method set_hygiene = function hygiene -> _hygiene <- hygiene 
  method set_happiness = function happiness -> _happiness <- happiness

  method set_with_trim_health = function health -> _health <- (Utils.trim 0 health 100)
  method set_with_trim_energy = function energy -> _energy <- (Utils.trim 0 energy 100)
  method set_with_trim_hygiene = function hygiene -> _hygiene <- (Utils.trim 0 hygiene 100)
  method set_with_trim_happiness = function happiness -> _happiness <- (Utils.trim 0 happiness 100)

  method fatality = self#side_effects ((-1), 0, 0, 0)

  method manage_click =
    Graphics.mouse_pos ()
      |> function (x, y) -> (self#get_actions |> List.filter (function el -> el#is_click x y ))
          |> function action -> match action with | [] -> true | start::eq -> (self#side_effects start#draw_button_click_and_return_values_side_effects)

  method update ((health:int), (energy:int), (hygiene:int), (happiness:int)) = 
    begin
      self#set_with_trim_health health;
      self#set_with_trim_energy energy;
      self#set_with_trim_hygiene hygiene;
      self#set_with_trim_happiness happiness;
    end

   method save = 
        let data = (string_of_int self#get_health) ^ ";" ^ (string_of_int self#get_energy) ^ ";"
                 ^ (string_of_int self#get_hygiene) ^ ";" ^ (string_of_int self#get_happiness)
        in let oc = open_out "save.itama"
        in
        Printf.fprintf oc "%s" data;
    close_out oc

  method  is_alive = if (self#get_health = 0 || self#get_energy = 0 || self#get_hygiene = 0 || self#get_happiness = 0 ) then false else true
  method  side_effects ((health:int), (energy:int), (hygiene:int), (happiness:int)) :bool = 
    begin
      self#set_with_trim_health (self#get_health + health);
      self#set_with_trim_energy (self#get_energy + energy);
      self#set_with_trim_hygiene (self#get_hygiene + hygiene);
      self#set_with_trim_happiness (self#get_happiness + happiness);
      print_endline self#to_string;
      self#save;
      self#is_alive;
    end

  method perform (action: Action.action) :bool = self#side_effects (action#get_values_side_effects)
  method to_string = "health: " ^ (string_of_int _health) ^ ", energy: " ^ (string_of_int _energy) ^ ", hygiene: " ^ (string_of_int _hygiene) ^ ", happiness: " ^ (string_of_int _happiness)

end

class people (name:string) =
  object (self)

    val _name:string = name
    val _hp:int = 100
    
    initializer print_endline ("people is born " ^ self#to_string);
    method get_name = _name
    method to_string = _name ^ " : { hp: " ^ (string_of_int _hp) ^ " }"
    method talk = print_endline ("I'm " ^ _name ^ "! Do you know the Doctor?")
    method die = print_endline "Aaarghh!"

  end
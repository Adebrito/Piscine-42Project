let rec create_name ?(acc="") n =
  match n with
  | 0 -> acc
  | _ -> create_name ~acc:(acc ^ (String.make 1 (char_of_int((Random.int 26) + 97)))) (n - 1)

class dalek =
  object (self)

    val _sentence = [| "Explain! Explain!"; "Exterminate! Exterminate!"; "I obey!"; "You are the Doctor! You are the enemy of the Daleks!" |]

    val _name:string = create_name 3
    val mutable _hp:int = 100
    val mutable _shield = true
    
    initializer Random.self_init ();

    method talk = print_endline _sentence.(Random.int 3)
    method to_string = _name ^ ": { hp: " ^ (string_of_int _hp) ^ ", shield: " ^ (string_of_bool _shield) ^ " }"
    method exterminate (people:People.people) = 
      begin
        match _shield with
        | true -> _shield <- false;
        | false -> _shield <- true;
        print_endline (_name ^ " exterminate " ^ people#get_name);
        people#die;
      end
    method die = print_endline "Emergency Temporal Shift!"
  end
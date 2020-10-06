let () =
    let strange = new Doctor.doctor "Strange" 42 (new People.people "Gustavo") in
    strange#talk;
    print_endline strange#to_string;
    strange#travel_in_time 5 10;
    print_endline ("hp: " ^ (string_of_int strange#get_hp));
    strange#half_life;
    print_endline ("hp: " ^ (string_of_int strange#get_hp));
    strange#heal;
    print_endline ("hp: " ^ (string_of_int strange#get_hp));
    strange#use_sonic_screwdriver

  
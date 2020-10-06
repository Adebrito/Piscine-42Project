let () =
    let gustavo = new People.people "Gustavo" in
      let strange = new Doctor.doctor "Strange" 42 gustavo in
      let dalek = new Dalek.dalek in
        print_endline (strange#to_string);
        print_endline (gustavo#to_string);
        print_endline (dalek#to_string);
        dalek#talk;
        dalek#talk;
        dalek#talk;
        dalek#exterminate gustavo;
        print_endline (dalek#to_string);
        dalek#die


  
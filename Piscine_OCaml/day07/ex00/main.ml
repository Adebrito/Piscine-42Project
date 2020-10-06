let () =
  let me = new People.people "Gustavo" in
    me#talk;
    print_endline me#to_string;
    me#die
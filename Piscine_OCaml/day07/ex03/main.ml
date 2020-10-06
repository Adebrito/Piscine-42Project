let rec print_list = function 
| [] -> ()
| e::l -> print_endline e#to_string; print_list l

let () =
  let army = (new Army.army ) in
    print_list army#get_army;
    army#add (new People.people "Gustavo1");
    print_list army#get_army;
    army#add (new People.people "Gustavo2");
    army#add (new People.people "Gustavo3");
    print_list army#get_army;
    army#delete;
    print_list army#get_army;
    army#delete;
    army#delete;
    army#delete;
    print_list army#get_army;
  let army = (new Army.army ) in
    print_list army#get_army;
    army#add (new Dalek.dalek);
    print_list army#get_army;
    army#add (new Dalek.dalek);
    army#add (new Dalek.dalek);
    print_list army#get_army;
    army#delete;
    print_list army#get_army;
    army#delete;
    army#delete;
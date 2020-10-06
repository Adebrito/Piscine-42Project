let () =
  print_endline (new Oxygen.oxygen)#to_string;
  print_endline (string_of_bool ((new Oxygen.oxygen)#equal (new Oxygen.oxygen)));
  print_endline (new Radon.radon)#to_string;
  print_endline (string_of_bool ((new Radon.radon)#equal (new Oxygen.oxygen)));
  print_endline (new Carbon.carbon)#to_string;
  print_endline (string_of_bool ((new Carbon.carbon)#equal (new Oxygen.oxygen)));
  print_endline (new Cobalt.cobalt)#to_string;
  print_endline (string_of_bool ((new Cobalt.cobalt)#equal (new Titanium.titanium)));
  print_endline (new Hydrogen.hydrogen)#to_string;
  print_endline (string_of_bool ((new Hydrogen.hydrogen)#equal (new Hydrogen.hydrogen)))

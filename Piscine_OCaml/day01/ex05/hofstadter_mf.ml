let rec hfs_m n =
  if n = 0
    then 0
  else if n > 0
    then n - hfs_f (hfs_m (n - 1))
  else -1

and hfs_f n =
  if n = 0
    then 1
  else if n > 0
    then n - hfs_m (hfs_f (n - 1))
  else -1


let main () =
  print_string "F: ";
  print_string (string_of_int (hfs_f 0)); print_string ", ";
  print_string (string_of_int (hfs_f 1)); print_string ", ";
  print_string (string_of_int (hfs_f 2)); print_string ", ";
  print_string (string_of_int (hfs_f 3)); print_string ", ";
  print_string (string_of_int (hfs_f 4)); print_string ", ";
  print_string (string_of_int (hfs_f 5)); print_string ", ";
  print_string (string_of_int (hfs_f 6)); print_string ", ";
  print_string (string_of_int (hfs_f 7)); print_string ", ";
  print_string (string_of_int (hfs_f 8)); print_string "\n";
  print_string "M: ";
  print_string (string_of_int (hfs_m 0)); print_string ", ";
  print_string (string_of_int (hfs_m 1)); print_string ", ";
  print_string (string_of_int (hfs_m 2)); print_string ", ";
  print_string (string_of_int (hfs_m 3)); print_string ", ";
  print_string (string_of_int (hfs_m 4)); print_string ", ";
  print_string (string_of_int (hfs_m 5)); print_string ", ";
  print_string (string_of_int (hfs_m 6)); print_string ", ";
  print_string (string_of_int (hfs_m 7)); print_string ", ";
  print_string (string_of_int (hfs_m 8)); print_string "\n"

let () = main()
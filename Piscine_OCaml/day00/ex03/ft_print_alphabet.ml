let ft_print_alphabet () =
	let ascii_a = int_of_char 'a' in
	let ascii_z = int_of_char 'z' in
	let rec print_alphabet current_ascii =
		if current_ascii <= ascii_z
		then
			begin
				print_char (char_of_int current_ascii);
				print_alphabet (current_ascii + 1)
			end
	in
	print_alphabet ascii_a;
	print_char '\n'

let main () =
  ft_print_alphabet ()

let () = main()
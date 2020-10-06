let rot_char n c = char_of_int ((int_of_char (c) - n) mod 127)

let rot42 str = str |> String.map (rot_char 42)

let caesar n str = str |> String.map (rot_char n)

let xor n str = str |> String.map (fun x -> char_of_int (n lxor (int_of_char x)))

let xor42 str = xor 42 str

let rec ft_crypt str lst =
  match lst with
	| [] 		-> str
	| s::q	-> ft_crypt (s str) q
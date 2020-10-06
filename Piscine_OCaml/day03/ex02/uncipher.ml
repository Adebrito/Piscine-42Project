let unrot_char n c = char_of_int ((int_of_char (c) + n) mod 127)

let unrot42 str = str |> String.map (unrot_char 42)

let uncaesar n str = str |> String.map (unrot_char n)

let xor n str = Cipher.xor n str

let xor42 str = Cipher.xor42 str

let select_uncrypt_fun f =
  match f with
  |	x when x == Cipher.rot42 -> unrot42
  |	x when x == unrot42 -> Cipher.rot42
  |	x when x == xor42 -> Cipher.xor42
  |	x when x == Cipher.xor42 -> xor42
  | _ -> f

let rec rev_list ?(acc=[]) lst =
  match lst with
  | [] -> acc
  | s::q -> rev_list ~acc:([s] @ acc) q

let ft_uncrypt str lst =
  let rec loop str lst =
    match lst with
    | [] -> str
    | s::q -> loop ((select_uncrypt_fun s) str) q
  in
  loop str (rev_list lst)
let rec print_list = function 
    [] -> ()
    | e::l -> print_endline e; print_list l

let () =
  Random.self_init ();
  let deck = Deck.newDeck () in
  print_list (Deck.toStringListVerbose deck);
  let (n, c) = Deck.drawCard deck in
  print_string "draw card = "; print_endline (Deck.Card.toStringVerbose n);
  let (n, _) = Deck.drawCard c in
  print_string "draw card = "; print_endline (Deck.Card.toStringVerbose n)
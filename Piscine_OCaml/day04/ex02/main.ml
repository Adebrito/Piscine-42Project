
let () =
  let print lst =
    List.iter (function s -> print_string ((Card.toStringVerbose s) ^ " : " ^ (Card.toString s) ^ "\n")) lst;
  in
  print_endline "______LIST_SPADES______";
  print Card.allSpades;
  print_endline "______LIST_HEARTS______";
  print Card.allHearts;
  print_endline "______LIST_DIAMONDS______";
  print Card.allDiamonds;
  print_endline "______LIST_CLUBS______";
  print Card.allClubs;
  print_endline "______ALL______";
  print Card.all;
  print_endline "search best in deck Spade";
  print_endline (Card.toStringVerbose (Card.best Card.allSpades));
  print_endline "Card min :";
  let card1 = (Card.newCard Card.Value.T10 Card.Color.Club) in
  let card2 = (Card.newCard Card.Value.T9 Card.Color.Heart) in
  print_endline ((Card.toStringVerbose card1) ^ " vs " ^ (Card.toStringVerbose card2));
  print_endline (Card.toStringVerbose (Card.min card1 card2));
  print_endline "Card min :";
  let card1 = (Card.newCard Card.Value.T10 Card.Color.Club) in
  let card2 = (Card.newCard Card.Value.T10 Card.Color.Heart) in
  print_endline ((Card.toStringVerbose card1) ^ " vs " ^ (Card.toStringVerbose card2));
  print_endline (Card.toStringVerbose (Card.min card1 card2));
  print_endline "Card max :";
  let card1 = (Card.newCard Card.Value.T2 Card.Color.Club) in
  let card2 = (Card.newCard Card.Value.As Card.Color.Heart) in
  print_endline ((Card.toStringVerbose card1) ^ " vs " ^ (Card.toStringVerbose card2));
  print_endline (Card.toStringVerbose (Card.max card1 card2));
  print_endline "Card compare :";
  let card1 = (Card.newCard Card.Value.T5 Card.Color.Club) in
  let card2 = (Card.newCard Card.Value.T10 Card.Color.Heart) in
  print_endline ((Card.toStringVerbose card1) ^ " vs " ^ (Card.toStringVerbose card2));
  print_endline (string_of_int (Card.compare card1 card2));
  print_endline ((Card.toStringVerbose card1) ^ "is a Club: " ^ (string_of_bool (Card.isClub card1)));
  print_endline ((Card.toStringVerbose card1) ^ "is a Heart: " ^ (string_of_bool (Card.isHeart card1)))


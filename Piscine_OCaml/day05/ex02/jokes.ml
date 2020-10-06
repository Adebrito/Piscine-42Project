let badJokeArray = [|
  "Que dit un informaticien quand il s'ennuie ?\nJe me fichier";
  "Quels sont les fruits qu'on trouve dans toutes les maisons ?\nDes coings et des mûres";
  "Que dit Frodon devant sa maison ?\nC’est là que j’hobbi";
  "J'ai une blague sur les magasins\nMais elle a pas supermarché";
  "Avec quelle monnaie les marins payent-ils ?\nAvec des sous marins";
|]

let main () =
  print_endline badJokeArray.(Random.int 5)

let () = 
  Random.self_init ();
  main ()
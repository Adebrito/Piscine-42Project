
type 'a ft_ref = { mutable contents: 'a }

let return element :'a ft_ref = { contents = element }

let get (element:'a ft_ref) = element.contents

let set (element:'a ft_ref) (contents: 'a) = element.contents <- contents

let bind (element:'a ft_ref) (f:'a -> 'b ft_ref) = f (get element)

let () =
  let el = return "Salut" in
    print_endline (get el);
    set el "toi";
    print_endline (get el);
    let test = (bind el (function x ->  return ("Salut " ^ x ))) in
    print_endline (get test)

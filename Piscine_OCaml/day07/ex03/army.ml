class ['a] army =
  object

    val mutable _list:'a list = []

    method get_army = _list

    method add (elem:'a) =  _list <-  _list @ [elem]
    method delete =
      match _list with
      | [] ->  _list <- _list
      | h::t -> _list <- t

  end
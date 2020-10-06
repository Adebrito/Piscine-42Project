class eat =
  object
    inherit Action.action (25, (-10), (-20), 5)

    val _x:int = 400
    val _y:int = 100
    val _height:int = 75
    val _width:int = 50
    val _name:string = "EAT"
    val _margin:int = 29

    method exec = print_endline "SALUT"
end
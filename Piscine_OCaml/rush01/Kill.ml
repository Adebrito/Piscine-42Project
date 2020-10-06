class kill =
  object
    inherit Action.action ((-20), (-10), 0, 20)

    val _x:int = 300
    val _y:int = 100
    val _height:int = 75
    val _width:int = 50
    val _name:string = "KILL"
    val _margin:int = 26

    method exec = print_endline "SALUT"
end
class thender =
  object
    inherit Action.action ((-20), +25, 0, (-20))
    
    val _x:int = 500
    val _y:int = 100
    val _height:int = 75
    val _width:int = 50
    val _name:string = "THUNDER"
    val _margin:int = 20

    method exec = print_endline "SALUT"
end
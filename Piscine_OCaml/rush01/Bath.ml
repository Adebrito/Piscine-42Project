class bath =
  object
    inherit Action.action ((-20), (-10), 25, 5)

    val _x:int = 200
    val _y:int = 100
    val _height:int = 75
    val _width:int = 50
    val _name:string = "BATH"
    val _margin:int = 25

    method exec = print_endline "SALUT"
end
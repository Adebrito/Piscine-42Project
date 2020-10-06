class dance =
  object
    inherit Action.action (0, (-10), (-5), 10)

    val _x:int = 300
    val _y:int = 30
    val _height:int = 75
    val _width:int = 50
    val _name:string = "DANCE"
    val _margin:int = 25

    method exec = print_endline "SALUT"
end

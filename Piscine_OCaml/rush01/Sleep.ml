class sleep =
  object
    inherit Action.action (10, 10, (-10), 0)

    val _x:int = 400
    val _y:int = 30
    val _height:int = 75
    val _width:int = 50
    val _name:string = "SLEEP"
    val _margin:int = 25

    method exec = print_endline "SALUT"
end

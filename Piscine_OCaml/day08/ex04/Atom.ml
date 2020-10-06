class virtual atom (name:string) (symbol:string) (atomic_number:int) = 
  object (self)

    method _name = name
    method _symbol = symbol
    method _atomic_number = atomic_number

    method to_string = self#_name ^ " : { symbol: " ^ self#_symbol ^ ", atomic_number: " ^ (string_of_int self#_atomic_number) ^ " }"
    method equal (that:atom)= (self#_name = that#_name && self#_symbol = that#_symbol && self#_atomic_number = that#_atomic_number)

  end
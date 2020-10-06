class virtual molecule (name:string) (lst:Atom.atom list) = 
  object (self)

    method _name = name
    method _formula = self#generate_formula

    method compare x y = 
      match (x#equal y) with
      | true -> 0
      | false -> begin
        if x#_symbol = "C" || (x#_symbol = "H" && y#_symbol <> "C") then -1
        else (int_of_char ((x#_symbol).[0])) - (int_of_char ((y#_symbol).[0]))
      end

    method generate_formula =
      let rec formate_hill_notation ?(acc_string="") u  =
        match u with
        | [] -> acc_string
        | h::t -> formate_hill_notation ~acc_string:(acc_string ^ h#_symbol ^ 
                (lst |> List.filter (function x -> h#equal x) |> List.length |> string_of_int )) t 
      in
      lst |> List.sort_uniq self#compare |> formate_hill_notation 
    method to_string = self#_name ^ " : { formula: " ^ self#_formula ^ " }"
    method equal (that:molecule)= (self#_name = that#_name && self#_formula = that#_formula)

  end

class virtual alkane (n:int) =
  object
  
    inherit Molecule.molecule (
      match n with
      | 1 -> "Methane"
      | 2 -> "Ethane"
      | 3 -> "Propane"
      | 4 -> "Butane"
      | 5 -> "Pentane"
      | 6 -> "Hexane"
      | 7 -> "Heptane"
      | 8 -> "Octane"
      | 9 -> "Nonane"
      | 10 -> "Decane"
      | 11 -> "Undecane"
      | 12 -> "Dodecane"
      | _ -> "not found alkane"
    ) (
      (List.init n (function x -> new Carbon.carbon)) @ (List.init ((n * 2) + 2) (function x -> new Hydrogen.hydrogen))
    )

end
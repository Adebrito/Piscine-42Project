
class virtual alkane (n:int) =
  object
  
    inherit Molecule.molecule (
      match n with
      | 1 -> "Methane"
      | 2 -> "Ethane"
      | 8 -> "Octane"
      | _ -> "not found alkane"
    ) (
      (List.init n (function x -> new Carbon.carbon)) @ (List.init ((n * 2) + 2) (function x -> new Hydrogen.hydrogen))
    )

end
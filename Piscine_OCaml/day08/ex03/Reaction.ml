class virtual reaction (start:Molecule.molecule) (result:Molecule.molecule) =
  object

  method virtual get_start:(Molecule.molecule * int) list
  method virtual get_result:(Molecule.molecule * int) list
  method virtual balance:reaction
  method virtual is_balanced:bool
end
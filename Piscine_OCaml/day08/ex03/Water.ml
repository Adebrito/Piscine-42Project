class water =
  object
    inherit Molecule.molecule "Water" [
       new Oxygen.oxygen; 
       new Hydrogen.hydrogen; new Hydrogen.hydrogen;
      ]
  end
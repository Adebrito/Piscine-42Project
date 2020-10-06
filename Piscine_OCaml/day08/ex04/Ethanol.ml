class ethanol =
  object
    inherit Molecule.molecule "Ethanol" [
       new Oxygen.oxygen; 
       new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen;
       new Carbon.carbon; new Carbon.carbon;
      ]
  end
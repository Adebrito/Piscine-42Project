class tnt =
  object
    inherit Molecule.molecule "Trinitrotoluene" [
        new Nitrogen.nitrogen; new Nitrogen.nitrogen; new Nitrogen.nitrogen;
        new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen; new Hydrogen.hydrogen;
        new Oxygen.oxygen; new Oxygen.oxygen; new Oxygen.oxygen; new Oxygen.oxygen; new Oxygen.oxygen; new Oxygen.oxygen;
        new Carbon.carbon; new Carbon.carbon; new Carbon.carbon; new Carbon.carbon; new Carbon.carbon; new Carbon.carbon; new Carbon.carbon;
      ]
  end
class dinitrogen_oxide =
  object
    inherit Molecule.molecule "Dinitrogen_oxide" [
       new Oxygen.oxygen; 
       new Nitrogen.nitrogen; new Nitrogen.nitrogen;
      ]
  end
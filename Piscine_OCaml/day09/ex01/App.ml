module App =
  struct
    type project = string * string * int

		let zero = (("", "", 0):project)
		
		let combine (project_a:project) (project_b:project) = 
      match project_a with
      | (product_a, status_a, grade_a) -> 
        begin
          match project_b with
          | (product_b, status_b, grade_b) ->  (
            ((product_a ^ "_" ^ product_b),
              ( match ((grade_a + grade_b) / 2) with
                | x when x <= 80 -> "succeed"
                | _ -> "fail"),
            ((grade_a + grade_b) / 2) ):project)
        end

    let fail (p:project) =
      match p with
      | (product, _, _) -> ((product, "fail", 0):project)

    let success (p:project) =
      match p with
      | (product, _, _) -> ((product, "succeed", 80):project)
      
	end
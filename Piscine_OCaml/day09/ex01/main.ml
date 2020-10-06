let print_project p =
    match p with
    | (product, status, grade) -> print_endline (product ^ " : { status: " ^ status ^ ", grade: " ^ (string_of_int grade) ^ " }")

let () = 
  App.App.zero |> print_project;
  let project:App.App.project = (("libft", "success", 125):App.App.project) in
    project |> print_project;
    project |> App.App.fail |> print_project;
    project |> App.App.success |> print_project;
    App.App.combine (("libft", "success", 100):App.App.project) (("asm", "success", 0):App.App.project) |> print_project

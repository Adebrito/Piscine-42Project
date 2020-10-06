type t = Spade | Heart | Diamond | Club

let all = [Spade; Heart; Diamond; Club]

let select_type_verbose t =
  match t with
  | Spade -> "S"
  | Heart -> "H"
  | Diamond -> "D"
  | Club -> "C"

let select_type t =
  match t with
  | Spade -> "Spade"
  | Heart -> "Heart"
  | Diamond -> "Diamond"
  | Club -> "Club"

let toString t = select_type_verbose t

let toStringVerbose t = select_type t
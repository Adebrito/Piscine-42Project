module Card = 
struct
  module Color =
  struct

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

  end

  module Value =
  struct

    type t = T2 | T3 | T4 | T5 | T6 | T7 | T8 | T9 | T10 | Jack | Queen | King | As

    let all = [T2; T3; T4; T5; T6; T7; T8; T9; T10; Jack; Queen; King; As]

    let select_type_verbose t =
      match t with
      | T2 -> "2"
      | T3 -> "3"
      | T4 -> "4"
      | T5 -> "5"
      | T6 -> "6"
      | T7 -> "7"
      | T8 -> "8"
      | T9 -> "9"
      | T10 -> "10"
      | Jack -> "Jack"
      | Queen -> "Queen"
      | King -> "King"
      | As -> "As"

    let select_type t =
      match t with
      | T2 -> "2"
      | T3 -> "3"
      | T4 -> "4"
      | T5 -> "5"
      | T6 -> "6"
      | T7 -> "7"
      | T8 -> "8"
      | T9 -> "9"
      | T10 -> "10"
      | Jack -> "J"
      | Queen -> "Q"
      | King -> "K"
      | As -> "A"

    let toInt t =
      match t with
      | T2 -> 1
      | T3 -> 2
      | T4 -> 3
      | T5 -> 4
      | T6 -> 5
      | T7 -> 6
      | T8 -> 7
      | T9 -> 8
      | T10 -> 9
      | Jack -> 10
      | Queen -> 11
      | King -> 12
      | As -> 13

    let toString t = select_type t

    let toStringVerbose t = select_type_verbose t

    let rec find ?(index=0) lst target =
      match lst with
      | [] -> invalid_arg "No found next value"
      | s::q when index = target -> s
      | s::q when index < target -> find ~index:(index + 1) q target
      | s::q -> invalid_arg "No found previous value"

    let next t = find all (toInt t)

    let previous t = find all ((toInt t) - 2)

  end

  type t = { value: Value.t; color: Color.t }

  let newCard value color = { value = value; color = color }

  let allSpades = Value.all |> List.map (function x -> (newCard x Color.Spade))
  let allHearts = Value.all |> List.map (function x -> (newCard x Color.Heart))
  let allDiamonds = Value.all |> List.map (function x -> (newCard x Color.Diamond))
  let allClubs = Value.all |> List.map (function x -> (newCard x Color.Club))
  let all = allSpades @ allHearts @ allDiamonds @ allClubs

  let getValue this = this.value
  let getColor this = this.color

  let toString this = (Value.toString this.value) ^ (Color.toString this.color)
  let toStringVerbose this = "Card(" ^ (Value.toStringVerbose this.value) ^ ", " ^ (Color.toStringVerbose this.color) ^ ")"

  let compare t1 t2 = (Value.toInt t1.value) - (Value.toInt t2.value)

  let max t1 t2 =
    match (Value.toInt t1.value) with
    | x when x < (Value.toInt t2.value) -> t2
    | _ -> t1

  let min t1 t2 =
    match (Value.toInt t1.value) with
    | x when x > (Value.toInt t2.value) -> t2
    | _ -> t1

  let best t =
    match t with
    | [] -> invalid_arg "empty list"
    | s::q -> List.fold_left max s q

  let isOf t color = (t.color = color)
  let isSpade t = isOf t Color.Spade
  let isHeart t = isOf t Color.Heart
  let isDiamond t = isOf t Color.Diamond
  let isClub t = isOf t Color.Club

end

type t = Card.t list

let toStringList t = t |> List.map (function x -> Card.toString x)

let toStringListVerbose t = t |> List.map (function x -> Card.toStringVerbose x)

let randomize x y = (Random.int 42) - (Random.int 42)

let newDeck () = Card.all |> List.sort randomize

let drawCard this =
  match this with
  | [] -> invalid_arg "Failure"
  | h::t -> (h, t)
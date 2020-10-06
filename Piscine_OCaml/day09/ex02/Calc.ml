module type MONOID =
  sig
    type element
    val zero1 : element
    val zero2 : element
    val mul : element -> element -> element
    val add : element -> element -> element
    val div : element -> element -> element
    val sub : element -> element -> element
end


module Calc =
  functor (M: MONOID) ->
    struct
      let mul x y = M.mul x y
      let add x y = M.add x y
      let div x y = M.div x y 
      let sub x y = M.div x y
      let rec power x = function
        | 0 -> M.zero1
        | 1 -> x
        | n when (n mod 2 = 0) -> let a = power x (n / 2) in M.mul a a
        | n -> let a = power x (n / 2) in M.mul x (M.mul a a)
      
      let fact x =
        let rec aux ?(acc=1) x =
          match x with
          | x when x <= 1 -> acc
          | _ -> aux ~acc:(acc * x) (x - 1)
        in aux x
end

module FLOAT =
  struct
    type element = float
    let zero1 = 0.
    let zero2 = 1.
    let add = ( +. )
    let sub = ( -. )
    let mul = ( *. )
    let div = ( /. )
end

module INT =
  struct
    type element = int
    let zero1 = 0
    let zero2 = 1
    let add = ( + )
    let sub = ( - )
    let mul = ( * )
    let div = ( / )
end

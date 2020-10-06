module type FIXED = 
  sig
    type t
    val of_float  : float -> t
    val of_int    : int -> t
    val to_float  : t -> float
    val to_int    : t -> int
    val to_string : t -> string
    val zero      : t
    val one       : t
    val succ      : t -> t
    val pred      : t -> t
    val min       : t -> t -> t
    val max       : t -> t -> t
    val gth       : t -> t -> bool
    val lth       : t -> t -> bool
    val gte       : t -> t -> bool
    val lte       : t -> t -> bool
    val eqp       : t -> t -> bool
    val eqs       : t -> t -> bool
    val add       : t -> t -> t
    val sub       : t -> t -> t
    val mul       : t -> t -> t
    val div       : t -> t -> t
    val foreach   : t -> t -> (t -> unit) -> unit
  end

module type FRACTIONNAL_BITS = sig val bits: int end

module type MAKE = functor (FIXED_BITS:FRACTIONNAL_BITS) -> FIXED

module Make : MAKE =
  functor (FIXED_BITS:FRACTIONNAL_BITS) ->
  struct
    type t = int

    let of_float n = int_of_float (ceil (n *. float_of_int (1 lsl FIXED_BITS.bits)))
    let of_int n = n * (1 lsl FIXED_BITS.bits)
    let to_float n = (float_of_int n) /. (float_of_int (1 lsl FIXED_BITS.bits))
    let to_int n = n / (1 lsl FIXED_BITS.bits)
    let to_string n = string_of_float(to_float n)
    let zero = of_int 0
    let one = of_int 1
    let succ n = n + 1
    let pred n = n - 1
    let min x y = min x y
    let max x y = max x y
    let gth x y = x > y
    let lth x y = x < y
    let gte x y = x >= y
    let lte x y = x <= y
    let eqp x y = x == y
    let eqs x y = x = y
    let add x y = x + y
    let sub x y = x - y
    let mul x y = (of_float((to_float x) *. (to_float y)))
    let div x y = (of_float((to_float x) /. (to_float y)))
    let rec foreach x y f =
      match x with
      | x when x >= y -> f x
      | _ -> begin f x; foreach (succ x) (y) (f) end

  end

module Fixed4 : FIXED = Make (struct let bits = 4 end)
module Fixed8 : FIXED = Make (struct let bits = 8 end)

let () =
  let x8 = Fixed8.of_float 21.10 in
    let y8 = Fixed8.of_float 21.32 in
      let r8 = Fixed8.add x8 y8 in
        print_endline (Fixed8.to_string r8);
        Printf.printf "max %s %s = %s\n" (Fixed8.to_string x8) (Fixed8.to_string y8) (Fixed8.to_string (Fixed8.max x8 y8));
        Printf.printf "min %s %s = %s\n" (Fixed8.to_string x8) (Fixed8.to_string y8) (Fixed8.to_string (Fixed8.min x8 y8));
        Printf.printf " %s * %s = %s\n" (Fixed8.to_string x8) (Fixed8.to_string y8) (Fixed8.to_string (Fixed8.mul x8 y8));
        Printf.printf " %s < %s = %s\n" (Fixed8.to_string x8) (Fixed8.to_string y8) (string_of_bool (x8 < y8));
        Printf.printf " %s < %s = %s\n" (Fixed8.to_string x8) (Fixed8.to_string y8) (string_of_bool (Fixed8.lth x8 y8));
        Fixed4.foreach (Fixed4.zero) (Fixed4.one) (fun f -> print_endline (Fixed4.to_string f));

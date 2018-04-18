structure ListExt =
struct

    fun join [] partitionStr = ""
      | join (x::xs) partitionStr = let
        val rec core = fn ([], res) => res
                    | (x::xs, res) => core (xs, res ^ partitionStr ^ x)
    in
        core (xs, x)
    end


    fun printStrLst lst = print ("[" ^ (join lst ",") ^ "]")

    fun findIndex f [] = NONE
      | findIndex f (x::xs) = if f x
        then SOME 0 
        else 
            case findIndex f xs 
              of NONE => NONE
               | SOME n => SOME (1 + n)

end
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


end
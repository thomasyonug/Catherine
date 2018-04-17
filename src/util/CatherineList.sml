structure CatherineList =
struct
    fun split str partitionPoint = let
        val charList = String.explode str;
    in
        List.foldl (fn ((x::xs) as lst, char) => 
            let
            in
                if char = partitionPoint 
                then
                    "" :: lst
                else 
                    (x ^ char) :: xs
            end
        ) [] charList      
    end 
end
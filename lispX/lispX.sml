structure LispX =
struct



    fun compile filePath = let
        val absTree = Parse.parse filePath
        val result = Eval.eval absTree
    in
        result 
    end

end
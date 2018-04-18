structure StringExt =
struct
    fun split str regex = let
        val dfa = Re.compileString regex
        fun core s result = case StringCvt.scanString (Re.find dfa) s 
            of NONE => result
             | SOME (MatchTree.Match ({len, pos}, _)) => (
                if pos > 0
                then
                    core (String.extract (s, pos + len, NONE)) (result @ [String.substring (s, 0, pos)])
                else
                    result
             )
    in
        core str []
    end 
end
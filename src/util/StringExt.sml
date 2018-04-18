structure StringExt =
struct
    fun split str regex = let
        val dfa = Re.compileString regex
        fun core s result = case StringCvt.scanString (Re.find dfa) s 
            of NONE => result @ [s]
             | SOME (MatchTree.Match ({len, pos}, _)) => (let
                val substr = String.extract (s, pos + len, NONE)
             in
                if (String.size substr) > 0
                then
                    core substr (result @ [String.substring (s, 0, pos)])
                else
                    result
             end)
    in
        core str []
    end 
end
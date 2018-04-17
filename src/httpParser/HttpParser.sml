
structure HttpParser: HTTPPARSER =
struct


    type REQUEST = {
        getHeader: string -> string,
        getBody: unit -> string,
        primitive: string
    }

    type RESPONSE = {}



    fun headerParse msgLines = let
        val dict = StringDict.empty;
        val (line::lines) = msgLines
    in

        List.foldl (fn (line, dict) => 
            let
                val (k::vs) = String.tokens (fn c => c = #":") line
                val v = String.concat vs
            in
                StringDict.set (dict, k, v)
            end
        ) dict lines
    end




    fun parse str = let
        val msgLines = String.tokens(fn c => c = #"\t") str;
    in
        let
            val headerDict = headerParse msgLines;
            fun getHeader field = "todo" 
            fun getBody () = "str"
        in
            {
                getHeader = getHeader,
                getBody = getBody,
                primitive = str
            } 
        end
    end
end
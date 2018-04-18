
structure HttpParser: HTTPPARSER =
struct

    infix |>;
    fun (d |> (k, v)) = StringDict.set (d, k, v);

    type REQUEST = {
        getHeader: string -> string,
        getBody: unit -> string,
        primitive: string
    }

    type RESPONSE = {}



    fun headerParse [] = StringDict.empty
      | headerParse (line::lines) = let
        val msgLines = line :: lines
        val (method::route::protocol::_) = String.tokens (fn c => c = #" ") line
        val dict = StringDict.empty
                    |> ("method", method)
                    |> ("route", route)
                    |> ("protocol", protocol);
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
        val msgLines = StringExt.split str "\r\n"
        val (heads, body) = let
            val index = case ListExt.findIndex (fn item => item = "") msgLines 
                            of SOME i => i
                             | NONE => List.length msgLines;
        in
            (
                List.take (msgLines, index),
                (ListExt.join o List.drop) (msgLines, index) "\r\n"
            )
        end

    in
        let
            val headerDict = headerParse heads;
            fun getHeader field = StringDict.get (headerDict, field) 
            fun getBody () = body
        in
            {
                getHeader = getHeader,
                getBody = getBody,
                primitive = str
            } 
        end
    end
end
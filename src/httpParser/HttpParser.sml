
structure HttpParser: HTTPPARSER =
struct


    type REQUEST = {
        getHeader: string -> string,
        getBody: unit -> string
    }

    type RESPONSE = {}





    fun parse str = let
        fun getHeader field = "todo" 
        fun getBody () = "str"
    in
        {
            getHeader = getHeader,
            getBody = getBody
        } 
    end
end
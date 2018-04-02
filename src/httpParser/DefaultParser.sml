structure DefaultParser : HTTPPARSER =
struct
    type Request = {
    }

    fun parse (msg: string): Request = ({})
end
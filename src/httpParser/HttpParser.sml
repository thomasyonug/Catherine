
structure HttpParser: HTTPPARSER =
struct


    type REQUEST = {
        getHeader: string -> string,
        getBody: unit -> string
    }
end
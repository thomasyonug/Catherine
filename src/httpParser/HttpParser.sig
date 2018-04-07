signature HTTPPARSER =
sig
    type REQUEST
    type RESPONSE

    val parse: string -> REQUEST
    val newResponse: unit -> RESPONSE
end
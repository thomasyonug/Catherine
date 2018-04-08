signature HTTPPARSER =
sig
    type REQUEST
    type RESPONSE

    val parse: string -> REQUEST
end
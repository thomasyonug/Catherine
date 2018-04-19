signature HTTPPARSER =
sig
    type REQUEST

    val parse: string -> REQUEST
    val CRLF: string
end
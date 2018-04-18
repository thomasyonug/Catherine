signature HTTPPARSER =
sig
    type REQUEST

    val parse: string -> REQUEST
end
signature HTTPPARSER =
sig
    type Request

    val parse: string -> Request
end
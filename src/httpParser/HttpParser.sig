signature HTTPPARSER =
sig
    type Request
    type Response

    val parse: string -> Request
    val newResponse: unit -> Response
end
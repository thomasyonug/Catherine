
signature ASYNCSERVER =
sig

    type Request
    type Response

    val listen: int -> (Request -> unit) -> unit

end




signature SOCKETCONN =
sig
    val listen: int -> (DefaultParser.Request -> unit) -> unit
end
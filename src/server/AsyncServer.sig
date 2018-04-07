
signature ASYNCSERVER =
sig

    type REQUEST
    type RESPONSE
    type EVENT

    val listen: int -> (REQUEST -> EVENT) -> unit

end




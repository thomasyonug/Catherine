
signature ASYNCSERVER =
sig

    type REQUEST
    type RESPONSE
    type EVENT
    (* type EventDoing
    type EventDone
    type EventEmpty *)

    val listen: int -> (REQUEST -> EVENT) -> unit

end




signature EVENTLOOP =
sig
    datatype EVENT = Doing of unit -> (EVENT * (INetSock.inet, Socket.active Socket.stream) Socket.sock)
                   | Done of (INetSock.inet, Socket.active Socket.stream) Socket.sock
    type Queue = EVENT list
    val initQueue: unit -> Queue


    val append: EVENT list -> EVENT list -> EVENT list
    (* val recovery: EVENT list -> EVENT list *)
    val exec: EVENT list -> EVENT list

end
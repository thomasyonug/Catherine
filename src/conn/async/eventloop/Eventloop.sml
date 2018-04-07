structure Eventloop: EVENTLOOP =
struct
    
    datatype EVENT = Doing of unit -> (EVENT * (INetSock.inet, Socket.active Socket.stream) Socket.sock)
                   | Done of (INetSock.inet, Socket.active Socket.stream) Socket.sock
                   | Empty

    type Queue = EVENT list

    fun initQueue () = []
    fun append hlst blst = hlst @ blst

    fun exec queue = queue



end
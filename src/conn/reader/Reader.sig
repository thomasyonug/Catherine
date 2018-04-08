signature READER =
sig
    
    val initReader: unit -> Socket.sock_desc
                         -> (INetSock.inet, Socket.active Socket.stream) Socket.sock
                         -> string
end
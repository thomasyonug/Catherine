signature ASYNCIO =
sig

    (* val select: (INetSock.inet, Socket.active Socket.stream) Socket.sock list -> {
        rdsDescs: (Socket.sock_desc * (INetSock.inet, Socket.active Socket.stream) Socket.sock) list,
        wrsDescs: (Socket.sock_desc * (INetSock.inet, Socket.active Socket.stream) Socket.sock) list, 
        exsDescs: (Socket.sock_desc * (INetSock.inet, Socket.active Socket.stream) Socket.sock) list,
        rds: Socket.sock_desc list,
        wrs: Socket.sock_desc list,
        exs: Socket.sock_desc list
    } *)

    val select: ('a, 'b) Socket.sock list -> {
        rdsDescs: (Socket.sock_desc * ('a, 'b) Socket.sock) list,
        wrsDescs: (Socket.sock_desc * ('a, 'b) Socket.sock) list, 
        exsDescs: (Socket.sock_desc * ('a, 'b) Socket.sock) list,
        rds: Socket.sock_desc list,
        wrs: Socket.sock_desc list,
        exs: Socket.sock_desc list
    }
end
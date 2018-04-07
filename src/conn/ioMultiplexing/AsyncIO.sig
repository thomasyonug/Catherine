signature ASYNCIO =
sig

    val select: (INetSock.inet, Socket.active Socket.stream) Socket.sock list -> {
        rds: Socket.sock_desc list,
        wrs: Socket.sock_desc list, 
        exs: Socket.sock_desc list
    }

end
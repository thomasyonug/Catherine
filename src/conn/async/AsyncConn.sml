structure AsyncConn: ASYNCCONN =
struct
    
    fun socket () = INetSock.TCP.socket()

    fun listen sock port = (
        Socket.bind (sock, INetSock.any port);
        Socket.listen (sock, 5)
    )

    fun accept mainSock = Socket.acceptNB mainSock

    fun recovery socks = socks


end
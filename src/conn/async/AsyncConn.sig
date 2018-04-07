signature ASYNCCONN =
sig

    val listen: (INetSock.inet, Socket.passive Socket.stream) Socket.sock -> int -> unit

    val accept: (INetSock.inet, Socket.passive Socket.stream) Socket.sock -> 
                    ((INetSock.inet, Socket.active Socket.stream) Socket.sock * INetSock.inet Socket.sock_addr) option

    val recovery: (INetSock.inet, Socket.active Socket.stream) Socket.sock list -> (INetSock.inet, Socket.active Socket.stream) Socket.sock list

    val socket: unit -> 'mode INetSock.stream_sock;


end
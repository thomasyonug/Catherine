signature ASYNCCONN =
sig

    val listen: int -> unit

    val accept: Socket.sock -> (Socket.sock * Socket.sock) option

end
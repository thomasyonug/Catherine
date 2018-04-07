signature READER =
sig
    
    val initReader: unit -> Socket.sock_desc -> string
end
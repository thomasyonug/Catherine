

fun main () = let
    val sock = INetSock.TCP.socket();
    fun loop () = let
        val (s, sa) = Socket.accept sock
        val () = print "comming";
        fun w () = (
            Socket.close s;
            Socket.Ctl.getSockName s;
            w()
        )

    in
        w ()
    end
in
    Socket.bind (sock, INetSock.any 9999);
    Socket.listen (sock, 5);
    loop ()
end



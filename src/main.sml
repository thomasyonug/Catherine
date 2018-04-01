(* structure Catherine =
struct

    type port = int

    fun listen (port: int) = let
        val sock = INetSock.TCP.socket()
    in
        Socket.bind(sock, INetSock.any port); 
        Socket.listen(sock, 5);
        print ("Listening on port " ^ (Int.toString port) ^ "...\n");
        let
            fun accept () = let
                val (s, sa) = Socket.accept sock;
                val vec = Socket.recvVec (s, 1024*80);
                val reqSoFar = String.substring (Byte.bytesToString vec, 0, Word8Vector.length vec);
            in
                print reqSoFar;
                accept ()
            end handle e => (
                print "err";
                Socket.close sock
            )
        in
            accept()
        end
    end
end *)

structure Catherine = Server (
    structure Conn = DefaultConn;
    structure Parser = DefaultParser;
    structure Poll = DefaultPoll;
);
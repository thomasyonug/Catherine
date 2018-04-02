structure DefaultConn : SOCKETCONN =
struct
    fun listen port cb = let
        val sock = INetSock.TCP.socket()
        fun accept () = let
            val (s, sa) = Socket.accept sock;
            val vec = Socket.recvVec (s, 1024*80);
            val reqSoFar = String.substring (Byte.bytesToString vec, 0, Word8Vector.length vec);
            val result = DefaultParser.parse reqSoFar;
        in
            cb(result);
            accept() 
        end handle e => (
            Socket.close sock
        )
    in
        Socket.bind(sock, INetSock.any port);
        Socket.listen(sock, 5);
        accept()
    end
end
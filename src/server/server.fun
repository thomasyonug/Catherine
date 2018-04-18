functor ServerFunctor (
    structure HttpParser : HTTPPARSER;
) =
struct

    structure Process = Posix.Process
    structure Response = Response



    fun receive workSock = let
        val vector = Socket.recvVec (workSock ,1024*80);
        val msg = Byte.bytesToString vector;
    in
        msg
    end handle e => (raise e)


    fun masterCycle masterSock app = let
        val (workSock, workSockAddr) = Socket.accept masterSock;
        val pid = Process.fork()
    in
        case pid 
            of NONE => let
                    val msg = receive workSock
                    val request = HttpParser.parse msg      
                in
                    Socket.close masterSock;
                    app (request, Response.new ());
                    Socket.close workSock;
                    Process.exit(Word8.fromInt 0)
                end
            |  SOME pid => (
                Socket.close workSock;
                masterCycle masterSock app
            )
    end handle e => (Socket.close masterSock; raise e)




    fun listen port app = let
        val masterSock = INetSock.TCP.socket()
    in
        Socket.bind (masterSock, INetSock.any port);
        Socket.listen (masterSock, 5);
        masterCycle masterSock app
    end





end
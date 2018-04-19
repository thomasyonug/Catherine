functor ServerFunctor (
    structure HttpParser : HTTPPARSER;
) =
struct

    structure Process = Posix.Process
    structure Response = Response
    structure Continuation = SMLofNJ.Cont

    fun send sock (response: Response.t) = let
        val {
            protocol,
            status,
            statusDesc,
            header,
            body,
            ...
        } = response
        val vProtocol = !protocol
        and vStatus = !status
        and vStatusDesc = !statusDesc
        and vHeader = !header
        and vBody = !body
        fun connect lst = let
            fun core [] result = result
              | core (x::xs) result = core xs (result ^ x)
        in
            core lst ""
        end
        val v = fn x => Option.getOpt (x, "")
        val blank = " "
        val CRLF = HttpParser.CRLF
        val res = connect (
            [
                v vProtocol,
                blank,
                v vStatus,
                blank,
                v vStatusDesc,
                CRLF
            ] @ 
            (
                map (fn (k, v) => k ^ ": " ^ v ^ CRLF) (StringDict.toList vHeader)
            ) @ 
            [
                CRLF,
                v vBody
            ]
        )
    in
        (* print res; *)
        Socket.sendVec (sock, Word8VectorSlice.full (Byte.stringToBytes res))
    end


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
                    val response = Response.new()
                in
                    Socket.close masterSock;


                    Continuation.callcc (fn cc => app (request, response, fn () => Continuation.throw cc ()));

                    send workSock response;
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
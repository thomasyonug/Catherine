
functor AsyncServer (
    structure Eventloop: EVENtLOOP
    structure AsyncConn: ASYNCCONN
    structure AsyncIO: ASYNCIO
    structure HttpParser: HTTPPARSER
    structure Reader: READER
): ASYNCSERVER =
struct

    val eventQueue = Eventloop.initQueue()
    type EVENT = Eventloop.EVENT


    fun loop mainSock connSocks app eq = let
        val connSocks = case AsyncConn.accept mainSock 
                                of NONE => connSocks 
                                 | SOME (s, sa) => connSocks :: s;
        val (rds, wrs, exs) = AsyncConn.select connSocks;
        val msgs = Reader.read (rds);
        val requests = map (fn (msg, sock) => (HttpParser.parse msg, sock)) msgs
        val events = map (fn (req, sock) => (app req, sock)) requests
        val newQueue = Eventloop.append eq events;
    in
        Eventloop.exec newQueue;
        loop mainSock connSocks app (Eventloop.recovery newQueue) 
    end




    fun listen port app = let
        val mainSock = AsyncConn.listen port
    in
        loop mainSock [] app eq
    end
end
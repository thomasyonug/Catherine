
functor AsyncServer (
    structure Eventloop: EVENTLOOP
    structure AsyncConn: ASYNCCONN
    structure AsyncIO: ASYNCIO
    structure HttpParser: HTTPPARSER
    structure Reader: READER
): ASYNCSERVER =
struct

    type REQUEST = HttpParser.REQUEST
    type RESPONSE = HttpParser.RESPONSE
    val eventQueue = Eventloop.initQueue()
    type EVENT = Eventloop.EVENT
    val read = Reader.initReader()


    fun loop mainSock connSocks app eq = let
        val newConnSocks = case AsyncConn.accept mainSock 
                                of NONE => connSocks 
                                 | SOME (s, sa) => (s :: connSocks)
        val {rds, wrs, exs} = AsyncIO.select newConnSocks;
        val msgs = map (fn sock => (read sock, sock)) rds;
        val requests = map (fn (msg, sock) => (HttpParser.parse msg, sock)) msgs
        val events = map (fn (req, sock) => app req) requests
        val newQueue = Eventloop.append eq events;
    in
        loop mainSock (AsyncConn.recovery newConnSocks) app (Eventloop.exec newQueue) 
    end




    fun listen port app = let
        val mainSock = AsyncConn.socket();
    in
        AsyncConn.listen mainSock port;
        loop mainSock [] app eventQueue
    end
end

functor AsyncServer (
    structure Eventloop: EVENTLOOP
    structure AsyncConn: ASYNCCONN
    structure AsyncIO: ASYNCIO
    structure HttpParser: HTTPPARSER
    structure Reader: READER
) =
struct

    type REQUEST = HttpParser.REQUEST
    type RESPONSE = HttpParser.RESPONSE
    val eventQueue = Eventloop.initQueue()
    val read = Reader.initReader()


    type EVENT = Eventloop.EVENT
    val EventDoing = Eventloop.Doing
    val EventDone  = Eventloop.Done
    val EventEmpty = Eventloop.Empty


    fun loop mainSock connSocks app eq = let
        val newConnSocks = case AsyncConn.accept mainSock 
                                of NONE => connSocks 
                                 | SOME (s, sa) => (s :: connSocks);
        val {rds, wrs, exs, rdsDescs, wrsDescs, exsDescs} = AsyncIO.select newConnSocks;
        val msgs = map (fn (desc, s) => (read desc s, s)) rdsDescs;
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
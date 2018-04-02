
functor Server (
    structure Conn : SOCKETCONN
    structure Parser : HTTPPARSER
    structure Poll : THREADPOLL
) =
struct
    fun listen port cb = Conn.listen port cb;
end
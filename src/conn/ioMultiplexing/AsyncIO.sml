structure AsyncIO: ASYNCIO =
struct
    fun select socks = let
        val sockDescs = map (fn sock => Socket.sockDesc sock) socks
    in
        Socket.select {
            rds = sockDescs,
            wrs = sockDescs,
            exs = sockDescs,
            timeout = SOME Time.zeroTime
        }
    end
end
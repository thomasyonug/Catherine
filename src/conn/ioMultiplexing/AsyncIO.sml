structure AsyncIO: ASYNCIO =
struct
    fun select socks = let
        val sockDescs = map (fn sock => Socket.sockDesc sock) socks
        val {rds, wrs, exs} = Socket.select {
            rds = sockDescs,
            wrs = sockDescs,
            exs = sockDescs,
            timeout = SOME Time.zeroTime
        };
        fun zip [] = []
          | zip (desc::descs) = 
              case List.find (fn s => Socket.sameDesc (Socket.sockDesc s, desc)) socks
                of NONE => (print "none"; zip(descs))
                 | SOME s => (print "some"; (desc, s) :: zip (descs));
    in
        {
            rds = rds,
            wrs = wrs,
            exs = exs,
            rdsDescs = zip rds,
            wrsDescs = [],
            exsDescs = [] 
        }
    end
end
structure Web =
struct
    structure Static = Static


    fun run () = Catherine.listen 9999 (fn (req, res, done) => (
        let
          val headerGetter = (#getHeader req)
          val handler = Static.init (OS.FileSys.fullPath "./web/public") "/"

          fun defaultHead () = (
            (#setProtocol res) (headerGetter "protocol"),
            (#setStatus res) "200",
            (#setStatusDesc res) "OK"
          )
        in
          defaultHead();
          handler (headerGetter "route") res done
        end 
        (* handle e => let
        in
            (#setStatus res) "500";
            (#setStatusDesc res) "error"
        end *)
    ))

end
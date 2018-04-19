
structure Test =
struct


    fun run () = Catherine.listen 9999 (fn (req, res, done) => (
        let
            val map = (#getHeader req)
            val body = (#getBody req) ()
            val primi = #primitive req
        in
            (#setProtocol res) "HTTP/1.1";
            (#setStatus res) "200";
            (#setStatusDesc res) "OK";
            (#setBody res) "hello world"
        end
    ))

    fun fuck () = let
        val regexes = [
          ("html$", fn match => "text/html;charset=utf-8")
        ]
    in
        Option.getOpt(StringCvt.scanString (Re.match regexes) "sdf.html", "text/plain")
    end

end
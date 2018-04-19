
structure Test =
struct


    fun run () = Catherine.listen 9999 (fn (req, res) => (
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
    in
        ListExt.join ["hello", "fuck", "nimabi"] "," 
    end

end

structure Test =
struct


    fun run () = Catherine.listen 9999 (fn (req, res) => (
        let
            val map = (#getHeader req)
            val body = (#getBody req) ()
            val primi = #primitive req
        in
            print "\n";
            print "\n";
            print "\n";
            print "\n";
            print "\n";
            print "\n";
            print "\n";
            print body;
            print "\n"
        end
    ))

    fun fuck () = let
    in
        ListExt.join ["hello", "fuck", "nimabi"] "," 
    end

end
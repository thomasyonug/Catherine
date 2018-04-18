
structure Test =
struct


    fun run () = Catherine.listen 9999 (fn req => (
        let
            val map = (#getHeader req)
        in
            print (map "method");
            print "\n";
            print (map "route");
            print "\n";
            print (map "protocol");
            print "\n";
            print (#primitive req);
            print "\n"
        end
    ))

    fun fuck () = let
    in
        ListExt.join ["hello", "fuck", "nimabi"] "," 
    end

end
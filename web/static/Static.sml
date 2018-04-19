structure Static =
struct


    fun readFileData fileStream = case TextIO.inputLine fileStream 
        of NONE => "" 
         | SOME s => s ^ (readFileData fileStream);


    fun mime path = let
        val {dir, file} = OS.Path.splitDirFile path
        val resource = [
            ("html", "text/html; charset=utf-8")
        ]
        fun find [] = "text/plain"
          | find ((k, v)::xs) = if String.isSubstring k file then v else find xs
    in
        find resource 
    end




    fun init path prefix route (res: Catherine.Response.t) done = let
        val {
            setBody,
            setHeader,
            setStatus,
            ...
        } = res
    in
        if String.isPrefix prefix route 
        then 
            let
                val realPath = "/" ^ String.extract (route, String.size prefix, NONE)
                val relaPath = path ^ route
                val fileStream = if route = "/" then (
                    let
                        val p = path ^ "/index.html"
                        val stream = TextIO.openIn p
                        val fileData = readFileData stream
                    in
                        setHeader "Content-Type" (mime p);
                        setBody fileData;
                        done();
                        stream
                    end
                ) else TextIO.openIn relaPath 
                    handle (e as IO.Io {name, function, cause}) => (
                        let
                            val stream = TextIO.openIn (path ^ "/404.html")
                            val fileData = readFileData stream
                        in
                            setStatus "404";
                            setBody fileData;
                            done();
                            stream
                        end
                    );
                val fileData = readFileData fileStream;
            in
                setBody fileData;
                setHeader "Content-Type" (mime relaPath);
                done()
            end 
        else
            ()
    end

end
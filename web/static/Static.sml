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




    fun init path prefix route setBody setHeader done = let
    in
        if String.isPrefix prefix route 
        then 
            let
                val realPath = "/" ^ String.extract (route, String.size prefix, NONE)
                val relaPath = path ^ route
                val fileStream = TextIO.openIn relaPath 
                                    handle (e as IO.Io {name, function, cause}) => (
                                        if (route = "/") then 
                                            (
                                                TextIO.openIn (path ^ "/index.html")
                                            )
                                        else TextIO.openIn (path ^ "/404.html") handle e => (raise e)
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
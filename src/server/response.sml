structure Response =
struct

    type t = {
      protocol: string option ref,
      status: string option ref,
      statusDesc: string option ref,
      header: string StringDict.t ref,
      body: string option ref,
      setProtocol: string -> unit, 
      setStatus: string -> unit,
      setStatusDesc: string -> unit,
      setHeader: string -> string -> unit,
      setBody: string -> unit

    }

    fun new () = let
        val res = {
          protocol = ref NONE,
          status = ref NONE,
          statusDesc = ref NONE,
          header = ref (StringDict.set (StringDict.empty, "X-Powered-By", "Catherine/0.0.1 in StandardML")),
          body = ref NONE
        } 
        fun setProtocol s = (#protocol res) := SOME s;
        fun setStatus s = (#status res) := SOME s;
        fun setStatusDesc s = (#statusDesc res) := SOME s;
        fun setHeader k v = (
          (#header res) := StringDict.set ((!(#header res)), k, v);
          ()
        );
        fun setBody s = (#body res) := SOME s;
    in
        {
          protocol = (#protocol res),
          status = (#status res),
          statusDesc = (#statusDesc res),
          header = (#header res),
          body = (#body res),
          setProtocol = setProtocol,
          setStatus = setStatus,
          setStatusDesc = setStatusDesc,
          setHeader = setHeader,
          setBody = setBody
        }
    end


end
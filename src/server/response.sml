structure Response =
struct

    (* type t = {
      protocol: string option,
      status: string option,
      statusDesc: string option,
      header: StringDict.t,
      body: string option
    } *)

    fun new () = let
        val res = {
          protocol = ref NONE,
          status = ref NONE,
          statusDesc = ref NONE,
          header = ref StringDict.empty,
          body = ref NONE
        } 
        fun setProtocol s = (#protocol res) := SOME s;
        fun setStatus s = (#status res) := SOME s;
        fun setStatusDesc s = (#statusDesc res) := SOME s;
        fun setHeader k v = (#header res) := StringDict.set ((!(#header res)), k, v);
        fun setbody s = (#body res) := SOME s;
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
          setbody = setbody
        }
    end


end
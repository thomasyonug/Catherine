

structure StringOrder: ORDER = 
struct
    type t = string 
    val compare = String.compare
end

structure StringDict = Dictionary(StringOrder)






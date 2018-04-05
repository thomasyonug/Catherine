functor Fuck (type a) =
struct
  type b = a
end


fun aGen () = Fuck (type a = int)

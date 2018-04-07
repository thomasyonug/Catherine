functor Dictionary (Key : ORDER) =
struct

    type key = Key.t

    abstype 'a t = Leaf
                 | Bran of key * 'a * 'a t * 'a t
        with
        exception E of key;
        val empty = Leaf;

        fun get (Leaf, b) = raise E b
          | get (Bran (a, x, t1, t2), b) = 
                case Key.compare(a, b) of
                    GREATER => get (t1, b)
                  | EQUAL => x
                  | LESS => get (t2, b);

        (* fun insert (Leaf, b, y) = Bran(b, y, Leaf, Leaf)
          | insert (Bran (a, x, t1, t2), b, y) =
            case Key.compare(a, b) of
                GREATER => Bran(a, x, insert(t1, b, y), t2)
              | EQUAL => raise E b
              | LESS => Bran(a, b, t1, insert(t2, b, y)); *)
    
        fun set (Leaf, b, y) = Bran(b, y, Leaf, Leaf)
          | set (Bran(a, x, t1, t2), b, y) = case Key.compare(a, b) of
                GREATER => Bran(a, x, set(t1, b, y), t2)
              | EQUAL => Bran(a, y, t1, t2)
              | LESS => Bran(a, x, t1, set(t2, b, y));

    end
end
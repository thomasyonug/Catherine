structure Parse : sig val parse : string -> Absyn.exp list  end =
struct 
  structure TinySchemeLrVals = TinySchemeLrValsFun(structure Token = LrParser.Token)
  structure Lex = TinySchemeLexFun(structure Tokens = TinySchemeLrVals.Tokens)
  structure TigerP = Join(structure ParserData = TinySchemeLrVals.ParserData
			structure Lex=Lex
			structure LrParser = LrParser)
  fun parse filename =
      let 
      (* val _ = (ErrorMsg.reset(); ErrorMsg.fileName := filename) *)
	  val file = TextIO.openIn filename
	  fun get _ = TextIO.input file
	  fun parseerror(s,p1,p2) = ErrorMsg.error p1 s
	  val lexer = LrParser.Stream.streamify (Lex.makeLexer get)
	  val (absyn, _) = TigerP.parse(30,lexer,parseerror,())
       in TextIO.closeIn file;
	   absyn
      end handle LrParser.ParseError => raise ErrorMsg.Error

end





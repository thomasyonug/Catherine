
type pos = int

fun getInt(optionInt : int option) = case optionInt of
  SOME(n) => n
  | _ => (print "getInt error"; 0)


fun eof() = Tokens.EOF(0,0) 

type svalue = Tokens.svalue
type ('a, 'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue, pos) token

%%

%header (functor TinySchemeLexFun (structure Tokens: TinyScheme_TOKENS));

digit = [0-9];
space = [\ \t];
letter = [a-zA-Z];
id = {letter}({letter}|{digit}|_|')*;
number = {digit}+;
xmlContent = ({letter}|{digit})*;

%%

<INITIAL>"("                 => (Tokens.LEFTPARENTHESIS(yypos, yypos + 1));
<INITIAL>")"                 => (Tokens.RIGHTPARENTHESIS(yypos, yypos + 1));
<INITIAL>{number}             => (Tokens.NUMBER((getInt o Int.fromString) yytext, yypos, yypos + size yytext));

<INITIAL>"/"        => (Tokens.DIV(yypos, yypos + 1));
<INITIAL>"*"        => (Tokens.MUL(yypos, yypos + 1));
<INITIAL>"-"        => (Tokens.MINUS(yypos, yypos + 1));
<INITIAL>"+"        => (Tokens.PLUS(yypos, yypos + 1));
<INITIAL>">"        => (Tokens.GT(yypos, yypos + 1));
<INITIAL>"<"        => (Tokens.LT(yypos, yypos + 1));
<INITIAL>"="        => (Tokens.EQ(yypos, yypos + 1));

<INITIAL>"define"   => (Tokens.DEFINE(yypos, yypos + 6));
<INITIAL>"lambda"   => (Tokens.LAMBDA(yypos, yypos + 6));
<INITIAL>"cond"     => (Tokens.COND(yypos, yypos + 4));
<INITIAL>{id}       => (Tokens.ID(yytext, yypos, yypos + size yytext));
<INITIAL>{xmlContent}   => (Tokens.XMLCONTENT(yytext, yypos, yypos + size yytext));
<INITIAL>\<{id}+\>  => (Tokens.OPENTAG(yytext, yypos, yypos + size yytext));
<INITIAL>\<\/{id}+\>  => (Tokens.CLOSETAG(yytext, yypos, yypos + size yytext));



{space}+      => (continue());
"\n"            => (continue());



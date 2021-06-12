structure Tokens= Tokens
  
  type pos = int
  type svalue = Tokens.svalue
  type ('a,'b) token = ('a,'b) Tokens.token  
  type lexresult = (svalue, pos) token
  val str = ref ""
  val str1 = ref ""
  val pos = ref 0
  val eof = fn () => Tokens.EOF(!pos, !pos)
  val error = fn (e, _) => TextIO.output(TextIO.stdOut,e ^ "\n")
  val linenum = ref 1
  val colnum = ref 1
  fun revfold _ nil b = b
  | revfold f (hd::tl) b = revfold f tl (f(hd,b))
  fun refinc x =  (x := !x + 1; !x)
  fun setone x =  (x := 1; !x)
  fun strappend s = ()
  fun init() = ()
%%
%header (functor CalcLexFun(structure Tokens:Calc_TOKENS));
alpha=[A-Za-z];
digit=[0-9];
ws = [\ \t];
%%
\n       => (pos := (!pos) + 1; refinc linenum; setone colnum; lex());
{ws}+    => (colnum:= (!colnum) + size(yytext); lex());
"("      => (str:= (!str)^(", LPAREN \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.LPAREN(!pos,!pos));
")"      => (str:= (!str)^(", RPAREN \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.RPAREN(!pos,!pos));
"TRUE"   => (str:= (!str)^(", CONST \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.CONST(yytext,!pos,!pos));
"FALSE"  => (str:= (!str)^(", CONST \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.CONST(yytext,!pos,!pos));
"NOT"    => (str:= (!str)^(", NOT \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.NOT(!pos,!pos));
"AND"    => (str:= (!str)^(", AND \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.AND(!pos,!pos));
"OR"     => (str:= (!str)^(", OR \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.OR(!pos,!pos));
"XOR"    => (str:= (!str)^(", XOR \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.XOR(!pos,!pos));
"EQUALS" => (str:= (!str)^(", EQUALS \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.EQUALS(!pos,!pos));
"IMPLIES"=> (str:= (!str)^(", IMPLIES \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.IMPLIES(!pos,!pos));
"IF"     => (str:= (!str)^(", IF \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.IF(!pos,!pos));
"THEN"   => (str:= (!str)^(", THEN \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.THEN(!pos,!pos));
"ELSE"   => (str:= (!str)^(", ELSE \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.ELSE(!pos,!pos));
";"      => (str:= (!str)^(", TERM \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.TERM(!pos,!pos));
{alpha}+ => (str:= (!str)^(", ID \""^yytext^"\"");colnum:= (!colnum) + size(yytext); Tokens.ID(yytext,!pos,!pos));
.        => (str1:= (!str1)^("Unknown Token:"^Int.toString(!linenum)^":"^Int.toString(!colnum)^":"^yytext^"\n"); colnum:= (!colnum) + size(yytext); lex());

exception InvalidTokensCannotBeParsed
structure CalcLrVals = CalcLrValsFun(structure Token = LrParser.Token)
structure CalcLex = CalcLexFun(structure Tokens = CalcLrVals.Tokens);
structure CalcParser =
	  Join(structure LrParser = LrParser
     	       structure ParserData = CalcLrVals.ParserData
     	       structure Lex = CalcLex)     
fun invoke lexstream =
    	     	let 
    	     	val noExp = ref 0
    	     	fun print_error (s,pos:int,_) =
    	     	if(String.compare(s,"")=GREATER) then
		    	(noExp:= !noExp +1;TextIO.output(TextIO.stdOut, "Syntax Error:" ^ Int.toString(!CalcLex.UserDeclarations.linenum) ^ ":" ^ Int.toString(!CalcLex.UserDeclarations.colnum) ^ ": " ^ List.last(!PreOrderTraversalOfParseTree.r)^"\n");CalcLex.UserDeclarations.linenum:= 1) else (noExp := !noExp +1; TextIO.output(TextIO.stdOut,""))
		in
		    CalcParser.parse(0,lexstream,print_error,())
		end
fun newLexer fcn =
		let val lexer = CalcParser.makeLexer fcn
		    val _ = CalcLex.UserDeclarations.init()
		in 
			lexer
		end
fun stringToLexer str =
    let val done = ref false
    	val lexer=  CalcParser.makeLexer (fn _ => if (!done) then "" else (done:=true;str))
    in
	lexer
    end	
fun fileToLexer filename =
	let 
		val inStream = TextIO.openIn(filename)
	in 
		newLexer (fn n => TextIO.inputAll(inStream))
	end
fun parse (lexer) =
    let val dummyEOF = CalcLrVals.Tokens.EOF(0,0)
    	val (result, lexer) = invoke lexer
	val (nextToken, lexer) = CalcParser.Stream.get lexer
    in
        if CalcParser.sameToken(nextToken, dummyEOF) then (CalcLex.UserDeclarations.str := ""; CalcLex.UserDeclarations.str1 := ""; CalcLex.UserDeclarations.linenum := 1;  CalcLex.UserDeclarations.colnum := 1; result)
 	else (TextIO.output(TextIO.stdOut, "Warning: Unconsumed input \n"); result)
    end
fun fileToScanner filename =
	let 
		val inStream = TextIO.openIn(filename)
	in CalcLex.makeLexer (fn n => TextIO.inputAll(inStream))
	end
fun scannerToTokens scanner =
	let fun recur () =
		let
			val dummyEOF = CalcLrVals.Tokens.EOF(0,0)
			val token = scanner()
		in if (CalcParser.sameToken(token, dummyEOF) andalso !CalcLex.UserDeclarations.str1="") then (print("["^String.extract(!CalcLex.UserDeclarations.str,2,NONE)^"]\n"); CalcLex.UserDeclarations.str := ""; CalcLex.UserDeclarations.str1 := ""; CalcLex.UserDeclarations.linenum := 1;  CalcLex.UserDeclarations.colnum := 1; true) else if CalcParser.sameToken(token, dummyEOF) then (print(!CalcLex.UserDeclarations.str1); CalcLex.UserDeclarations.str := ""; CalcLex.UserDeclarations.str1 := ""; CalcLex.UserDeclarations.linenum := 1;  CalcLex.UserDeclarations.colnum := 1; false) else recur()
		end
	in recur()
	end
val parseString = parse o stringToLexer
val parseFile = parse o fileToLexer
val lexFile = scannerToTokens o fileToScanner
fun ParseLex f = if (lexFile f) then parseFile f else raise InvalidTokensCannotBeParsed

structure PreOrderTraversalOfParseTree =
struct
datatype exp = statement_GOESTO_formula_TERM of exp * term
| Start_GOESTO_program of exp
| program_GOESTO_statement_program of exp * exp
| program_GOESTO_statement of exp
| formula_GOESTO_ID of Id
| formula_GOESTO_CONST of Const
| formula_GOESTO_NOT_formula of Not * exp
| formula_GOESTO_formula_AND_formula of exp * And * exp
| formula_GOESTO_formula_OR_formula of exp * Or * exp
| formula_GOESTO_formula_XOR_formula of exp * Xor * exp
| formula_GOESTO_formula_EQUALS_formula of exp * Equals * exp
| formula_GOESTO_formula_IMPLIES_formula of exp * implies * exp
| formula_GOESTO_IF_formula_THEN_formula_ELSE_formula of If * exp * Then * exp * Else* exp
| formula_GOESTO_LPAREN_formula_RPAREN of lparen * exp * rparen
and Id = ID of string
and Const = CONST of string
and Not = NOT of string
and And = AND of string
and Or = OR of string
and Xor = XOR of string
and Equals = EQUALS of string
and implies = IMPLIES of string
and If = IF of string
and Then = THEN of string
and Else = ELSE of string
and lparen = LPAREN of string
and rparen = RPAREN of string
and term = TERM of string
and eof = EOF
val r = ref [""]
end

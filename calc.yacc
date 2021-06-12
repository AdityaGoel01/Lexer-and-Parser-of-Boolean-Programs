%%
%name Calc
%eop EOF
%pos int
%term  ID of string | CONST of string | LPAREN | RPAREN | NOT | AND | OR  | XOR | EQUALS | IMPLIES | IF | THEN | ELSE | TERM | EOF 
%nonterm Start of PreOrderTraversalOfParseTree.exp | program of PreOrderTraversalOfParseTree.exp | statement of PreOrderTraversalOfParseTree.exp | formula of PreOrderTraversalOfParseTree.exp
%pure
%noshift EOF
%right IF THEN ELSE
%right IMPLIES
%left AND OR XOR EQUALS
%right NOT
%nonassoc LPAREN RPAREN
%start Start
%verbose
%%
  Start   : program (PreOrderTraversalOfParseTree.r:= ["Start_GOESTO_program"];PreOrderTraversalOfParseTree.Start_GOESTO_program(program))
  program : statement program (PreOrderTraversalOfParseTree.r:= ["program_GOESTO_statement_program"];PreOrderTraversalOfParseTree.program_GOESTO_statement_program(statement,program))
          | statement (PreOrderTraversalOfParseTree.r:= ["program_GOESTO_statement"];PreOrderTraversalOfParseTree.program_GOESTO_statement(statement))
  statement : formula TERM (PreOrderTraversalOfParseTree.r:= ["statement_GOESTO_formula_TERM"];PreOrderTraversalOfParseTree.statement_GOESTO_formula_TERM(formula,PreOrderTraversalOfParseTree.TERM(";")))
  formula : ID (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_ID"];PreOrderTraversalOfParseTree.formula_GOESTO_ID(PreOrderTraversalOfParseTree.ID(ID)))
          | CONST (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_CONST"];PreOrderTraversalOfParseTree.formula_GOESTO_CONST(PreOrderTraversalOfParseTree.CONST(CONST)))
          | NOT formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_NOT_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_NOT_formula(PreOrderTraversalOfParseTree.NOT("NOT"),formula))
          | formula AND formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_formula_AND_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_formula_AND_formula(formula1,PreOrderTraversalOfParseTree.AND("AND"),formula2))          
          | formula OR formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_formula_OR_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_formula_OR_formula(formula1,PreOrderTraversalOfParseTree.OR("OR"),formula2))
          | formula XOR formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_formula_XOR_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_formula_XOR_formula(formula1,PreOrderTraversalOfParseTree.XOR("XOR"),formula2))
          | formula EQUALS formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_formula_EQUALS_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_formula_EQUALS_formula(formula1,PreOrderTraversalOfParseTree.EQUALS("EQUALS"),formula2))
          | formula IMPLIES formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_formula_IMPLIES_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_formula_IMPLIES_formula(formula1,PreOrderTraversalOfParseTree.IMPLIES("IMPLIES"),formula2))
          | IF formula THEN formula ELSE formula (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_IF_formula_THEN_formula_ELSE_formula"];PreOrderTraversalOfParseTree.formula_GOESTO_IF_formula_THEN_formula_ELSE_formula(PreOrderTraversalOfParseTree.IF("IF"),formula1,PreOrderTraversalOfParseTree.THEN("THEN"),formula2,PreOrderTraversalOfParseTree.ELSE("ELSE"),formula3))
          | LPAREN formula RPAREN (PreOrderTraversalOfParseTree.r:= ["formula_GOESTO_LPAREN_formula_RPAREN"];PreOrderTraversalOfParseTree.formula_GOESTO_LPAREN_formula_RPAREN(PreOrderTraversalOfParseTree.LPAREN("("),formula1,PreOrderTraversalOfParseTree.RPAREN(")")))

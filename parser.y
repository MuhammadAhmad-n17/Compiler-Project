%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yylineno;
void yyerror(const char *s);
%}

/* ===== Tokens from Phase 01 ===== */

%token INT_BANKAI FLOAT_BANKAI
%token IF_BANKAI ELSE_BANKAI
%token WHILE_BANKAI FOR_BANKAI
%token CIN_BANKAI DISPLAY_BANKAI

%token ID NUM
%token ADD SUB MUL DIV REM
%token EQEQ ASSIGN
%token LSHIFT RSHIFT
%token SEMI LPAREN RPAREN LBRACE RBRACE

%%

/* ===== Program ===== */
program
    : stmt_list
      { printf("Syntax analysis successful\n"); }
    ;

/* ===== Statement List ===== */
stmt_list
    : stmt stmt_list
    | stmt
    ;

/* ===== Statements ===== */
stmt
    : decl_stmt
    | assign_stmt
    | if_stmt
    | loop_stmt
    | io_stmt
    ;

/* ===== Declaration ===== */
decl_stmt
    : INT_BANKAI ID SEMI
    | FLOAT_BANKAI ID SEMI
    ;

/* ===== Assignment ===== */
assign_stmt
    : ID ASSIGN expr SEMI
    ;

/* ===== Conditional ===== */
if_stmt
    : IF_BANKAI LPAREN expr EQEQ expr RPAREN block
    | IF_BANKAI LPAREN expr EQEQ expr RPAREN block ELSE_BANKAI block
    ;

/* ===== Loops ===== */
loop_stmt
    : WHILE_BANKAI LPAREN expr EQEQ expr RPAREN block
    | FOR_BANKAI LPAREN assign_stmt expr EQEQ expr SEMI assign_stmt RPAREN block
    ;

/* ===== Input / Output ===== */
io_stmt
    : CIN_BANKAI RSHIFT ID SEMI
    | DISPLAY_BANKAI LSHIFT expr SEMI
    ;

/* ===== Block ===== */
block
    : LBRACE stmt_list RBRACE
    ;

/* ===== Expressions ===== */
expr
    : expr ADD term
    | expr SUB term
    | term
    ;

term
    : term MUL factor
    | term DIV factor
    | term REM factor
    | factor
    ;

factor
    : ID
    | NUM
    ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error at line %d\n", yylineno);
}

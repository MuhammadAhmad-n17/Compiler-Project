%option yylineno
%{
#include <stdio.h>
#include "parser.tab.h"





%}

LETTER   [a-zA-Z]
DIGIT    [0-9]
ID       {LETTER}(({LETTER}|{DIGIT}|_)*({LETTER}|{DIGIT}))?
INTEGER  [+-]?{DIGIT}+
FLOAT    [+-]?{DIGIT}+\.{DIGIT}+

%%
"int_bankai"      { return INT_BANKAI; }
"float_bankai"    { return FLOAT_BANKAI; }

"if_bankai"       { return IF_BANKAI; }
"else_bankai"     { return ELSE_BANKAI; }

"display_bankai"  { return DISPLAY_BANKAI; }
"cin_bankai"      { return CIN_BANKAI; }

"for_bankai"      { return FOR_BANKAI; }
"while_bankai"    { return WHILE_BANKAI; }

{FLOAT}           { return NUM; }
{INTEGER}         { return NUM; }
{ID}              { return ID; }

"add+"            { return ADD; }
"sub-"            { return SUB; }
"mul*"            { return MUL; }
"div/"            { return DIV; }
"rem%"            { return REM; }

"=="              { return EQEQ; }
"="               { return ASSIGN; }

"<<"              { return LSHIFT; }
">>"              { return RSHIFT; }

";"               { return SEMI; }

"{b"              { return LBRACE; }
"}"               { return RBRACE; }

"("               { return LPAREN; }
")"               { return RPAREN; }

[ \t\r\n]+        { /* ignore whitespace */ }

"#"[^\n]*"#"      { /* ignore comment */ }

. {
    printf("Lexical Error at line %d: %s\n", yylineno, yytext);
}
%%

int yywrap() {
    return 1;
}


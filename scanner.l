%{
#include <stdio.h>
int line_num = 1;
FILE *token_file;
FILE *error_file;

void print_token(const char* type) {
    printf("Line %d: %s %s\n", line_num, type, yytext);
    fprintf(token_file, "Line %d: %s %s\n", line_num, type, yytext);
}

void yyerror(const char* msg) {
    printf("Line %d: ERROR %s %s\n", line_num, msg, yytext);
    fprintf(error_file, "Line %d: ERROR %s %s\n", line_num, msg, yytext);
}
%}

LETTER   [a-zA-Z]
DIGIT    [0-9]
ID       {LETTER}({LETTER}|{DIGIT}|_)*
INTEGER  [+-]?{DIGIT}+
FLOAT    [+-]?{DIGIT}+\.{DIGIT}+

%%

"int_bankai"      { print_token("KEYWORD_INT"); }
"char_bankai"     { print_token("KEYWORD_CHAR"); }
"float_bankai"    { print_token("KEYWORD_FLOAT"); }
"string_bankai"   { print_token("KEYWORD_STRING"); }
"void_bankai"     { print_token("KEYWORD_VOID"); }
"if_bankai"       { print_token("KEYWORD_IF"); }
"else_bankai"     { print_token("KEYWORD_ELSE"); }
"display_bankai"  { print_token("KEYWORD_DISPLAY"); }
"cin_bankai"      { print_token("KEYWORD_CIN"); }
"for_bankai"      { print_token("KEYWORD_FOR"); }
"while_bankai"    { print_token("KEYWORD_WHILE"); }
"return_bankai"   { print_token("KEYWORD_RETURN"); }
"continue_bankai" { print_token("KEYWORD_CONTINUE"); }
"break_bankai"    { print_token("KEYWORD_BREAK"); }
"main_bankai"     { print_token("KEYWORD_MAIN"); }

{FLOAT}           { print_token("NUMBER_FLOAT"); }
{INTEGER}         { print_token("NUMBER_INTEGER"); }
{ID}              { print_token("IDENTIFIER"); }

"add+"            { print_token("OP_ADD"); }
"sub-"            { print_token("OP_SUB"); }
"mul*"            { print_token("OP_MUL"); }
"div/"            { print_token("OP_DIV"); }
"rem%"            { print_token("OP_REM"); }
"=="              { print_token("OP_RELATIONAL_EQ"); }
"="               { print_token("OP_ASSIGN"); }
"<<"              { print_token("OP_SHIFT_LEFT"); }
">>"              { print_token("OP_SHIFT_RIGHT"); }
"<"               { print_token("OP_RELATIONAL_LT"); }
">"               { print_token("OP_RELATIONAL_GT"); }

";"               { print_token("PUNC_SEMICOLON"); }
","               { print_token("PUNC_COMMA"); }
"{b"              { print_token("PUNC_LBRACE"); }
"}"               { print_token("PUNC_RBRACE"); }
"("               { print_token("PUNC_LPAREN"); }
")"               { print_token("PUNC_RPAREN"); }

"#"[^\n]*"#"      { print_token("COMMENT"); }
\"([^"\\]|\\.)*\" { print_token("STRING_LITERAL"); }
'.'               { print_token("CHAR_LITERAL"); }

[ \t]+            { }
(\r?\n)+          { line_num += yyleng; }
.                 { yyerror("Unrecognized Symbol"); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    token_file = fopen("tokens.txt", "w");
    if (!token_file) {
        perror("tokens.txt");
        return 1;
    }

    error_file = fopen("error_file.txt", "w");
    if (!error_file) {
        perror("error_file.txt");
        return 1;
    }

    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    }

    printf("--- C++ Bankai Mode Lexical Analysis Started ---\n");
    yylex();
    printf("--- C++ Bankai Mode Lexical Analysis Finished ---\n");

    fclose(token_file);
    fclose(error_file);

    return 0;
}
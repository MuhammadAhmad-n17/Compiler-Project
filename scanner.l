%{
#include <stdio.h>
/* Global variable to track line numbers (Requirement: Line Tracking) */
int line_num = 1;

/* Function to print the token in the required format */
void print_token(const char* type) {
    /* Required Output Format: Line <n>: <TOKEN TYPE> <lexeme> */
    printf("Line %d: %s %s\n", line_num, type, yytext);
}

/* Function to handle errors (Requirement: Error Handling) */
void yyerror(const char* msg) {
    printf("Line %d: ERROR %s %s\n", line_num, msg, yytext);
}
%}

/* * Regular Definitions Section
 * Define reusable patterns based on your REs
 */
LETTER   [a-zA-Z]
DIGIT    [0-9]
/* Identifier RE: Must start with a letter, followed by letters, digits, or underscore */
ID       {LETTER}({LETTER}|{DIGIT}|_)*
/* Integer RE: Optional sign followed by one or more digits */
INTEGER  [+-]?{DIGIT}+
/* Float RE: Optional sign, one or more digits, dot, one or more digits (No exponential form as per your RE) */
FLOAT    [+-]?{DIGIT}+\.{DIGIT}+


%%
/* * Rules Section - Token Definitions
 * Keywords must be listed before the general Identifier rule due to Flex's longest match principle.
 */

/* ------------------ 15 CUSTOM KEYWORDS ------------------ */
"int_bankai"     { print_token("KEYWORD_INT"); }
"char_bankai"    { print_token("KEYWORD_CHAR"); }
"float_bankai"   { print_token("KEYWORD_FLOAT"); }
"string_bankai"  { print_token("KEYWORD_STRING"); }
"void_bankai"    { print_token("KEYWORD_VOID"); }
"if_bankai"      { print_token("KEYWORD_IF"); }
"else_bankai"    { print_token("KEYWORD_ELSE"); }
"display_bankai" { print_token("KEYWORD_DISPLAY"); }
"cin_bankai"     { print_token("KEYWORD_CIN"); }
"for_bankai"     { print_token("KEYWORD_FOR"); }
"while_bankai"   { print_token("KEYWORD_WHILE"); }
"return_bankai"  { print_token("KEYWORD_RETURN"); }
"continue_bankai"{ print_token("KEYWORD_CONTINUE"); }
"break_bankai"   { print_token("KEYWORD_BREAK"); }
"main_bankai"    { print_token("KEYWORD_MAIN"); }

/* ------------------ IDENTIFIERS and NUMBERS ------------------ */
{FLOAT}          { print_token("NUMBER_FLOAT"); }
{INTEGER}        { print_token("NUMBER_INTEGER"); }
{ID}             { print_token("IDENTIFIER"); }

/* ------------------ CUSTOM OPERATORS (As per your RE) ------------------ */
"add+"           { print_token("OP_ADD"); }
"sub-"           { print_token("OP_SUB"); }
"mul*"           { print_token("OP_MUL"); }
"div/"           { print_token("OP_DIV"); }
"rem%"           { print_token("OP_REM"); }
"=="             { print_token("OP_RELATIONAL_EQ"); }
"="              { print_token("OP_ASSIGN"); } /* Assuming standard assignment is needed */
"<"              { print_token("OP_RELATIONAL_LT"); } /* Assuming other standard comparison is needed */
">"              { print_token("OP_RELATIONAL_GT"); } /* Assuming other standard comparison is needed */

/* ------------------ CUSTOM PUNCTUATIONS (As per your RE) ------------------ */
";"              { print_token("PUNC_SEMICOLON"); }
","              { print_token("PUNC_COMMA"); }
"{b"             { print_token("PUNC_LBRACE"); }
"}"              { print_token("PUNC_RBRACE"); }
"("              { print_token("PUNC_LPAREN"); } /* Assuming standard parentheses are needed */
")"              { print_token("PUNC_RPAREN"); } /* Assuming standard parentheses are needed */

/* ------------------ STRINGS, CHARACTERS, and COMMENTS ------------------ */
"#" [^#\n]* "#"  { print_token("COMMENT"); } /* Your custom comment RE: #...# */
\"([^"\\]|\\.)*\" { print_token("STRING_LITERAL"); }
'.'              { print_token("CHAR_LITERAL"); }

/* ------------------ WHITESPACE and ERRORS ------------------ */
[ \t]+           { /* Ignore Spaces and Tabs */ }
\n               { line_num++; } /* Increment line counter on newline */
.                { yyerror("Unrecognized Symbol"); } /* Error for any unmatched character */

%%
/* * User Code Section
 * The main function to compile and run the scanner.
 */
int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        /* Open the file provided as a command-line argument */
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

    return 0;
}
%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    // int no_of_lines = 0;
    // int no_of_chars = 0;
    int yylval;
    // tokens and classes (operators last and in precedence order)
    enum {
        NUM = 128, FUN, SYS, GLO, LOC, ID, STR,
        CHAR, ELSE, ENUM, IF, INT, RETURN, SIZEOF, WHILE,
        ASSIGN, COND, LOR, LAN, OR, XOR, AND, EQ, NE, LT, GT, LE, GE, SHL, SHR, ADD, SUB, MUL, DIV, MOD, INC, DEC, BRAK,
        MAIN
    };

%}
wrap        [\n]
delim	    [ \t]
ws		    {delim}+
letter	    [A-Za-z]
digit	    [0-9]
id		    {letter}({letter}|{digit})*
number	    {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
str         \".*\"
p_define    ^"#".*
punctuation [;(){}]

/* then	{ printf("%s", yytext); return THEN; } */
%%
{p_define}  {}
{ws}	{}
if		{ printf("IF"); return IF; }
else 	{ printf("ELSE"); return ELSE; }
int     { printf("INT"); return INT; }
main    { printf("MAIN"); return MAIN; }
{id}	{ printf("ID(%s)", yytext); return ID; }
{number}	{ printf("NUM(%s)", yytext); return NUM; }
"="		{ printf("ASSIGN"); return ASSIGN; }
"<"		{ printf("LT"); return LT; }
"<="	{ printf("LE"); return LE; }
"=="	{ printf("EQ"); return EQ; }
"<>"	{ printf("NE"); return NE; }
">"		{ printf("GT"); return GT; }
">="	{ printf("GE"); return GE; }
"+"     { printf("ADD"); return ADD; }
"-"     { printf("SUB"); return SUB; }
"*"     { printf("MUL"); return MUL; }
"/"     { printf("ADD"); return ADD; }
"<<"    { printf("SHL"); return SHL; }
">>"    { printf("SHR"); return SHR; }
{str}   { printf("DIV"); return DIV; }
{wrap}  { printf("\n"); }
{punctuation} { printf("PUNCT('%s')", yytext); return yytext[0];}


%%

int main(int argc, char **argv)
{
    int tok;
    FILE *fp;
    if (argc > 2) {
        printf("Error: Too many arguments.\n");
        printf("Usage: ./prog1 input_file\n");
        return EXIT_FAILURE;
    }
    if (argc == 2) {
        fp = fopen(argv[1],"r");
        if (!fp) {
            printf("Failed to open input file.\n");
            return EXIT_FAILURE;
        }
        yyin = fp;
    }

    while( (tok = yylex()) ){
        printf(" ");
    }
    if (argc == 2)
        fclose(fp);
    return 0;
}
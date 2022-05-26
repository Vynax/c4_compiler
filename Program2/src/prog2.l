%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    // int no_of_lines = 0;
    // int no_of_chars = 0;
    int yylval;
    // tokens and classes (operators last and in precedence order)
    enum {
        INCPTR = 128,
        DECPTR,
        INCDATA,
        DECDATA,
        PUTCHAR,
        GETCHAR,
        WHILE_START,
        WHILE_END
    };
%}

wrap        [\n]
delim	    [ \t]
ws		    {delim}+

%%
{wrap} {printf("\n");}
{ws} {}
">" {printf("INCPTR"); return INCPTR;}
"<" {printf("DECPTR"); return DECPTR;}
"+" {printf("INCDATA"); return INCDATA;}
"-" {printf("DECDATA"); return DECDATA;}
"." {printf("PUTCHAR"); return PUTCHAR;}
"," {printf("GETCHAR"); return GETCHAR;}
"[" {printf("WHILE_START"); return WHILE_START;}
"]" {printf("WHILE_END"); return WHILE_END;}
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
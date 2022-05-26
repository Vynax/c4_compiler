%{
        #include <cstdio>
        #include <cstdlib>
        #include "prog2.h"
        extern int yylex();
        void yyerror(const char *s) {printf("Error: %s\n", s);}
        Stmts *programStmts;
%}

%union {
        int token;
        Stmt *stmt;
        Stmts *stmts;
        Loop *while_loop;
}

%token <token> INCPTR DECPTR INCDATA DECDATA PUTCHAR GETCHAR WHILE_START WHILE_END
%type <while_loop> while_loop
%type <stmt> incptr decptr incdata decdata putchar getchar
%type <stmts> stmts

%start program

%%
program: stmts {programStmts = $1;}
       ;

stmts: stmt {$$ = new Stmts(); $$->push_back($1);}
     | stmts stmt {$$->push_back($2);}
     ;

stmt: decptr
    | incptr
    | decdata
    | incdata
    | putchar
    | getchar
    |while_loop
    ;

decptr: {$$ = new Decptr();}
      ;
incptr: {$$ = new incptr();}
      ;
decdata: {$$ = new Decdata();}
       ;
incdata: {$$ = new Incdata();}
       ;
putchar: {$$ = new Putchar();}
       ;
getchar: {$$ = new Getchar();}
       ;
while_loop: WHILE_START stmts WHILE_END {$$ = new Loop($2);}
%%
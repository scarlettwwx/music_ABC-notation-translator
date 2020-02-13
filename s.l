%option noyywrap

%{
  #include <stdlib.h>
  #include <stdio.h>
  #include "s1.tab.h"
  #include "y.tab.h"
  void yyerror(char *);
%}


%%

[drmfsltDRMFSLT0]  { yylval.note = strdup(yytext);
                    return ONENOTE; }

[1-9]             { yylval.intVal=atoi(yytext);
                    return INTEGER; }

[>!@/:()-]        { return *yytext; }


[;]               { return END;}

.                  ;

%%

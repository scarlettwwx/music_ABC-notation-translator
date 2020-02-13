%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *);
int count;
char* tags[10];
char simple[15] = {'d', 'r', 'm', 'f', 's', 'l', 't', 'D', 'R', 'M', 'F', 'S', 'L', 'T','0'};
char *abc[15] = {"G,", "A,", "B,", "C", "D", "E", "F", "G", "A", "B", "c", "d", "e", "f","z"};
%}

%union {
    int intVal;
    char* note;
};

%token <intVal> INTEGER
%token <note> ONENOTE END

%type <note> one_note  tune  noteHyphens melody chapter


%%



chapter:
      melody  END            { $$ = $1 ; printf ("END!");exit(0);}
;

melody:
      tune         { $$ = $1 ;}
      | melody tune  { sprintf($$, "%s%s",$1,$2);}
;


 tune:
    noteHyphens {
                  if (count>1){
                    printf("%d ",count);
                    sprintf($$, "%s%d ",$1,count);
                  } else{
                     $$=$1;
                  }}
    | '('  INTEGER  ':'  melody  ')'   { tags[$2]=$4; $$=$4 ; }

    | '@'  INTEGER           {   if (tags[$2] == NULL){
                                      printf("Define this tag first!");
                                  } else{
                                      $$=tags[$2];
                                      printf("%s ",tags[$2]);}}
    | '!' one_note one_note     { printf("%s/%s/",$2, $3); sprintf($$, "%s/%s/", $2, $3);
                                                                  }
    | '!' one_note '>' one_note { printf("%s3/4%s1/4",$2, $4); sprintf($$, "%s3/4%s1/4", $2, $4 );
                                                                  }
    | one_note { printf("%s>", $1); }'>' one_note     { printf("%s",$3); sprintf($$, "%s>%s", $1, $3 ); }

;



noteHyphens:
    one_note          { count=1; printf("%s",$1);$$=$1;}
    | noteHyphens '-' { $$=$1;
                        count++;  }

    ;


one_note:
    ONENOTE    {
                char c = $1[0];
                int i;
                for(i=0;i<15;i++){
                  if(c==simple[i]){
                    break;
                  }
                }
                char *m = abc[i];
                sprintf($$, "%s",m);
                }

     | '/' ONENOTE    {
                char c = $2[0];
                int i;
                for(i=0;i<15;i++){
                  if(c==simple[i]){
                  break;
                  }
                }
                char *m = abc[i];
                sprintf($$, "^%s",m);
              }

    | '\\' ONENOTE   {  printf("\\");
                         char c = $2[0];
                         printf("%c", $2[0]);
                         int i;
                         for(i=0;i<15;i++){
                          if(c==simple[i]){
                          break;
                          }
                         }
                         char *m = abc[i];
                         sprintf($$, "%s",m);
                      }

    ;

%%



void yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
}

int main(void) {
     for(int i=0;i<10; i++){
       tags[i] = (char*) malloc(sizeof(char)*500);  //assume each tag hold at most 500
     }
     printf("Enter your simple music notations, use tags from 1-9, and end it with a \\; \n");
     yyparse();
     return 0;
}

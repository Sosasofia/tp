%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

void yyerror(char *s);
char buffer[32];
int yylexerrs;

%}

digito                  [0-9]
letra                   [a-zA-Z]
identificador           {letra}({letra}|{digito})*
constante               ({digito})+

%%

"inicio"                return INICIO;
"fin"                   return FIN;
"leer"                  return LEER;
"escribir"              return ESCRIBIR;
"imprimir"              return IMPRIMIR;
"veces"                 return VECES;

{identificador}         {printf("ID: %s\n",yytext);yylval.id = strdup(yytext); return ID;} 
{constante}             {yylval.cte = atoi(yytext); return CONSTANTE;}
"("                     return '(';
")"                     return ')';
";"                     return  PUNTOYCOMA;
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
","                     return ',';
":="                    return ASIGNACION;
[ \t\n]+                 ;
.                       {sprintf(buffer,"Error Lexico: %s es un caracter invalido", yytext); yyerror(buffer);}

%%

int yywrap(void) {
    return 1;
}

/* Display error message */
void yyerror(char *s) {
    yylexerrs++;
    printf("ERROR linea #%d: %s", yylineno, s);
}

// gcc parser.tab.c lex.yy.c -o salida -L "C:\GnuWin32\bin" TablaSimbolos.c
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "TablaSimbolos.h" // Todas las funciones de la TS

/* Flex functions */

extern int yylex();
extern int yynerrs;
extern int yylexerrs;


extern void yyerror(char *s);


// Para que tome un unico archivo 

extern FILE* yyin;

%}

/* Se definen los tokens */
%error-verbose

%union {
    char* id;
    int cte;
}

%token INICIO FIN 
%token LEER ESCRIBIR 
%token PUNTOYCOMA 
%token IMPRIMIR VECES
%token <id> ID
%token <cte> CONSTANTE

/* Operator precedence */
%left '+' '-' ',' '*'
%right ASIGNACION

%type <cte> expresion primaria termino

%%

/* Grammar rules */

programa:
       INICIO listaSentencias FIN
; 

listaSentencias:
       sentencia
    |  listaSentencias sentencia
;

sentencia:
       ID ASIGNACION expresion PUNTOYCOMA               {EscribirATabla($1, $3);}         
    |  LEER '(' listaIdentificadores ')' PUNTOYCOMA     
    |  ESCRIBIR '(' listaExpresiones ')' PUNTOYCOMA
    |  IMPRIMIR expresion expresion VECES PUNTOYCOMA    {for(int i=0; i<$3; i++) printf("%d\n",$2);}
;

listaIdentificadores:
       ID                               {cargarValores($1);}                                                   
    |  listaIdentificadores ',' ID      {cargarValores($3);}
;

listaExpresiones:
       expresion                        {printf("%d\n", $1);}
    |  listaExpresiones ',' expresion   {printf("%d\n", $3);}
;

expresion:
       termino                          {$$ = $1;}
    |  expresion '+' termino            {printf("Suma: "); $$ = $<cte>1 + $<cte>3;}
    |  expresion '-' termino            {printf("Resta: "); $$ = $1 - $3;}                    
;

termino:
        primaria
    |   termino '*' primaria            {$$ = $1 * $3;}
;

primaria:
       ID                               {$$ = estaEnTS($1);}
    |  CONSTANTE                        {$$ = $1;}
    |  '(' expresion ')'                {$$ = $2;}
;

%%


/* Entry point */
int main(int argc, char** argv) {
    
    

    if (argc > 2){
        printf("Cantidad Argumentos Erroneos");
        return EXIT_FAILURE;
    }
    else if (argc == 2) {
        char filename[50];                  // Nombre del archivo
        sprintf(filename, "%s", argv[1]);   // El 2do argumento
        int largo = strlen(filename);       // Largo del nombre del archivo

        // Si no termina en .m dar error
        if (argv[1][largo-1] != 'm' || argv[1][largo-2] != '.'){
            printf("Extension incorrecta (debe ser .m)");
            return EXIT_FAILURE;
        }

        yyin = fopen(filename, "r");
    }
    else {
        yyin = stdin;
    }
        

    init_TS(); // Inicializa la tabla con todo en -1

    // Parser
    switch (yyparse()){
        case 0: 
            printf("\nProceso de compilacion termino exitosamente \n");
            break;
        case 1: 
            printf("\nErrores de compilacion \n");
            break;
        case 2: 
            printf("\nMemoria suficiente \n");
            break;
    }

    printf("\n\nErrores sintacticos: %i\tErrores lexicos: %i\n", yynerrs, yylexerrs);

    return 0;
}


int yynerrs;
int yylexerrs=0;

/*                              Tabla de Simbolos                                          */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "TablaSimbolos.h"


SIMBOLO TS[TAMAN_TS]; // La tabla de símbolos per se

void init_TS(){
    for(int i=0; i<TAMAN_TS; (TS[i].val = -1, i++)); // valores inadmitidos en Micro
}

// Retorna valor de un ID si está en la TS, de lo contrario termina el programa

int estaEnTS(char* s){
    int index = IndiceTabla(s);
    if (index <0){
        printf("Error: Sin valor para '%s'\n",s);
        exit(EXIT_FAILURE);
    }
    return TS[index].val;
}

// Retorna el índice si está, o -1 si no
int IndiceTabla(char* s){
    int i=0;
    for (i; i<TAMAN_TS; i++)
        if (!strcmp(TS[i].id, s)) return i;
    return -1;
}

// Retorna el número que representa si la cadena es numérica, o -1 caso contrario
   int numerico(char* s){
    for(int i=0; i<strlen(s); i++)
        if (!isdigit(s[i])) return -1;
    return atoi(s);
}


// Va asignando a cada entrada leida con Leer(IDs); el valor y después se escribe a la tabla
// Si se intenta asignar un no número, tira error
void cargarValores(char* p1){
    int valor;
    char temp[15];
    printf("Ingresa valor de %s: ", p1);
    fscanf(stdin, "%s", temp);

    if((valor = numerico(temp)) == -1){
        printf("Error:'%s' no es un numero\n", temp);
        exit(EXIT_FAILURE);
    }
    EscribirATabla(p1, valor);
}

// Si ya está en la tabla lo actualiza, si no, crea una entrada nueva
void EscribirATabla(char* s, int v){
    int ind = IndiceTabla(s);
    // No está en la TS
    if (ind == -1){
        int i=0;
        for (i; (i<TAMAN_TS && TS[i].val != -1); i++); // busca la primera entrada vacía

        if (i > TAMAN_TS-1){
            printf("No hay mas espacio en la TS.\n");
            return;
        }
        // Asigna ID y su valor
        TS[i].val = v;
        sprintf(TS[i].id, s);
    }
    // Sí está en la TS
    else
        TS[ind].val = v;
}

// Para la estructura Leer(IDs);



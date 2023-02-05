#ifndef TABLA_DE_SIMBOLOS
#define TABLA_DE_SIMBOLOS

#define TAMAN_TS 100

typedef struct {
    // Los ids no pueden tener mas de 32 
    char id[32]; 
    int val;
} SIMBOLO;

// Escribir y leer en Tabla de Simbolos 
void init_TS(void);
int estaEnTS(char* s);
int IndiceTabla(char* s);
void EscribirATabla(char* s, int v);
void cargarValores(char* p1); // para Leer(IDs);

#endif

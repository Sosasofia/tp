# Trabajo Practico Flex - Bison 

> Hacer un programa utilizando flex y bison que realice analisis léxico, sintáctico y semántico de micro. Deben personalizar los errores e implementar al menos 3 rutinas semánticas.

* Se agrega la Tabla de simbolos 

## Integrantes 

* Juan Cruz Rodriguez
* Brian Colman
* Sofia Sosa
* Roxana Steinman 

## Compilacion 

```
flex -l scanner.l
bison -dv parser.y
gcc -o main y.tab.c lex.yy.c TablaSimbolos.c -lfl

```

## Ejecucion 

```
./main < prueba.m

```

``` 
./main < prueba2.m
```

## LINKs 

[yt1](https://www.youtube.com/watch?v=AyB7gVNor9U&t=156s)
[yt2](https://www.youtube.com/watch?v=XgnADwERhO0)
[yt3](https://www.youtube.com/watch?v=G-2cuJMK1xg)

## Libros 

[flex & bison](https://www.oreilly.com/library/view/flex-bison/9780596805418/)
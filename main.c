#include <stdio.h>
#include <malloc.h>
#include "mytest.tab.h"
#include "mytest.l.h"
#include "mytest.y.h"
#include "mytest.def.h"

int main(int argc, char* argv[]){
    if (argc != 2) {
        printf ("usage: ./example <filename>\n");
        return 1;
    }
    FILE *file = fopen(argv[1], "rb");
    if (!file) {
        printf("error: cannot open file: %s\n", argv[1]);
        return 1;
    }
    fseek(file,0L,SEEK_END);
    size_t  flen;
    char *p;
    flen=ftell(file);
    p=(char *)malloc(flen+1);
    fseek(file,0L,SEEK_SET);
    fread(p,flen,1,file);
    fclose(file);
    mytest_scan_start(p,flen);
    p[flen] = 0;

    mytest_yyparse();
    free(p);
    return 0;
}
#ifndef MYTEST_Y_H
#define MYTEST_Y_H

typedef struct mytest_ast{
    double val;
    struct mytest_ast *ast;
} mytest_ast;

typedef struct{
    int line;
    mytest_ast *ast;
} stack_elem;

#define YYSTYPE stack_elem

mytest_ast * mytest_act(mytest_ast *a,mytest_ast *b,char op);



#endif

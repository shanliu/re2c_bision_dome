#ifndef MYTEST_Y_H
#define MYTEST_Y_H
//构建语法树结构..
typedef struct mytest_ast{
    double val;
    struct mytest_ast *ast;
} mytest_ast;

//语法分析时数据传递结构
typedef struct{
    int line;
    mytest_ast *ast;
} stack_elem;

#define YYSTYPE stack_elem

mytest_ast * mytest_act(mytest_ast *a,mytest_ast *b,char op);



#endif

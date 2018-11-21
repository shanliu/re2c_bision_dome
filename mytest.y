/* bison -d mytest.y */
%{
//自定义头部代码
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include "mytest.tab.h"
#include "mytest.def.h"
#include "mytest.l.h"
#include "mytest.y.h"
//以下内部使用函数结构定义,配合下面参数
int yylex (YYSTYPE *yylval);
void yyerror (char * msg);
%}

%pure-parser //是否可以重入,即可以重复调用解析
%name-prefix "mytest_yy"  //解析入口函数前缀,主要供外部调用
//%lex-param  { char *parser } //自定义词法分析入口函数参数
//%parse-param { char *parser }//自定义解析入口函数参数

//终结符
%token T_BEGIN
%token T_OPTAG_ADD
%token T_OPTAG_DEC
%token T_OPTAG_XDD
%token T_OPTAG_MOD
//定义终结符的句柄[YYSTYPE]
%token <ast> T_NUMBER
%token T_WHITESPACE
%token T_BR
%token T_EXIT
%token T_END
%token T_UNKNOWN
%token T_INPUT_ERROR

//定义非终结符的返回句柄[YYSTYPE]
%type <ast> exp line

//语法
//bnf范式:左边为非终结符: 终结符 非终结符 组成
//{}里为action ,对应的辅助动作,PHP通过此方式构建抽象语法树
%%
input:    /* empty */ //开始,如果构建抽象语法树,这里可以创建树根
     | input line
    ;
line:  exp T_BR      { $$ = $1;}
;
exp:      T_NUMBER           { $$ = $1;          } //$$ 为 exp $1 为第一个语法T_NUMBER 依次类推 所表示类型上面定义
   | exp exp T_OPTAG_ADD   { $$ = mytest_act($1,$2,'+');      }
    | exp exp T_OPTAG_DEC   { $$ = mytest_act($1,$2,'-');      }
    | exp exp T_OPTAG_XDD   {$$ = mytest_act($1,$2,'*');}
    | exp exp T_OPTAG_MOD   {$$ = mytest_act($1,$2,'/');}
    /* Unary minus    */
    | exp 'n'       { $$ = mytest_act($1,NULL,'n');}

;
%%

mytest_ast * mytest_act(mytest_ast *a,mytest_ast *b,char op){
    return a;
}

int yylex (YYSTYPE *yylval) {
        int token;
        while(1){
            lex_param lex;//词法分析时附带数据
            token = mytest_scan(&lex);
            if (token == T_UNKNOWN ||token == T_BEGIN ||token == T_END) {
                 continue;
            }
            if (token == T_INPUT_ERROR) {
                printf("%s\n", "input error");
                return 0;
            }
            //分析字符串,并返回token(终结符)
            //如 T_NUMBER 定义了ast句柄.在此定义 使用在上面语法中的 $1
            if(token == T_NUMBER){
                yylval->ast=(mytest_ast *) malloc(sizeof(mytest_ast));
                yylval->ast->ast=NULL;
                yylval->ast->val=100;
            }
            break;
        }
        return token;
}

void yyerror (char * msg) {
    fprintf (stderr, "%s\n", msg);
}
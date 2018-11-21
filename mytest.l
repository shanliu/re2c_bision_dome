/* re2c -t mytest.def.h -c -o mytest.lex.c mytest.l */

#include <stdio.h>
#include "mytest.def.h"
#include "mytest.l.h"
#include "mytest.tab.h"

mytest_lex_global scanner_globals;

#define YYCTYPE char
#define YYFILL(n)
#define STATE(name)  yyc##name
#define BEGIN(state) YYSETCONDITION(STATE(state))
#define MYTEST_SCNG(v) (scanner_globals.v)

#define YYGETCONDITION()  MYTEST_SCNG(yy_state)
#define YYSETCONDITION(s) MYTEST_SCNG(yy_state) = s
#define YYCURSOR  MYTEST_SCNG(yy_cursor)
#define YYLIMIT   MYTEST_SCNG(yy_limit)
#define YYMARKER  MYTEST_SCNG(yy_marker)

//以下T_*(token终结符)由语法分析器定义
int mytest_scan(lex_param * lex){
    //lex词法分析时附带数据可以放到  lex中,供后面语法分析使用
    /*!re2c
      //这里定义或下面直接定义,支持正则.
      numbers = [0-9]+ ;
      add = "+" ;

      <INITIAL>"<?" {
        //进入 ST_IN_SCRIPTING
        //前面<XXX>类似分组块
        BEGIN(ST_IN_SCRIPTING); return T_BEGIN;
      }
      <ST_IN_SCRIPTING>numbers {return T_NUMBER;}
      <ST_IN_SCRIPTING>add {return T_OPTAG_ADD;}
      <ST_IN_SCRIPTING>"-" {return T_OPTAG_DEC;}
      <ST_IN_SCRIPTING>"*" {return T_OPTAG_XDD;}
      <ST_IN_SCRIPTING>"\\" {return T_OPTAG_MOD;}
      <ST_IN_SCRIPTING>[ \t\r]+ {return T_WHITESPACE;}
      <ST_IN_SCRIPTING>[\n]+ {return T_BR;}
      <ST_IN_SCRIPTING>"exit" { return T_EXIT; }
      <ST_IN_SCRIPTING>"?>" {return T_END;}
      <ST_IN_SCRIPTING>[^] {return T_UNKNOWN;}
      <*>[^] {return T_INPUT_ERROR;}
     */
}



void mytest_scan_start(char * parser){
    BEGIN(INITIAL);//开始进入
    YYCURSOR = parser;
    YYLIMIT=parser;
}



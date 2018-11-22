#ifndef YY_MYTEST_LEX
# define YY_MYTEST_LEX

//扫描跟踪用结构
typedef struct{
    unsigned char *yy_cursor;
    unsigned char *yy_marker;
    unsigned char *yy_limit;
    int yy_state;
} mytest_lex_global;

//每次扫描相关数据存放
typedef struct {
    char * val;
}lex_param;

int mytest_scan(lex_param * lex);
void mytest_scan_start(char * parser,int len);



#endif
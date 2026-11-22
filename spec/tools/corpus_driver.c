#include <stdio.h>
#include "parser.h"

static int token;
static int errors;

int yylex(void)
{
    if (!token) return 0;
    int current = token;
    if (scanf("%d", &token) != 1) token = 0;
    return current;
}

void yyerror(const char *message)
{
    (void)message;
    errors++;
}

int yyparse(void);

int main(void)
{
    while (scanf("%d", &token) == 1) {
        errors = 0;
        int result = yyparse();
        puts(result == 0 && errors == 0 ? "pass" : "reject");
        while (token && scanf("%d", &token) == 1) {}
    }
    return 0;
}

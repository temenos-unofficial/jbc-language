# DEFCE

With TAFC the DEFCE statement should be used, rather than the
[DEFC](https://jbc-lang.org/pages/defc.md) statement, for calling external C programs, which are
pure 'C' code and do not use the TAFC library macro's and functions.

## EXAMPLE 1

For C functions that do not require TAFC functions use the DEFCE
statement, however the passing arguments can only be of type INT,
FLOAT and STRING.

<pre>
    DEFCE INT MYFUNC3(INT)
    INT32 MYFUNC3(INT32 Count)
    {
      INT32 Result;
	    ...
	    return Result;
    }</pre>

## EXAMPLE 2

    DEFCE INT cfunc( INT, FLOAT, VAR )
    Var1 = cfunc( A, 45, B )
    cfunc( 34, C, J )

You can call standard UNIX functions directly by declaring them with
the DEFC statement according to their parameter requirements. You can
only call them directly providing they return one of the type int or
float/double or that the return type may be ignored.

## EXAMPLE 3

    DEFCE INT getpid()
    CRT "Process id =" : getpid()

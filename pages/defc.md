# DEFC

Use the DEFC statement to declare an external C function to the jBC
compiler, define its arguments, and return types. The DEFC statement
assumes that the C functions will need to manipulate jBC variables
and hence will also require the thread data pointer. As such, all C
functions require recoding to include the data pointer as an argument
to the C function. The location of the data pointer argument depends
upon the function return type.

## COMMAND SYNTAX

    DEFC {FuncType} FuncName ({ArgType {, ArgType ...}})

## SYNTAX ELEMENTS

FuncType and ArgType are selected from one of INT, FLOAT or VAR.
FuncType specifies the type of result that the function will return.
Assumes INT if FuncType is omitted. The optional list of ArgTypes
specifies the argument types that the C function will expect. The
compiler must know this in advance, as it will automatically perform
type conversions on these arguments.

## EXAMPLE

<pre>
    #include &lt;jsystem.h&gt;
    #include &lt;assert.h&gt;
    //
    #ifdef DPSTRUCT_DEF
    #define JBASEDP		  DPSTRUCT &lowast;dp,
    #else
    #define JBASEDP
    #endif
    //
    VAR &lowast;MyString(VAR &lowast;Result, JBASEDP  VAR &lowast;VarPtr)
    {
        char &lowast;Ptr;
        assert(dp != NULL);
        Ptr = (char &lowast;) CONV_SFB(VarPtr);
        printf("MyString: %s - %d\n", Ptr, strlen(Ptr) );
        STORE_VBI(Result, strlen(Ptr) );
        return(Result);
    }
    //
    INT32 MyCalc(INT32 Value1, INT32 Value2)
    {
        INT32  Result;
        Result =  (Value1 / Value2);
        printf("MyCalc: %d\n", Result);
        return(Result);
    }</pre>

## NOTES

Compile a DEFC for each C function before making any reference to it
else the compiler will not recognize the function name.

The function is called in the same manner, as it would be in a C
program, which means it can be used as if it was an intrinsic function
it as a standalone function call causes the compiler to generate code
that ignores any returned values.

When passing jBC variables to a C function, you must utilize the
predefined macros to access the various data types it contains. C
functions are particularly useful for increasing the performance
of tight loops that perform specific functions. The jBC compiler
must cater for any eventuality within a loop (such as the controlling
variable changing from integer to floating point). A dedicated C
function can ignore such events, if they are guaranteed not to happen.

The jBC programmer may freely ignore the type of argument used when
invoking the C function, as the jBC compiler will automatically perform
type conversion.

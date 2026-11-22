# CALLdotNET

The CALLdotNET command allows BASIC to call any .NET assembly and is
useful when using third party applications.

## COMMAND SYNTAX

    CALLdotNET NameSpaceAndClassName, methodName, param SETTING ret \
               [ON ERROR errStatment]

In order to use CALLdotNET, you need:

- The .NET Framework
- The dotNETWrapper.dll installed somewhere to where your PATH points.

## NOTE

The dotNETWrapper is loaded dynamically at runtime; therefore, a
compiled basic application has no dependencies on the .NET Framework.
Loading the framework takes between 5 and 7 seconds. However, this only
occurs when calling the .NET method for the first time.

## SYNTAX ELEMENTS

NameSpaceAndClassName The "full" NameSpace (e.g., myNameSpace.myClass)

methodName The name of the .NET in this class (e.g., "myMethod")

Param Any parameter (eg DynArray)

## EXAMPLE

In C#:

<pre>
    using System;
    using System.Windows.Forms;
    namespace myNameSpace
    {
	    public class Class1
	    {
		    public string sayHello(string str)
		    {
			    return "Thank you, I received : " + str;
		    }
		    public Class1(){}
	    }
    }</pre>

In VB.NET:

<pre>
    Namespace myNameSpace
      Public Class Class1
          Public Function sayHello(ByVal str As String) As String
            Dim sAnswer As String
            sAnswer = InputBox(str)
            sayHello = sAnswer
          End Function
      End Class
    End Namespace</pre>

Note: Create the .NET project as a 'Class Library'.

If using the visual studio IDE, this option is on selected when
creating a new project:

(image: .Net Project Creation)

If using .NET SDK (instead of the IDE) to compile class libraries
into a 'DLL' file, the  'csc' (C# Compiler) or 'vbc' (Visual Basic
.NET compiler) command can be used from the command line:

<pre>
    csc /out:myNameSpace.dll /target:library sourcefile.cs</pre>

The name of the '.DLL' created must be the same as the 'namespace'
as used in the class library t locate the 'dotNetWrapper.dll' library:

After creating the library, place it in the same private directory as
the application. (i.e. the same directory as the jBC executable that
will call the class) This is a requirement of the .NET paradigm and
not TAFC. The directory should also be in the PATH environment variable.

(image: DLL Creation)

*To call these methods from Basic*:

    CALLdotNET 'myNameSpace.Class1', 'mymethod', p SETTING ret
    CRT ret

## ON ERROR

You can manage any errors, which occur during the call, at the BASIC
level by getting the SYSTEM(0) variable.

This variable can have the following values:

|Code| Description                          |
|----|--------------------------------------|
| 1  | Not a Windows platform               |
| 2  | Cannot load the dotNETWrapper        |
| 3  | Cannot get assembly                  |
| 4  | Cannot get Class                     |
| 5  | Cannot get Method                    |
| 6  | Cannot Create Instance               |
| 7  | Unhandled Error in the .NET library  |

## EXAMPLE

BASIC code using the ON ERROR would look like this:

    PROGRAM testCALLdotNET
        ns.className = ''
        methodName = ''
        param = ''
        CRT "Please enter NameSpace.ClassName : "
        INPUT ns.className
        CRT "Please enter a Method Name : "
        INPUT methodName
        CRT "Please enter a Parameter : "
        INPUT param
        CALLdotNET ns.className, methodName, param SETTING ret \
            ON ERROR GOSUB errHandler
        CRT "Received back from .NET : " : ret
        STOP
    *
    errHandler:
        err = SYSTEM(0)
        BEGIN CASE
        CASE err = 2
           CRT "Cannot find dotNETWrapper.dll"
        CASE err = 3
           CRT "Class " : className : "doesn't exist !"
        CASE err = 5
           CRT "Method " : methodName : "doesn't exist !"
        END CASE
        RETURN

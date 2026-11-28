# Preface

jBC is a programming language that is used in jBASE post-relational
(multi-value) DBMS. Syntax is Basic-like; compilation process firstly
converts the source code to C which in turn is compiled for the target platform
with the usage of standard C compiler.

For TAFJ it is converted to Java code rather than to C.

This is an unofficial document. Use it at your own risk, and read its license agreement carefully.

## Get started

- **Read the guide**: pick a statement or function from the contents, or search for one. Code blocks with a Run button open in the playground.
- **Run jBC in your browser** with the [jBC Playground](https://online.jbc-lang.org/).
- **Edit jBC in VS Code** with the [jBC extension](https://marketplace.visualstudio.com/items?itemName=alexander-demin.jbc-vscode). It highlights jBC programs (.b) and T24 test cases (.tut). [Source code](https://github.com/jbc-lang/jbc-vscode).
- **Compile jBC natively** with [jbcc](https://pypi.org/project/jbcc/), an MIT-licensed jBC-to-C compiler tested against the T24 R07, R10, R13 and R19 source corpora.
- **Contribute** through the [jbc-language](https://github.com/jbc-lang/jbc-language) repository, which holds the guide's source, grammar and function catalogue.

With uv and a C99 compiler, jbcc builds and runs a program in one command:

    printf '%s\n' 'CRT "Hello, jBC!"' > hello.b
    uvx jbcc --run hello.b

The program in hello.b is one line of jBC, which you can also run in the playground:

    CRT "Hello, jBC!"

The guide's [change history](https://jbc-lang.org/pages/change_history.md) lists what was added and when.

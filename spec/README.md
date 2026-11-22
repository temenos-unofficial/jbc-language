# jBC grammar and function reference

These grammars describe the token streams accepted by the supplied TAFC-era
implementation. Use them as a baseline for a translator. The Programmers
Reference Guide supplies source examples, runtime behavior, and TAFJ
compatibility notes. Agreement with this parser alone does not establish
compatibility with another jBC release.

| File | How to use it |
|---|---|
| [jbc.y](jbc.y) | Start at `program`. Follow `statement` for commands, `resultant` for expressions, and `ident_assignments` for writable references. |
| [preprocessor.y](preprocessor.y) | Parse the directive language, including EQUATE, macros, includes and conditional compilation. Ordinary program text passes through this stage. |
| [keywords.tsv](keywords.tsv) | Map each of the 453 distinct spellings in the jBC lexer's reserved-word table to its class and token or dispatch ID. |
| [functions.md](functions.md) | Look up expression calls, aliases, and guide chapters. |
| [header-functions.md](header-functions.md) | Compare all 53 direct DEFC prototypes in JBC.h with guide signatures or examples. Sixteen have guide chapters. |

## From source text to grammar tokens

The original front end runs jpp before the main lexer. Its two grammars each
have their own token namespace. Several decisions depend on source position
or a previous declaration.

| Source construct | How the reference implementation reads it |
|---|---|
| Logical lines | jpp handles trailing backslash, three dots, and continuation after a comma. It can join clauses across physical lines. The main parser expects a leading synthetic EOL. Newlines and semicolons then separate statements. |
| Comments and strings | jpp recognizes `*`, `!` and `REM` comments at the start of a line or after a semicolon. The main lexer also consumes `//` through end of line. A single quote, double quote, or backslash opens a string terminated by the same character on that line. Delimiters inside a different kind of string are literal. |
| Names | The main lexer's identifier pattern is an ASCII letter followed by zero or more ASCII letters, digits, dollar signs, dots, percent signs, underscores or backticks. It pushes back a trailing underscore. Keyword lookup uses exact spelling, including `CALLdotNET`. |
| Literals and labels | Digits and decimal forms such as `.5` and `1.` produce Constant. A sign is an operator. At the start of a line, optional blanks followed by digits/dots can introduce a label. A named label takes a colon. The lexer distinguishes that colon from `:=`. Branch context can also request a Label. |
| Comparisons and extraction | jpp distinguishes relational angle brackets from dynamic-array delimiters. For example, a comparison can reach the parser as LT, whereas the brackets around the indices in `REC<2,1>` reach it as SDYN and EDYN. LOCATE has its own opening token. The preprocessor also normalizes spellings such as `<=`, `=<` and `<>`. |
| Assignment and indexing | The scanner uses parser state to emit literal `'='` for assignment and EQ for comparison. In matrix assignment the opening parenthesis can be LP. Bracket substring selection and angle-bracket field selection each have productions for reading and updating. |
| Keywords and calls | For FUNC_RETKW use column three of keywords.tsv as the parser token. For the other classes use column two and carry column three as the operation ID. After keyword lookup, a previously declared function can produce CFUNC or BFUNC. Otherwise an ordinary name produces Identifier. |
| Program and subroutine names | Some original actions consume source characters directly. For example the PROGRAM production contains only the PROGRAM token because its action calls `get_callname()`. A source parser must explicitly account for the program name. |

The guide marks backslash continuation and double-slash comments as
incompatible with TAFJ. Its examples also illustrate why statement position
matters for `!` (comment or logical OR) and `*` (comment or multiplication).
[Line continuation](https://jbc-lang.org/pages/to_wrap_a_long_line.html),
[comments](https://jbc-lang.org/pages/comments.html),
[strings](https://jbc-lang.org/pages/string_variables.html).

## Reading the productions

The files use Bison/Yacc syntax. Quoted characters are literal tokens.
`/* empty */` consumes no input. Each `{}` marks the original position of a
mid-rule action. Keeping these positions preserves the parser's reduction
order. A translator needs to restore relevant state transitions at those
points, or implement equivalent decisions in its scanner. The special
`error` symbol is for recovery. A recovered syntax error still counts as
a rejected input when checking conformance.

Precedence declarations run from lowest to highest. In jBC, AND and OR
share a left-associative level. With no parentheses, `A OR B AND C` groups
as `(A OR B) AND C`. The preprocessor has separate precedence levels for its
own OR and AND. The jBC grammar also retains the explicit precedence override
for a formatted expression (`resultant format_options %prec Identifier`).

For example, after the synthetic EOL, the assignment
`N = ABS(REC<2,1>)` has the following main-parser tokens. The payload of
FUNC_PARM1 identifies ABS.

```text
Identifier '=' FUNC_PARM1 '(' Identifier SDYN Constant ',' Constant EDYN ')' EOL
```

The syntax grammar omits semantic actions. Some original actions check
argument counts, types and declaration state. For example, the FUNC_PARM3
production accepts an argument list and the action requires exactly three
arguments. COMPARE accepts two or three. A CFUNC call checks its declaration.
The guide reserves BITTEST for future use and gives JBASESubroutineExist as
a CALLC example. These two entries have guide evidence without dedicated
expression tokens. [BITTEST](https://jbc-lang.org/pages/bittest.html),
[JBASESubroutineExist](https://jbc-lang.org/pages/jbasesubroutineexist.html).

## Provenance and verification

The production alternatives, their order, the precedence declarations and
mid-rule positions come from the supplied parser files. Compiler actions,
C declarations and code generation are omitted. The lexer table collapses
duplicate spellings using the last installed entry. The source fingerprints
identify the snapshot independently of its directory name.

| Source | SHA-256 |
|---|---|
| jbc_parser.y | 2509a8ca692e4728353314e84e435204b8276bf4a8579f2ff794ae06ba6fbf6b |
| jpp_parser.y | 2dde9cb1308f6ed07083c2925bf96458da63b2a25ec99df170ad2acdc7f5edbf |
| jbc_lexer.l | fbb9944a392de7e58f6e4c9f764384fc2746c1085e5173dbfc5fe261280fde47 |
| jpp_lexer.l | 1310785a46cf72be454efc7e6f954e91d7c3e44c5b7e2b8e33c026b692dce430 |
| JBC.h | 0ccc463f01105c0219e1e8b0a31ae15797dcd405ad7473ba803ee9eaec1f2897 |

To compare the complete parse automata with the local implementation, run
from the repository root with GNU Bison 2.3. Both comparisons should be
silent. Bison reports the inherited 273 shift/reduce conflicts in jBC and
18 in jpp. Rule order, precedence and Bison's shift decision on unresolved
conflicts are part of this baseline.

```sh
work=$(mktemp -d)
bison -v -o "$work/original.c" ~/Downloads/jbc/jbc_parser.y
bison -v -o "$work/jbc.c" spec/jbc.y
cmp "$work/original.output" "$work/jbc.output"
bison -v -o "$work/original-pp.c" ~/Downloads/jbc/jpp_parser.y
bison -v -o "$work/pp.c" spec/preprocessor.y
cmp "$work/original-pp.output" "$work/pp.output"
```

These checks cover parser tables. Source lexing, preprocessing effects,
semantic diagnostics, and execution require separate conformance cases.

## Checking a local source corpus

From the repository root, run the [corpus checker](tools/check_corpus.py) with
Python 3.8+, GNU Bison and a C99 compiler. The command reads the corpus and
writes a JSON report to standard output. Generated parsers and executables
live in a temporary directory.

```sh
python3 spec/tools/check_corpus.py ~/Downloads/t24 > /tmp/jbc-corpus.json
```

The checker visits regular files recursively, including extensionless files.
It inventories routine declarations, identifies probable insert fragments by
their `I_` names, and records NUL-containing files and read errors. For
simple include directives it compares the literal operand with basenames in
the corpus. Actual include resolution depends on the compiler's search path.

For the main grammar it checks individual physical lines from a bounded
subset: scalar assignments, direct branches, PRINT, CRT, RETURN, STOP and
NULL. It maps keywords through the checked-in lexer table and replaces names
and literals with their token classes. It parses each distinct sequence once
and weights the result by occurrences. For the preprocessor it checks simple
single-name includes and single numeric equates. A syntax error counts as a
rejection even if Bison recovers.

The report counts skipped lines separately. It gives a relative filename and
line number for an example of each rejected main-parser sequence. Inspect the
surrounding lines before proposing a grammar change: a statement can belong
to a larger construct such as LOOP ... REPEAT. Full routines require a
context-sensitive scanner, include expansion and declaration tracking. This
check measures coverage of isolated token sequences.

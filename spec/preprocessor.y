/* Token grammar derived from jpp_parser.y. See README.md for the lexer contract. */
%token DEFINE
%token DEFINED
%token DEFAULT
%token EQUATE
%token EOL
%token TO
%token INCLUDE
%token FROM
%token IF
%token IFDEF
%token IFNDEF
%token ELSE
%token ENDIF
%token LIT
%token MACRO
%token MACROWORD
%token ENDM
%token WORD
%token PARAM
%token AND
%token OR
%token JPPECHO
%token JPPFILENAME
%token '{'
%token '}'
%token ','
%token '='
%left OR
%left AND
%left '#' '='
%left '<' '>'
%start program
%%
program
    : program_body
    ;

program_body
    : program_body statements
    | statements
    | program_body statements error
    | statements error
    ;

statements
    : WORD
    | MACROWORD {} '(' {} macro_expand_parameters ')'
    | MACRO {} macro_name {} '{' macro_define_parameters '}' {} macro_body ENDM
    | PARAM
    | DEFAULT PARAM {} expand_words EOL
    | equate_definition
    | if_cond
    | ifdef_cond
    | ifndef_cond
    | include_options
    | jppfilename
    | JPPECHO
    | error
    | DEFINE WORD {} word_list EOL
    ;

macro_name
    : macro_name WORD
    | WORD
    ;

macro_body
    : program_body
    ;

macro_define_parameters
    : macro_define_parameters ',' PARAM
    | PARAM
    ;

macro_expand_parameters
    : macro_expand_parameters ',' {} expand_param
    | expand_param
    ;

expand_param
    : expand_words
    | /* empty */
    ;

expand_words
    : expand_words WORD
    | WORD
    ;

equate_definition
    : EQUATE {} equate_list equate_end
    ;

equate_end
    : EOL
    | ';'
    ;

equate_list
    : equate_list ',' WORD {} to_or_lit {} word_list
    | WORD {} to_or_lit {} word_list
    ;

word_list
    : word_list WORD
    | WORD
    ;

if_cond
    : IF {} expression {} program_body opt_else ENDIF
    ;

ifdef_cond
    : IFDEF def_target {} cond_body opt_else ENDIF
    ;

opt_else
    : ELSE {} cond_body
    | /* empty */
    ;

ifndef_cond
    : IFNDEF def_target {} cond_body opt_else ENDIF
    ;

cond_body
    : program_body
    | /* empty */
    ;

def_target
    : WORD
    | PARAM
    ;

jppfilename
    : JPPFILENAME {} WORD WORD EOL
    ;

include_options
    : INCLUDE {} include_words EOL
    ;

include_words
    : include_words WORD
    | WORD
    ;

expression
    : expression AND expression
    | expression '&' expression
    | expression OR expression
    | expression '|' expression
    | '!' expression
    | '(' expression ')'
    | comp_word '=' comp_word
    | comp_word '#' comp_word
    | comp_word '>' comp_word
    | comp_word '<' comp_word
    ;

comp_word
    : WORD
    | PARAM
    ;

to_or_lit
    : TO
    | LIT
    ;
%%

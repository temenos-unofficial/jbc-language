/* Token grammar derived from jbc_parser.y. See README.md for the lexer contract. */
%token Identifier
%token Constant
%token Label
%token ENVFUNC
%token FUNC_ARGS1
%token FUNC_ARGS2
%token FUNC_PARM0
%token FUNC_PARM1
%token FUNC_PARM2
%token FUNC_PARM3
%token FUNC_RETKW
%token ABORT
%token APPEND
%token APPENDING
%token JAC_ARG
%token ASSIGNED
%token AT
%token ALL
%token ACOS
%token ASIN
%token ATAN
%token ATKEY
%token ATVAR
%token JAC_BEGIN
%token BEFORE
%token BITAND
%token BITCHANGE
%token BITCHECK
%token BITLOAD
%token BITNOT
%token BITOR
%token BITRESET
%token BITSET
%token BITXOR
%token BLOB
%token BREAK
%token CALL
%token CALLC
%token CALLJ
%token CALLdotNET
%token CALLONEXIT
%token CASE
%token CHAIN
%token CHANGE
%token CHANGETIMESTAMP
%token CLEAR
%token CLEARCOMMON
%token CLEARDATA
%token CLEARFILE
%token CLEARSELECT
%token CLEARINPUT
%token CLOSE
%token CLOSESEQ
%token COLLECTDATA
%token COMMON
%token COMPARE
%token CONTINUE
%token CONTROLCHAR
%token CONVERT
%token CREATE
%token CRT
%token DECRYPT
%token DATA
%token DEFFUN
%token DEL
%token DELENV
%token DELETE
%token DELETEU
%token DELETELIST
%token DELETESEQ
%token DROUND
%token JAC_DEBUG
%token DIM
%token JAC_ECHO
%token JAC_HUSH
%token ELSE
%token JAC_END
%token ENCRYPT
%token ENTER
%token ERROR
%token EREPLACE
%token EXISTING
%token FILEINFO
%token FILELOCK
%token FILEUNLOCK
%token FIND
%token FINDSTR
%token FLUSH
%token FOOTING
%token FOR
%token GET
%token GES
%token GTS
%token GETX
%token GETCWD
%token GETENV
%token GETLIST
%token GETUSERNAME
%token GETUSERGROUP
%token GO
%token GOSUB
%token GOTO
%token HEADING
%token HEADINGE
%token HEADINGN
%token IF
%token IFS
%token INPUT
%token INPUTCLEAR
%token INPUTERR
%token INPUTNULL
%token INPUTTRAP
%token IOCTL
%token ISALNUM
%token ISALPHA
%token ISCNTRL
%token ISDIGIT
%token ISGRAPH
%token ISLOWER
%token ISPRINT
%token ISPUNCT
%token ISSPACE
%token ISUPPER
%token ISXDIGIT
%token LATIN1
%token LES
%token LTS
%token LOCALDATE
%token LOCALTIME
%token LOCK
%token LOCKED
%token LOOP
%token JAC_LPTR
%token JQLCOMPILE
%token JQLGETPROPERTY
%token JQLPUTPROPERTY
%token JQLEXECUTE
%token JQLFETCH
%token MTU
%token MAKETIMESTAMP
%token JAC_MAT
%token MATBUILD
%token MATPARSE
%token MATREAD
%token MATREADU
%token MATREADL
%token MATWRITE
%token MATWRITEU
%token JAC_MSG
%token NEXT
%token NOBUF
%token JAC_NULL
%token OBJEXCBACK
%token ON
%token OFF
%token ORS
%token OPEN
%token OPENDEV
%token OPENPATH
%token OPENSEQ
%token OPENSER
%token OSOPEN
%token OSCLOSE
%token OSDELETE
%token OSREAD
%token OSWRITE
%token OSBREAD
%token OSBWRITE
%token OUT
%token RECORDLOCKED
%token PAGE
%token PERROR
%token PRECISION
%token PRINT
%token PRINTERR
%token PROGRAM
%token PROMPT
%token PUTENV
%token RANDOMIZE
%token READ
%token READONLY
%token READPREV
%token READSEQ
%token READBLK
%token READT
%token READTX
%token READU
%token READL
%token READV
%token READVU
%token READVL
%token READX
%token READXML
%token READXMLU
%token READXU
%token READXL
%token READLIST
%token READSELECT
%token READNEXT
%token RECORDLOCKU
%token RECORDLOCKL
%token REGEXP
%token RELEASE
%token REM
%token REMOVE
%token RESET
%token RETURN
%token REWIND
%token PRINTER
%token SEEK
%token SELECT
%token SELECTE
%token SELECTINDEX
%token SEND
%token SENDX
%token SENTENCE
%token SLEEP
%token SMALLINT
%token SORT
%token SSELECT
%token SSELECTN
%token SSELECTV
%token START
%token STATIC
%token STEP
%token STOP
%token SUBROUTINE
%token SYNC
%token TA
%token TRANSABORT
%token TRANSTART
%token TRANSSYNC
%token TRANSEND
%token TTYCTL
%token TTYGET
%token TTYSET
%token TIMEOUT
%token UNASSIGNED
%token UNFILTERED
%token UNLOCK
%token UNIT
%token UNIQUEKEY
%token UNTIL
%token USING
%token VARCHAR
%token JAC_WEOF
%token WAITING
%token WAKE
%token WEOFSEQ
%token WHILE
%token WRITE
%token WRITELIST
%token WRITEP
%token WRITEPU
%token WRITEBLK
%token WRITESEQ
%token WRITESEQF
%token WRITET
%token WRITETX
%token WRITEU
%token WRITEV
%token WRITEVU
%token WRITEX
%token WRITEXML
%token WRITEXMLU
%token WRITEXU
%token PROCREAD
%token PROCWRITE
%token EXECUTE
%token PERFORM
%token MDPERFORM
%token PCPERFORM
%token UDTEXECUTE
%token UTF8
%token DYNTOXML
%token XMLTODYN
%token XMLTOXML
%token XMLADDTEXT
%token XMLADDNODE
%token XMLVALIDATE
%token XMLGETTAGVALUE
%token VALIDATE_PRODUCT_LICENSE
%token VALIDATE_METRICS_LICENSE
%token CONSUME_METRICS_LICENSE
%token EOL
%token EQ
%token EQS
%token NE
%token NES
%token LT
%token GT
%token LE
%token GE
%token SDYN
%token EDYN
%token LOC_SDYN
%token CAPTURING
%token PASSDATA
%token PASSLIST
%token RTNLIST
%token RTNDATA
%token BY
%token AND
%token OR
%token POSCUR
%token ABS
%token ABSS
%token ADDS
%token ANDS
%token ALPHA
%token ASCII
%token CHAR
%token CHARS
%token CATS
%token CHDIR
%token CHECKSUM
%token COL1
%token COL2
%token COS
%token CRC
%token COUNT
%token COUNTS
%token DATE
%token DCOUNT
%token DIV
%token DIVS
%token DO
%token DOWNCASE
%token DTX
%token EBCDIC
%token ERRTEXT
%token EXIT
%token EXP
%token EXTRACT
%token FIELD
%token FIELDS
%token JAC_FLOAT
%token FADD
%token FCMP
%token FDIV
%token FFIX
%token FFLT
%token FMUL
%token FMT
%token FMTS
%token FORMLIST
%token FOLD
%token FROM
%token FSUB
%token FUNCTION
%token GROUP
%token GROUPSTORE
%token ICONV
%token ICONVS
%token IN
%token INDEX
%token INDICES
%token INMAT
%token INS
%token INSERT
%token JAC_INT
%token JBASECOREDUMP
%token ITYPE
%token KEY
%token KEYIN
%token LEN
%token LENDP
%token BYTELEN
%token JAC_LENGTH
%token LENS
%token LENSDP
%token LEFT
%token LN
%token LOCATE
%token LOWCASE
%token LOWER
%token MATCHFIELD
%token MATCHES
%token MATVAR
%token MOD
%token MODS
%token MSLEEP
%token MULS
%token NEG
%token NEGS
%token NOT
%token NOTS
%token NUM
%token NUMS
%token OCONV
%token OCONVS
%token OPENINDEX
%token PAUSE
%token PWR
%token RAISE
%token REPEAT
%token REPLACE
%token REUSE
%token RIGHT
%token RND
%token SADD
%token SCMP
%token SDIV
%token SELECTINFO
%token SEQ
%token SEQS
%token SETTING
%token SIN
%token SMUL
%token SPACE
%token SPACES
%token SPLICE
%token SPOOLER
%token SQRT
%token SSUB
%token STATUS
%token STR
%token STRS
%token SUBR
%token SUBS
%token SUBSTRINGS
%token SWAP
%token SYSTEM
%token TAN
%token TIME
%token TIMEDATE
%token TIMESTAMP
%token TIMEDIFF
%token THEN
%token TO
%token TRANS
%token TRANSQUERY
%token TRIM
%token TRIMS
%token TRIMB
%token TRIMBS
%token TRIMFS
%token TRIMF
%token UPCASE
%token JAC_VAR
%token WITH
%token XTD
%token DEFB
%token DEFC
%token DEFCE
%token DEFCPP
%token BFUNC
%token CFUNC
%token CTYPE
%token LP
%token ';'
%token ':'
%token '('
%token ')'
%token '['
%token ']'
%token ','
%token PP
%token MM
%token PE
%token ME
%token TE
%token DE
%token CE
%token '+'
%token '-'
%token '*'
%token '/'
%token '^'
%token DECLARE
%token EXEC
%token SECTION
%token SQL
%token JAC_STRING
%token TABLE
%token JAC_DIR
%token SUM
%token SUMMATION
%token SOUNDEX
%token DQUOTE
%token SQUOTE
%token MAXIMUM
%token MINIMUM
%token ConstantFloat
%right PE ME TE DE CE
%left OR AND
%left EQ NE
%left GE LE GT LT
%left MATCHES
%left ':'
%nonassoc Constant Identifier
%left '+' '-'
%left '*' '/'
%left '^' THEN ELSE
%right PP MM
%start program
%%
program
    : section
    ;

section
    : statements opt_end_prog
    ;

opt_end_prog
    : /* empty */
    | JAC_END eols
    | opt_end_prog JAC_END {} eols redundant_statements
    ;

redundant_statements
    : statements
    ;

eols
    : EOL
    | eols EOL
    ;

statements
    : statements statement_separator statement
    | statements statement_separator
    | statements error EOL
    | /* empty */
    ;

statement
    : '@' Identifier {} '=' {} resultant
    | PROGRAM
    | program_label
    | Identifier {} matrix_assign_list ident_assignments
    | PP ident_options
    | MM ident_options
    | mat_statement JAC_MAT Identifier
    | mat_statement resultant
    | case_structure
    | CONTINUE
    | DEFB Identifier '(' {} ')'
    | func_declarator opt_static_decl c_func_type func_ident '(' {} opt_c_var_list ')'
    | DECLARE FUNCTION funcname
    | DECLARE SUBROUTINE
    | basic_declarator func_ident {} '(' {} opt_b_var_list ')'
    | DEL {} ident_options LOC_SDYN {} nocollect_argument_list end_dyn
    | CFUNC '(' {} opt_nocollect_argument_list ')'
    | FILELOCK opt_select_fdsc opt_param opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | FILEUNLOCK opt_select_fdsc {} opt_cond_body
    | FIND {} resultant IN resultant opt_param SETTING ident_options opt_identifier opt_identifier {} cond_body_p1 cond_body_p2
    | FINDSTR {} resultant IN resultant opt_param SETTING ident_options opt_identifier opt_identifier {} cond_body_p1 cond_body_p2
    | FOOTING opt_on resultant
    | FOR Identifier {} for_mat_assign_list '=' {} resultant TO resultant optional_step {} statements_and_opt_while_until_body NEXT opt_next_var
    | GROUPSTORE resultant IN ident_options USING resultant ',' resultant opt_param
    | heading_type opt_on resultant
    | IF resultant {} cond_body_p1 cond_body_p2
    | INS resultant BEFORE ident_options SDYN {} nocollect_argument_list end_dyn
    | loc_stat {} resultant IN {} resultant opt_loc_dyns {} opt_param opt_by_seq SETTING ident_options {} cond_body_p1 cond_body_p2
    | loc_stat LP {} nocollect_argument_list ';' ident_options opt_seq rp {} cond_body_p1 cond_body_p2
    | LOOP {} opt_single_line_statements statements_and_opt_while_until_body REPEAT
    | CLOSE ident_options {} opt_cond_body
    | CLOSE ident_options ',' {} close_identifier_list
    | OBJEXCBACK ident_options ',' ident_options {} cond_body_p1 cond_body_p2
    | OPEN {} collect_argument_list {} opt_open_fdsc opt_io_setting {} opt_sw_onerror_clause sw_cond_body_p1 sw_cond_body_p2
    | OPENINDEX resultant ',' resultant TO ident_options opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | OPENSEQ opt_existing opt_append {} collect_argument_list {} opt_readonly TO ident_options opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | OPENSER {} collect_argument_list {} TO ident_options opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | PAUSE optional_pause
    | CREATE resultant opt_io_setting {} cond_body_p1 cond_body_p2
    | RANDOMIZE
    | RANDOMIZE '(' rp
    | RANDOMIZE '(' resultant rp
    | READSEQ ident_options_or_attype FROM resultant opt_io_setting {} opt_sw_onerror_clause sw_cond_body_p1 sw_cond_body_p2
    | OSREAD ident_options_or_attype FROM resultant opt_io_setting {} opt_sw_onerror_clause sw_cond_body_p1 sw_cond_body_p2
    | OSBREAD ident_options_or_attype FROM resultant {} AT resultant JAC_LENGTH resultant opt_io_setting {} opt_cond_body
    | OSBWRITE resultant on_or_to resultant AT resultant opt_io_setting {} opt_cond_body
    | READBLK ident_options_or_attype FROM resultant ',' resultant opt_io_setting {} cond_body_p1 cond_body_p2
    | WRITEBLK resultant on_or_to resultant opt_io_setting {} cond_body_p1 cond_body_p2
    | writeseq_type resultant opt_append on_or_to ident_options opt_io_setting {} opt_sw_onerror_clause sw_cond_body_p1 sw_cond_body_p2
    | OSWRITE resultant opt_append on_or_to resultant opt_io_setting {} opt_sw_onerror_clause
    | WAKE resultant
    | WEOFSEQ ident_options opt_io_setting {} opt_sw_onerror_clause opt_null_sw_cond_body
    | CLOSESEQ ident_options {} opt_cond_body
    | DELETESEQ {} collect_argument_list {} opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | OSDELETE resultant opt_io_setting {} opt_sw_onerror_clause
    | READLIST ident_options optional_from opt_matbp_setting {} cond_body_p1 cond_body_p2
    | STATUS ident_options FROM resultant opt_io_setting {} cond_body_p1 cond_body_p2
    | FORMLIST resultant opt_select_to opt_setting
    | GETLIST resultant opt_select_to opt_matbp_setting {} cond_body_p1 cond_body_p2
    | opt_read_next_or_prev opt_key ident_options_or_attype opt_identifier opt_identifier optional_from opt_io_setting {} opt_sw_onerror_clause sw_cond_body_p1 sw_cond_body_p2
    | opt_readt opt_mtu ident_options opt_tape_channel {} cond_body_p1 cond_body_p2
    | REMOVE ident_options_or_attype FROM ident_options_or_attype opt_remove_at SETTING ident_options
    | REWIND opt_mtu opt_tape_channel {} cond_body_p1 cond_body_p2
    | SELECT opt_select_fdsc opt_select_to opt_setting {} opt_cond_body
    | SELECT opt_select_fdsc opt_select_to opt_setting ATKEY {} nocollect_argument_list {} opt_cond_body
    | sselect_or_sselectn_or_sselectv opt_select_fdsc opt_select_to opt_setting {} opt_cond_body
    | SELECTE opt_select_to opt_setting
    | SELECTINDEX resultant opt_param FROM ident_options opt_select_to opt_setting
    | opt_sleep optional_sleep
    | FUNC_ARGS1 resultant
    | ABORT {} opt_stop_argument_list
    | ASSIGNED resultant TO SYSTEM '(' resultant rp
    | BREAK
    | BREAK ON
    | BREAK OFF
    | BREAK resultant
    | BFUNC {} opt_func_mat_arg_list
    | CALLC opt_at CFUNC_or_Identifier {} opt_func_mat_arg_list
    | CALLJ resultant ',' resultant ',' resultant {} SETTING Identifier {} opt_sw_onerror_clause
    | CALLdotNET resultant ',' resultant ',' resultant {} SETTING Identifier {} opt_sw_onerror_clause
    | CALL {} opt_mat_arg_list
    | CHAIN resultant
    | change_or_swap resultant to_or_with resultant IN ident_options opt_dyns
    | CLEAR
    | CLEARCOMMON {} opt_namedcommon_name
    | CLEARDATA
    | CLEARFILE opt_clearf_fdsc opt_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | CLEARSELECT ALL
    | CLEARSELECT opt_sel_list1
    | COMMON {} opt_common_name common_identifier_list
    | CONVERT resultant TO resultant IN ident_options opt_dyns
    | CRT {} optional_prints
    | DATA {} collect_argument_list
    | JAC_DEBUG
    | DELETELIST resultant
    | delete_statement {} nocollect_argument_list opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | DIM {} dimvar_list
    | ENTER
    | sql_prefix sql_stats
    | exec_perf resultant {} optional_exec_options
    | EXIT
    | EXIT '(' resultant ')'
    | GET '(' JAC_ARG opt_param ')' ident_options {} opt_null_cond_body
    | GET '(' JAC_MSG opt_param ')' ident_options {} cond_body_p1 cond_body_p2
    | get_getx ident_options opt_get_length opt_setting FROM resultant opt_until opt_returning opt_waiting {} cond_body_p1 cond_body_p2
    | send_sendx {} resultant TO {} resultant {} cond_body_p1 cond_body_p2
    | GOSUB {} Label_opt_colon
    | GOTO {} Label_opt_colon
    | IN ident_options_or_attype {} optional_time
    | INPUT optional_curpos ident_options_or_attype {} optional_input_limit optional_input_colon optional_input_with optional_input_mask {} optional_time
    | TA CLEAR
    | INPUTCLEAR
    | echo_or_hush ON
    | echo_or_hush OFF
    | echo_or_hush resultant
    | JAC_NULL
    | LOCK resultant {} opt_null_cond_body
    | MATBUILD ident_options FROM {} ident_options {} opt_matbp_start_end opt_matbp_delimiter
    | MATPARSE {} ident_options {} opt_matbp_start_end FROM resultant opt_matbp_delimiter opt_matbp_setting
    | matread_statement {} ident_options {} FROM file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | matwrite_statement {} ident_options {} on_or_to file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | nobuf_or_flush opt_resultant opt_io_setting {} opt_null_cond_body
    | ON resultant GOSUB {} gosub_label_list
    | ON resultant GOTO {} goto_label_list
    | INPUTTRAP resultant GOSUB {} gosub_label_list
    | INPUTTRAP resultant GOTO {} goto_label_list
    | OUT resultant
    | PAGE opt_on opt_gen_resultant
    | PRECISION resultant
    | PRINT {} opt_print_on optional_prints
    | PRINTERR resultant optional_from
    | PRINTER ptr_on_off_reset_close opt_on
    | PROCREAD ident_options {} cond_body_p1 cond_body_p2
    | PROCWRITE resultant
    | recordlock_statement file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | read_statement ident_options_or_attype FROM file_specifier opt_io_setting opt_sw_wait_clause {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | readv_statement ident_options_or_attype FROM attr_file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause sw_cond_body_p1 sw_cond_body_p2
    | RELEASE {} opt_nocollect_argument_list {} opt_cond_body
    | RETURN
    | RETURN TO {} Label_opt_colon
    | RETURN resultant
    | RETURN '(' opt_resultant rp
    | STOP {} opt_stop_argument_list
    | SEEK resultant opt_param opt_param opt_io_setting {} cond_body_p1 cond_body_p2
    | function_or_subroutine {} opt_ident_list
    | TRANSABORT {} opt_collect_argument_list {} cond_body_p1 cond_body_p2
    | TRANSTART sync_resultant {} cond_body_p1 cond_body_p2
    | TRANSEND {} opt_collect_argument_list {} cond_body_p1 cond_body_p2
    | TTYCTL resultant ',' resultant opt_io_setting {} cond_body_p1 cond_body_p2
    | TTYGET ident_options {} FROM filevar_or_lptr_or_mtu opt_io_setting {} cond_body_p1 cond_body_p2
    | TTYSET resultant {} ON filevar_or_lptr_or_mtu opt_io_setting {} cond_body_p1 cond_body_p2
    | TIMEOUT resultant ',' resultant
    | UNLOCK
    | UNLOCK resultant
    | JAC_WEOF opt_mtu opt_tape_channel {} cond_body_p1 cond_body_p2
    | write_statement resultant on_or_to file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | WRITELIST resultant on_or_to resultant opt_io_setting {} opt_cond_body
    | opt_writet opt_mtu resultant opt_tape_channel {} cond_body_p1 cond_body_p2
    | writev_statement resultant on_or_to attr_file_specifier opt_io_setting {} opt_sw_onerror_clause opt_sw_locked_clause
    | RTNDATA resultant
    | COLLECTDATA ident_options
    ;

ident_assignments
    : PP
    | MM
    | assign_options assign_operators {} resultant
    ;

assign_operators
    : '='
    | PE
    | ME
    | TE
    | DE
    | CE
    ;

for_mat_assign_list
    : '(' st_parameter_list rp
    | /* empty */
    ;

assign_options
    : attrib_assign_list substring_assign_list
    ;

matrix_assign_list
    : LP {} st_parameter_list rp
    | /* empty */
    ;

st_parameter_list
    : resultant
    | st_parameter_list ',' resultant
    ;

ex_parameter_list
    : resultant
    | ex_parameter_list ',' resultant
    ;

attrib_assign_list
    : /* empty */
    | SDYN {} nocollect_argument_list end_dyn
    ;

substring_assign_list
    : /* empty */
    | '[' {} nocollect_argument_list ']'
    ;

statement_separator
    : statement_separator new_line
    | statement_separator stat_sep
    | new_line
    | stat_sep
    ;

program_label
    : Label
    ;

new_line
    : EOL
    ;

single_line_statements
    : statement
    | single_line_statements stat_sep
    | single_line_statements stat_sep statement
    ;

func_declarator
    : DEFC
    | DEFCPP
    | DEFCE
    ;

resultant
    : '@' Identifier
    | '@' DATA
    | '@' SENTENCE
    | '@' FUNC_PARM0
    | '-' resultant
    | '+' resultant
    | resultant '+' resultant
    | resultant '^' resultant
    | resultant '-' resultant
    | resultant '/' resultant
    | resultant '*' resultant
    | resultant ':' resultant
    | resultant ':'
    | resultant EQ resultant
    | resultant '=' resultant
    | resultant '[' resultant rsq
    | resultant '[' resultant ',' resultant rsq
    | resultant '[' resultant ',' resultant ',' resultant rsq
    | resultant GT resultant
    | resultant GT EQ resultant
    | resultant LT resultant
    | resultant GE resultant
    | resultant LE resultant
    | resultant NE resultant
    | resultant AND resultant
    | cursorpos
    | resultant OR resultant
    | BITLOAD '(' {} opt_nocollect_argument_list rp
    | CALLC opt_at CFUNC_or_Identifier {} opt_func_mat_arg_list
    | BFUNC {} opt_func_mat_arg_list
    | CFUNC '(' {} opt_nocollect_argument_list ')'
    | change_or_swap '(' {} nocollect_argument_list rp
    | keyin_or_in '(' rp
    | CHAR '(' resultant ')'
    | COMPARE {} '(' nocollect_argument_list rp
    | CONTROLCHAR '(' {} nocollect_argument_list rp
    | CONVERT '(' {} nocollect_argument_list rp
    | DELETE {} '(' nocollect_argument_list rp
    | GETENV '(' resultant rp
    | GETENV '(' resultant ',' ident_options rp
    | EXTRACT '(' {} nocollect_argument_list rp
    | CRC {} '(' nocollect_argument_list rp
    | DROUND '(' resultant opt_param rp
    | FFIX '(' resultant opt_param rp
    | field_type '(' {} nocollect_argument_list rp
    | TA '(' resultant rp
    | FUNC_PARM1 '(' resultant rp
    | FUNC_PARM2 '(' resultant ',' resultant rp
    | FUNC_PARM3 '(' {} nocollect_argument_list rp
    | FUNC_PARM0 '(' rp
    | SELECTINFO '(' {} nocollect_argument_list rp
    | ERRTEXT '(' resultant {} opt_err_argument_list rp
    | GETCWD '(' ident_options rp
    | GROUP '(' {} nocollect_argument_list rp
    | INDICES '(' ident_options opt_param ')'
    | INMAT '(' {} opt_nocollect_argument_list rp
    | INSERT {} '(' nocollect_argument_list insert_delims rp
    | JAC_INT '(' resultant rp
    | JQLCOMPILE '(' resultant ',' resultant ',' resultant ',' ident_options rp
    | JQLGETPROPERTY '(' ident_options ',' ident_options ',' resultant ',' resultant rp
    | JQLPUTPROPERTY '(' resultant ',' ident_options ',' resultant ',' resultant rp
    | JQLEXECUTE '(' ident_options ',' ident_options rp
    | JQLFETCH '(' ident_options ',' ident_options ',' ident_options rp
    | xml_type '(' resultant ',' resultant rp
    | xml_type '(' resultant ',' resultant ',' ident_options rp
    | VALIDATE_PRODUCT_LICENSE '(' resultant rp
    | VALIDATE_METRICS_LICENSE '(' resultant rp
    | CONSUME_METRICS_LICENSE '(' resultant ',' resultant rp
    | PERROR '(' resultant rp
    | resultant MATCHES resultant
    | opt_read_next_or_prev opt_key ident_options_or_attype opt_identifier opt_identifier optional_from opt_io_setting
    | REPLACE {} '(' nocollect_argument_list insert_delims rp
    | opt_str_math '(' {} nocollect_argument_list rp
    | SENTENCE '(' rp
    | SENTENCE '(' resultant rp
    | SPOOLER {} '(' nocollect_argument_list rp
    | SYSTEM '(' resultant rp
    | TRANS '(' {} nocollect_argument_list rp
    | TRIM {} '(' nocollect_argument_list rp
    | dynamic_reference
    | fmt_type '(' resultant ',' resultant ')'
    | STATUS '(' rp
    | REMOVE '(' resultant ',' ident_options rp
    | resultant format_options %prec Identifier
    | PP ident_options
    | MM ident_options
    | post_ident_expressions
    | Constant
    | '(' resultant rp
    | IF resultant THEN resultant ELSE resultant
    ;

post_ident_expressions
    : ident_options
    | ident_options PP
    | ident_options MM
    ;

dynamic_var_reference
    : ident_options SDYN {} nocollect_argument_list end_dyn
    ;

dynamic_reference
    : resultant SDYN {} nocollect_argument_list end_dyn
    ;

matrix_arg
    : resultant
    | matrix
    ;

matrix
    : JAC_MAT Identifier
    ;

mat_extract
    : Identifier '('
    ;

format_options
    : Constant
    | ident_options
    | dynamic_var_reference
    ;

ident_options_or_attype
    : ident_options
    | '@' Identifier
    ;

ident_options
    : mat_extract ex_parameter_list rp
    | Identifier
    ;

opt_common_name
    : '/' {} Constant {} '/'
    | /* empty */
    ;

common_identifier_list
    : common_identifier
    | common_identifier_list ',' common_identifier
    ;

common_identifier
    : Identifier
    | dimvar
    ;

opt_sw_onerror_clause
    : /* empty */
    | ON ERROR {} cond_stats
    ;

opt_sw_locked_clause
    : /* empty */
    | LOCKED {} cond_stats
    ;

opt_sw_wait_clause
    : /* empty */
    | WAITING resultant
    ;

opt_cond_body
    : /* empty */
    | error_cond_body
    ;

error_cond_body
    : ON ERROR {} cond_stats
    ;

opt_null_cond_body
    : /* empty */
    | null_cond_body_p1 cond_body_p2
    ;

null_cond_body_p1
    : THEN {} cond_stats
    | ELSE {} cond_stats
    ;

cond_body_p1
    : THEN {} cond_stats
    | opt_dummy_then ELSE {} cond_stats
    ;

cond_body_p2
    : /* empty */
    | ELSE {} cond_stats
    ;

opt_null_sw_cond_body
    : /* empty */
    | null_sw_cond_body_p1 sw_cond_body_p2
    ;

null_sw_cond_body_p1
    : THEN {} cond_stats
    | ELSE {} cond_stats
    ;

sw_cond_body_p1
    : THEN {} cond_stats
    | opt_dummy_then ELSE {} cond_stats
    ;

sw_cond_body_p2
    : /* empty */
    | ELSE {} cond_stats
    ;

opt_dummy_then
    : /* empty */
    | THEN
    ;

cond_stats
    : statements JAC_END
    | single_line_statements
    ;

optional_time
    : opt_unfiltered
    | for_or_waiting resultant opt_unfiltered {} cond_body_p1 cond_body_p2
    ;

opt_unfiltered
    : /* empty */
    | UNFILTERED
    ;

optional_input_limit
    : /* empty */
    | ',' resultant
    | ',' resultant ',' resultant
    ;

optional_input_colon
    : /* empty */
    | ':'
    | '_'
    | '_' ':'
    | ':' '_'
    ;

optional_input_with
    : /* empty */
    | WITH resultant
    ;

optional_input_mask
    : /* empty */
    | Constant
    ;

optional_prints
    : /* empty */
    | multiple_print_arg
    ;

print_arg
    : ','
    | resultant
    ;

multiple_print_arg
    : print_arg
    | multiple_print_arg print_arg
    ;

optional_curpos
    : /* empty */
    | cursorpos optional_colon
    ;

optional_colon
    : /* empty */
    | ':'
    ;

cursorpos
    : POSCUR '(' {} nocollect_argument_list rp
    ;

optional_step
    : /* empty */
    | STEP resultant
    ;

statements_and_opt_while_until_body
    : statements opt_while_until_body
    | statements_and_opt_while_until_body opt_while_until_body
    ;

opt_while_until_body
    : /* empty */
    | while_until opt_do stat_body
    ;

while_until
    : WHILE resultant
    | UNTIL resultant
    ;

dimvar_list
    : dimvar
    | dimvar_list ',' dimvar
    ;

dimvar
    : Identifier '(' {} nocollect_argument_list rp
    ;

optional_from
    : /* empty */
    | FROM resultant
    ;

optional_sleep
    : /* empty */
    | resultant
    ;

optional_pause
    : /* empty */
    | resultant
    ;

opt_until
    : /* empty */
    | UNTIL resultant
    ;

opt_waiting
    : /* empty */
    | WAITING resultant
    ;

opt_returning
    : /* empty */
    | SETTING ident_options
    ;

opt_get_length
    : /* empty */
    | ',' resultant
    ;

case_structure
    : JAC_BEGIN CASE statement_separator cases {} JAC_END CASE
    ;

cases
    : /* empty */
    | CASE resultant {} stat_body
    | cases CASE resultant {} stat_body
    | cases error
    ;

insert_delims
    : /* empty */
    | ';' resultant
    ;

stat_body
    : statements
    | single_line_statements
    ;

opt_single_line_statements
    : /* empty */
    | single_line_statements
    ;

opt_param
    : /* empty */
    | ',' resultant
    ;

opt_identifier
    : /* empty */
    | ',' ident_options
    ;

opt_select_to
    : /* empty */
    | TO ident_options
    | TO Constant
    ;

opt_select_fdsc
    : /* empty */
    | ident_options
    ;

opt_clearf_fdsc
    : /* empty */
    | ident_options
    ;

opt_open_fdsc
    : /* empty */
    | TO ident_options
    ;

file_specifier
    : resultant
    | ident_options ',' resultant
    ;

attr_file_specifier
    : {} nocollect_argument_list
    ;

opt_seq
    : /* empty */
    | ';' resultant
    ;

opt_func_mat_arg_list
    : LP {} opt_func_mat_argument_list ')'
    ;

opt_func_mat_argument_list
    : /* empty */
    | matrix_arg
    | mat_argument_list ',' matrix_arg
    ;

opt_mat_arg_list
    : /* empty */
    | LP {} mat_argument_list ')'
    ;

mat_argument_list
    : matrix_arg
    | mat_argument_list ',' matrix_arg
    ;

c_func_type
    : c_func_types
    | /* empty */
    ;

c_func_types
    : JAC_INT
    | JAC_FLOAT
    | JAC_VAR
    | JAC_STRING
    ;

opt_c_var_list
    : /* empty */
    | c_var_list
    ;

c_var_list
    : c_func_types
    | c_var_list ',' c_func_types
    ;

opt_b_var_list
    : /* empty */
    | b_var_list
    ;

b_var_list
    : b_func_types
    | b_var_list ',' b_func_types
    ;

b_func_types
    : Identifier
    | JAC_MAT Identifier
    ;

stop_argument_list
    : resultant
    | stop_argument_list ',' resultant
    ;

opt_err_argument_list
    : /* empty */
    | ',' stop_argument_list
    ;

opt_stop_argument_list
    : /* empty */
    | stop_argument_list
    ;

ident_list
    : Identifier
    | ident_list ',' Identifier
    | JAC_MAT Identifier
    | ident_list ',' JAC_MAT Identifier
    ;

opt_ident_list
    : /* empty */
    | '(' ident_list ')'
    ;

mat_statement
    : JAC_MAT Identifier {} '='
    ;

optional_exec_options
    : optional_exec_stuff
    | /* empty */
    ;

optional_exec_stuff
    : optional_exec_stats
    | optional_exec_stuff optional_exec_stats
    ;

optional_exec_stats
    : CAPTURING ident_options
    | SETTING ident_options
    | PASSLIST opt_sel_list2
    | RTNLIST opt_sel_list1
    | PASSDATA resultant
    | RTNDATA ident_options
    ;

sync_resultant
    : SYNC
    | SYNC resultant
    | resultant
    | /* empty */
    ;

opt_sel_list1
    : ident_options
    | /* empty */
    | Constant
    ;

opt_gen_resultant
    : resultant
    | /* empty */
    ;

opt_sel_list2
    : resultant
    | /* empty */
    ;

goto_label_list
    : Label_opt_colon
    | goto_label_list ',' {} Label_opt_colon
    ;

gosub_label_list
    : Label_opt_colon
    | gosub_label_list ',' {} Label_opt_colon
    ;

opt_loc_dyns
    : LOC_SDYN {} resultant opt_param opt_param end_dyn
    | /* empty */
    ;

opt_dyns
    : SDYN resultant opt_param opt_param end_dyn
    | /* empty */
    ;

opt_next_var
    : /* empty */
    | Identifier {} for_mat_assign_list
    ;

opt_by_seq
    : /* empty */
    | BY resultant
    ;

opt_matbp_start_end
    : /* empty */
    | ',' resultant
    | ',' resultant ',' resultant
    ;

opt_matbp_delimiter
    : /* empty */
    | USING resultant
    | ',' resultant
    ;

opt_matbp_setting
    : /* empty */
    | SETTING ident_options
    ;

opt_setting
    : /* empty */
    | SETTING ident_options
    ;

opt_io_setting
    : /* empty */
    | SETTING ident_options
    ;

opt_remove_at
    : AT ident_options
    | /* empty */
    ;

get_getx
    : GET
    | GETX
    ;

send_sendx
    : SEND
    | SENDX
    ;

exec_perf
    : EXECUTE
    | PERFORM
    | PCPERFORM
    | MDPERFORM
    | UDTEXECUTE
    | EXEC
    ;

loc_stat
    : {} LOCATE
    ;

opt_on
    : ON Constant
    | ON ident_options
    | /* empty */
    ;

opt_print_on
    : ON simple_print_expression
    | /* empty */
    ;

simple_print_expression
    : Constant
    | '(' resultant ')'
    | ident_options
    | simple_print_expression '+' simple_print_expression
    | simple_print_expression '-' simple_print_expression
    ;

opt_tape_channel
    : on_from resultant
    | /* empty */
    ;

on_from
    : ON
    | FROM
    ;

func_ident
    : Identifier
    | CFUNC
    ;

rp
    : ')'
    ;

stat_sep
    : ';'
    ;

end_dyn
    : EDYN
    ;

rsq
    : ']'
    ;

close_identifier_list
    : ident_options
    | close_identifier_list ',' ident_options
    ;

on_or_to
    : ON
    | TO
    ;

opt_do
    : DO
    | /* empty */
    ;

opt_readonly
    : READONLY
    | /* empty */
    ;

opt_append
    : APPEND
    | /* empty */
    ;

opt_existing
    : EXISTING
    | /* empty */
    ;

Label_opt_colon
    : Label
    | Label ':'
    ;

sql_prefix
    : EXEC SQL
    ;

sql_stats
    : DECLARE Identifier TABLE '(' {} sql_tabdefs ')' ';'
    | JAC_BEGIN DECLARE SECTION ';' {} sql_declarations sql_prefix JAC_END DECLARE SECTION ';'
    | ';'
    | /* empty */
    ;

sql_declarations
    : sql_declare
    | sql_declarations sql_declare
    ;

sql_tabdefs
    : sql_tabfld
    | sql_tabdefs ',' {} sql_tabfld
    ;

sql_tabfld
    : SMALLINT Identifier
    | JAC_INT Identifier
    | JAC_STRING '(' Constant ')' Identifier
    | JAC_FLOAT Identifier
    ;

sql_declare
    : SMALLINT Identifier ';'
    | JAC_INT Identifier ';'
    | JAC_FLOAT Identifier ';'
    | opt_sql_type '(' Constant ')' Identifier ';'
    | sql_prefix JAC_VAR
    ;

opt_read_next_or_prev
    : READNEXT
    | READPREV
    ;

opt_key
    : KEY
    | /* empty */
    ;

opt_readt
    : READT
    | READTX
    ;

opt_writet
    : WRITET
    | WRITETX
    ;

opt_mtu
    : /* empty */
    | UNIT '(' resultant ')'
    ;

opt_static_decl
    : STATIC
    | /* empty */
    ;

opt_sql_type
    : JAC_STRING
    | BLOB
    | VARCHAR
    ;

opt_str_math
    : SADD
    | SSUB
    | SDIV
    | SMUL
    ;

opt_sleep
    : SLEEP
    | MSLEEP
    ;

writeseq_type
    : WRITESEQ
    | WRITESEQF
    ;

field_type
    : FIELD
    | FIELDS
    ;

heading_type
    : HEADING
    | HEADINGE
    | HEADINGN
    ;

fmt_type
    : FMT
    | FMTS
    ;

ptr_on_off_reset_close
    : ON
    | OFF
    | RESET
    | CLOSE
    ;

change_or_swap
    : CHANGE
    | SWAP
    ;

echo_or_hush
    : JAC_ECHO
    | JAC_HUSH
    ;

sselect_or_sselectn_or_sselectv
    : SSELECT
    | SSELECTN
    | SSELECTV
    ;

filevar_or_lptr_or_mtu
    : resultant
    | JAC_LPTR resultant
    | MTU resultant
    ;

basic_declarator
    : DEFFUN
    | DEFB
    ;

function_or_subroutine
    : SUBROUTINE
    | FUNCTION
    ;

opt_resultant
    : /* empty */
    | resultant
    ;

funcname
    : Identifier
    | funcname ',' Identifier
    ;

recordlock_statement
    : RECORDLOCKU
    | RECORDLOCKL
    ;

read_statement
    : READ
    | READU
    | READL
    | READX
    | READXU
    | READXL
    | READXML
    | READXMLU
    ;

readv_statement
    : READV
    | READVU
    | READVL
    ;

matread_statement
    : MATREAD
    | MATREADU
    | MATREADL
    ;

write_statement
    : WRITE
    | WRITEX
    | WRITEU
    | WRITEXU
    | WRITEXML
    | WRITEXMLU
    ;

delete_statement
    : DELETE
    | DELETEU
    ;

writev_statement
    : WRITEV
    | WRITEVU
    ;

matwrite_statement
    : MATWRITE
    | MATWRITEU
    ;

to_or_with
    : TO
    | WITH
    ;

opt_namedcommon_name
    : '/' {} Constant {} '/'
    | /* empty */
    ;

keyin_or_in
    : KEYIN
    | IN
    ;

nocollect_argument_list
    : /* empty */
    | nocollect_mult_arg_list
    ;

opt_nocollect_argument_list
    : /* empty */
    | nocollect_mult_arg_list
    ;

nocollect_mult_arg_list
    : resultant
    | nocollect_mult_arg_list ',' resultant
    ;

collect_argument_list
    : /* empty */
    | collect_mult_arg_list
    ;

opt_collect_argument_list
    : /* empty */
    | collect_mult_arg_list
    ;

collect_mult_arg_list
    : resultant
    | collect_mult_arg_list ',' resultant
    ;

opt_at
    : '@'
    | /* empty */
    ;

for_or_waiting
    : FOR
    | WAITING
    ;

nobuf_or_flush
    : NOBUF
    | FLUSH
    ;

CFUNC_or_Identifier
    : CFUNC
    | Identifier
    ;

xml_type
    : DYNTOXML
    | XMLTODYN
    | XMLTOXML
    | XMLADDTEXT
    | XMLADDNODE
    | XMLVALIDATE
    | XMLGETTAGVALUE
    ;
%%

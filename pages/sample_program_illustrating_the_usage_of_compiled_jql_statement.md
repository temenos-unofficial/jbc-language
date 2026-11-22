# Sample program illustrating the usage of compiled jQL statement:

    INCLUDE jQLProperties.h
       //
       IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       //
       V.QUERY = 'LIST ONLY ' : V.HOME : '/jbcmessages'
       V.STMT = ''
       //
       V.DUMMY = JQLCOMPILE(V.STMT, V.QUERY, 0, V.MSG)
       //
       V.SEL.VAR = ''
       V.RET = JQLEXECUTE(V.STMT, V.SEL.VAR)
       IF V.RET NE 0 THEN CRT 'JQLEXECUTE RETURNED', V.RET  ; STOP
       //
       LOOP
          GOSUB FETCH.NEXT
       UNTIL V.FETCH NE 1
       REPEAT
       //
       STOP
       //
    FETCH.NEXT:
       //
       V.FETCH = JQLFETCH(V.STMT, V.CTRL, V.DATA)
       IF V.FETCH NE 1 THEN RETURN
       V.RET = JQLGETPROPERTY(PropertyValue, V.STMT, 0, \
    	 STMT_PROPERTY_EXECUTE_COUNT)
       CRT 'ID #' : PropertyValue : ':' , V.DATA<1>
       //
       RETURN
    END

Output:

<pre>
    @ID #1:	INV_FILE_TYPE
    @ID #2:	DEVICE_QUIT
    @ID #3:	RTN_NOGOSUB
    @ID #4:	ARRAY_ILLEGAL_SIZE
    @ID #5:	DIFF_COMMON
    @ID #6:	QLNOVERB
    @ID #7:	QLPARAMERR
    ...
    @ID #487:	417
    @ID #488:	80044228
    @ID #489:	80044233
    @ID #490:	80045024</pre>

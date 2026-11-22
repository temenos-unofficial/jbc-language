# To wrap a long line

Use a backslash:

       V.LINE = 'The report for the year ' :@FM: V.YEAR : ', prepared at ' \
            : TIMEDATE()

***TAFJ note: routine with such line extension won't even compile.***

Or - if line ends with a comma - that's not necessary:

       V.STAT = IOCTL(F.TEST.FILE,
             JIOCTL_COMMAND_FINDRECORD_EXTENDED, V.NAME)

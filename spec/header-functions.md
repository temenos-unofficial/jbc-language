# Functions declared in JBC.h

Each row is one direct DEFC declaration. The line number refers to the snapshot identified in the [specification](README.md). A guide link records a name match. A dash means the name was absent from chapter headings and text in a case-insensitive, whole-name search.

| JBC.h line | Declaration | Guide call | Guide evidence |
|---:|---|---|---|
| 198 | `DEFC JBASEScanfileInit(VAR, VAR, VAR, VAR, VAR, VAR)` | — | — |
| 199 | `DEFC JBASEScanfileRead(VAR)` | — | — |
| 200 | `DEFC JBASEScanfileEnd(VAR)` | — | — |
| 209 | `DEFC INT JBASECheckRemote(VAR)` | — | — |
| 214 | `DEFC VAR JBASECALLC(STRING, VAR)` | — | — |
| 218 | `DEFC INT JBASEGetInode(VAR)` | — | — |
| 222 | `DEFC VAR JBASEGetDevInode(VAR)` | — | — |
| 226 | `DEFC INT JBASEReturnLockInfo(INT, VAR)` | — | — |
| 230 | `DEFC INT BuildFileList(STRING, VAR)` | — | — |
| 234 | `DEFC INT JBASEGetPidFromPort(INT)` | — | — |
| 238 | `DEFC INT JBASEGetPortFromPid(INT)` | — | — |
| 242 | `DEFC INT JBASEAccess(VAR, INT)` | — | — |
| 246 | `DEFC VAR JBASECanonicalInput(VAR)` | — | — |
| 250 | `DEFC INT JBASEAssertTrue(VAR)` | — | — |
| 253 | `DEFC INT JBASEAssertEquals(VAR, VAR)` | — | — |
| 260 | `DEFC INT JBASEThreadSendMessage(INT, STRING)` | — | — |
| 261 | `DEFC INT JBASEUserProfile(INT)` | — | — |
| 262 | `DEFC VAR JBASEThreadGetRootStatus(INT, INT)` | — | — |
| 263 | `DEFC INT JBASEThreadSetRootStatus(VAR, INT)` | — | — |
| 264 | `DEFC INT JBASETHREADCreate(VAR, VAR, VAR, VAR)` | `JBASETHREADCreate(ProgramName, Arguments, User, Handle)` | [JBASETHREADCreate](https://jbc-lang.org/pages/jbasethreadcreate.html) |
| 265 | `DEFC INT JBASETHREADStatus(VAR)` | `JBASETHREADStatus(ThreadList)` | [JBASETHREADStatus](https://jbc-lang.org/pages/jbasethreadstatus.html) |
| 269 | `DEFC VAR CALLJEE(VAR, VAR)` | `CALLJEE(ACTIVATION, ADDINFO)` | [CALLJEE](https://jbc-lang.org/pages/calljee.html) |
| 270 | `DEFC VAR JEEOpen(VAR, VAR)` | — | — |
| 271 | `DEFC VAR JEEOpenSSL(VAR, VAR, VAR, VAR)` | — | — |
| 272 | `DEFC VAR JEEClose(VAR)` | — | — |
| 273 | `DEFC VAR JEEActivate(VAR, VAR, VAR)` | — | — |
| 275 | `DEFC VAR MONStartUnitOfWork(VAR)` | — | — |
| 276 | `DEFC VAR MONEndUnitOfWork()` | — | — |
| 277 | `DEFC VAR MONCurrentUnitOfWork()` | — | — |
| 278 | `DEFC VAR MONIsUnitOfWorkMonitored()` | — | — |
| 279 | `DEFC VAR MONIsInsideUnitOfWork()` | — | — |
| 280 | `DEFC VAR MONDump()` | — | — |
| 281 | `DEFC VAR MONAddSingleUnitOfWork(VAR, VAR)` | — | — |
| 282 | `DEFC VAR MONAddRepetitiveUnitOfWork(VAR, VAR)` | — | — |
| 286 | `DEFC VAR CachePut(VAR, VAR, VAR)` | `CachePut(bucket, item, value)` | [CachePut](https://jbc-lang.org/pages/cacheput.html) |
| 287 | `DEFC VAR CacheGet(VAR, VAR)` | `CacheGet(bucket, item)` | [CacheGet](https://jbc-lang.org/pages/cacheget.html) |
| 288 | `DEFC VAR CacheDelete(VAR, VAR)` | `CacheDelete(bucket, item)` | [CacheDelete](https://jbc-lang.org/pages/cachedelete.html) |
| 289 | `DEFC VAR CacheExists(VAR, VAR)` | `CacheExists(bucket, item)` | [CacheExists](https://jbc-lang.org/pages/cacheexists.html) |
| 290 | `DEFC VAR CacheClear(VAR)` | `CacheClear(bucketname)` | [CacheClear](https://jbc-lang.org/pages/cacheclear.html) |
| 291 | `DEFC VAR CacheClearAll()` | `CacheClearAll()` | [CacheClearAll](https://jbc-lang.org/pages/cacheclearall.html) |
| 292 | `DEFC VAR CacheKeyList(VAR, VAR)` | `CacheKeyList(bucket, delimiter)` | [CacheKeyList](https://jbc-lang.org/pages/cachekeylist.html) |
| 293 | `DEFC VAR CacheBucketList(VAR)` | `CacheBucketList(delimiter)` | [CacheBucketList](https://jbc-lang.org/pages/cachebucketlist.html) |
| 300 | `DEFC VAR CacheStats(VAR, VAR)` | `CacheStats(bucket, counter_id)` | [CacheStats](https://jbc-lang.org/pages/cachestats.html) |
| 301 | `DEFC VAR CacheClearStats(VAR)` | `CacheClearStats()` | [CacheClearStats](https://jbc-lang.org/pages/cacheclearstats.html) |
| 305 | `DEFC VAR CacheSetOption(VAR, VAR, VAR)` | `CacheSetOption(bucket, option, value)` | [CacheSetOption](https://jbc-lang.org/pages/cachesetoption.html) |
| 306 | `DEFC VAR CacheGetOption(VAR, VAR)` | `CacheGetOption(bucket, option)` | [CacheGetOption](https://jbc-lang.org/pages/cachegetoption.html) |
| 315 | `DEFC VAR Logger(VAR, VAR, INT)` | `Logger(Category, Severity, Message)` | [Logger](https://jbc-lang.org/pages/logger.html) |
| 316 | `DEFC VAR LoggerDescribe(VAR, VAR)` | — | — |
| 319 | `DEFC VAR GetProperty(VAR, VAR)` | — | — |
| 320 | `DEFC VAR PutProperty(VAR, VAR, VAR)` | — | — |
| 330 | `DEFC VAR LoggerPrint(VAR, VAR, VAR)` | — | — |
| 331 | `DEFC VAR LoggerDebugPrint(VAR, VAR, VAR)` | — | — |
| 332 | `DEFC VAR LoggerVerbosePrint(VAR, VAR, VAR)` | — | — |

The three scan-file declarations omit the return type. The implementation defaults it to INT in `c_func_type`. The header also equates `ASSERTTRUE` to `JBASEAssertTrue` and `ASSERTEQUALS` to `JBASEAssertEquals`. Its `INCLUDE jportB.h` may contribute additional declarations on an installed system.

## Reading the signatures

The guide calls `CacheGet(bucket, item)`, matching the two VAR arguments on line 287. The CALLJEE chapter gives a two-argument example even though it has no command syntax section. For Logger, the header places INT third. The guide passes the severity constant second and message text third. Preserve that disagreement when mapping the external call.

The CacheClearStats chapter gives zero arguments in COMMAND SYNTAX and one bucket in its example. Only the example agrees with the header declaration on line 301.

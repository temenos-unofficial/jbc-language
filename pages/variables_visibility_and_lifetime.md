# Variables visibility and lifetime

Variable is visible throughout the program or its subroutine (i.e. in
the bounds of particular source code file). To share a variable between
different programs/subroutines pass them as parameters in [CALL](https://jbc-lang.org/pages/call.md)
statement or use a named or unnamed [COMMON](https://jbc-lang.org/pages/common.md).

All variables (except ones in COMMON areas) are reset (i.e. become unassigned) upon program end.

See also: [SUBROUTINE](https://jbc-lang.org/pages/subroutine.md), [ASSIGNED](https://jbc-lang.org/pages/assigned.md), [UNASSIGNED](https://jbc-lang.org/pages/unassigned.md).

# FIELDS

The FIELDS function is an extension of the FIELD function. It returns a
dynamic array of multi-character delimited fields from a dynamic
array of strings.

## COMMAND SYNTAX

    FIELDS(DynArr, Delimiter, Occurrence{, ExtractCount})

## SYNTAX ELEMENTS

**DynArr** should evaluate to a dynamic array.

**Delimiter** specifies the character or characters that delimit the
fields within the dynamic array.

**Occurrence** should evaluate to an integer of value 1 or higher. It
specifies the delimiter used as the starting point for the extraction.

**ExtractCount** is an integer that specifies the number of fields to
extract. If omitted, assumes one.

## NOTES

If the emulation option, jbase_field, is set then the field delimiter
may consist of more than a single character, allowing fields to be
delimited by complex codes.

## EXAMPLES

The following program shows how each element of a dynamic array can be
changed with the FIELDS function.

    t = ""
    t<1> = "a:b:c:d:e:f"
    t<2> = "aa:bb:cc:dd:ee:ff" : @VM: "1:2:3:4" : @SM: ":W:X:Y:Z"
    t<3> = "aaa:bbb:ccc:ddd:eee:fff" :@VM:@SM
    t<4> = "aaaa:bbbb:cccc:dddd:eeee:ffff"
    r1 = FIELDS(t,':',2)
    r2 = FIELDS(t,':',2,3)
    r3 = FIELDS(t,'bb',1,1)

The above program creates three dynamic arrays.

V - represents a value mark.

s - represents a sub-value mark.

|Array| Contents                                         |
|-----|--------------------------------------------------|
| r1  | <1>b                                             |
|     | <2>bb v 2 s W                                    |
|     | <3>bbb                                           |
|     | <4>bbbb                                          |
|     |                                                  |
| r2  | <1>b:c:d                                         |
|     | <2>bb:cc:dd v 2:3:4 s W:X:Y<3>bbb:ccc:ddd v s    |
|     | <4>bbbb:cccc:dddd                                |
|     |                                                  |
| r3  | <1>a:b:c:d:e:f                                   |
|     | <2>aa: v 1:2:3:4 s W:X:Y:Z                       |
|     | <3>aaa: v s                                      |
|     | <4>aaaa:                                         |

# DECRYPT

The DECRYPT function decrypts strings.

## COMMAND SYNTAX

    DECRYPT(string, key, method)

## SYNTAX ELEMENTS

**string** specifies the string to be decrypted.

**Key** is the value used to decrypt the string. Its use depends on
method.

**method** is a value, which indicates the encryption mechanism to
use (see below).

The [ENCRYPT](https://jbc-lang.org/pages/encrypt.md) and DECRYPT functions that are part of jBC
now support the following cipher methods (Defined in JBC.h)

| Value               |    Description                             |
|---------------------|--------------------------------------------|
| JBASE_CRYPT_GENERAL |    General-purpose encryption scheme       |
| JBASE_CRYPT_ROT13   |    Simple ROT13 algorithm. (Key not used)  |
| JBASE_CRYPT_XOR11   |    XOR MOD11 algorithm. Uses the first     |
|                     |    character of a key as a seed value      |
| JBASE_CRYPT_RC2     |    RC2 algorithm                           |
| JBASE_CRYPT_DES     |    DES algorithm                           |
| JBASE_CRYPT_3DES    |    Three Key, Triple DES algorithm         |
| JBASE_CRYPT_BLOWFISH|    Blowfish algorithm                      |
| JBASE_CRYPT_AES     |    AES algorithm                           |
| JBASE_CRYPT_BASE64  |    (See below)                             |

BASE64 is not really an encryption method, but more of an encoding. The
reason for this is that the output of an encryption often results in a
binary string. It allows binary data to be represented as a character
string. BASE64 operation is not required but is performed in addition
to the primary algorithm.  e.g. JBASE_CRYPT_RC2_BASE64

ENCRYPT with this method is the same as a DECRYPT with method
JBASE_CRYPT_RC2 followed by DECRYPT with method JBASE_CRYPT_BASE64.

DECRYPT with this method is the same as a DECRYPT with method
JBASE_CRYPT_BASE64 followed by DECRYPT with method JBASE_CRYPT_RC2.

| Value                       |    Description       |
|-----------------------------|----------------------|
|JBASE_CRYPT_RC2_BASE64       | RC2 algorithm        |
|JBASE_CRYPT_DES_BASE64       | DES algorithm        |
|JBASE_CRYPT_3DES_BASE64      | Triple DES algorithm |
|JBASE_CRYPT_BLOWFISH_BASE64  | Blowfish algorithm   |

## NOTES

See also: [ENCRYPT](https://jbc-lang.org/pages/encrypt.md)

***TAFJ note: JBASE_CRYPT_XOR11 gives the error "java.security.InvalidKeyException: Wrong key size".***

***TAFJ note 2: JBASE_CRYPT_BLOWFISH_BASE64 gives the result that differs from one in TAFC.***

## EXAMPLES

    INCLUDE JBC.h
    //
    IF DECRYPT('rknzcyr', '', JBASE_CRYPT_ROT13) = "example" THEN
      CRT "ROT13 ok"
    END
    //
    IF ENCRYPT('g{ehvkm', '9', JBASE_CRYPT_XOR11) = "example" THEN
      CRT "XOR.MOD11 ok"
    END
    //
    cipher = JBASE_CRYPT_BLOWFISH_BASE64
    key    = "Our Very Secret Key"
    str    = "String to encrypt"
    enc = ENCRYPT( str, key, cipher )
    CRT "Encrypted: " : enc
    dec = DECRYPT( enc, key, cipher )
    CRT "Decrypted: " : dec

Displays as output:

<pre>
    ROT13 ok
    XOR.MOD11 ok
    Encrypted: xuy6DXxUkD32spyfsKEvUtXrsjP7mC+R
    Decrypted: String to encrypt</pre>

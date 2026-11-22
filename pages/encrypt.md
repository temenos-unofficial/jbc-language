# ENCRYPT

The ENCRYPT function encrypts strings.

## COMMAND SYNTAX

    ENCRYPT(string, key, method)

## SYNTAX ELEMENTS

**string** specifies the string for encryption.

**key** is the value used to encrypt the string. Its use depends on
method.

**method** is a value, which indicates the encryption mechanism to use
(See below):

The ENCRYPT and [DECRYPT](https://jbc-lang.org/pages/decrypt.md) functions that are part of jBC now
support the following cipher methods (Defined in JBC.h)

| Value               |    Description                                      |
|---------------------|-----------------------------------------------------|
| JBASE_CRYPT_GENERAL |    General-purpose encryption scheme                |
| JBASE_CRYPT_ROT13   |    Simple ROT13 algorithm. (Key not used)           |
| JBASE_CRYPT_XOR11   |    XOR MOD11 algorithm. Uses the first character of |
|                     |     a key as a seed value.                          |
| JBASE_CRYPT_RC2     |    RC2 algorithm                                    |
| JBASE_CRYPT_DES     |    DES algorithm                                    |
| JBASE_CRYPT_3DES    |    Three Key, Triple DES algorithm                  |
| JBASE_CRYPT_BLOWFISH|    Blowfish algorithm                               |
| JBASE_CRYPT_AES     |    AES algorithm                                    |
| JBASE_CRYPT_BASE64  |    (See below)                                      |

BASE64 is more of an encoding method rather than an encryption method.
The reason for this is that the output of an encryption often results in
a binary string, which allows the representation of binary data as a
character string. Although not required the BASE64 operation is performed
in addition to the primary algorithm.  E.g. JBASE_CRYPT_RC2_BASE64

ENCRYPT with this method is the same as an ENCRYPT with method
JBASE_CRYPT_RC2 followed by ENCRYPT with method JBASE_CRYPT_BASE64.

DECRYPT with this method is the same as a DECRYPT with method
JBASE_CRYPT_BASE64 followed by DECRYPT with method JBASE_CRYPT_RC2.

| Value                       |    Description       |
|-----------------------------|----------------------|
|JBASE_CRYPT_RC2_BASE64       | RC2 algorithm        |
|JBASE_CRYPT_DES_BASE64       | DES algorithm        |
|JBASE_CRYPT_3DES_BASE64      | Triple DES algorithm |
|JBASE_CRYPT_BLOWFISH_BASE64  | Blowfish algorithm   |
|JBASE_CRYPT_AES_BASE64       | AES algorithm        |

## NOTES

See also: [DECRYPT](https://jbc-lang.org/pages/decrypt.md).

## EXAMPLES

    INCLUDE JBC.h
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

## Hashing

The ENCRYPT function now supports SHA-2 hashing algorithms.

|JBC.h define                     | Hashing algorithm                   |
|---------------------------------|-------------------------------------|
|JBASE_SECUREHASH_SHA256          | SHA-2 family hashing algorithm      |
|JBASE_SECUREHASH_SHA256_BASE64   | SHA256 with BASE64                  |

## Hashing Example

    INCLUDE JBC.h
    Key = "" ;* unused for hashing
    EncryptType = JBASE_SECUREHASH_SHA256_BASE64
    StrOut = ENCRYPT(StrIn, Key, EncryptType)

## NOTES

See also: [DECRYPT](https://jbc-lang.org/pages/decrypt.md).

See also: <a href="http://en.wikipedia.org/wiki/SHA-2">Wiki</a>

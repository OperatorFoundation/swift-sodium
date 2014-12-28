Swift-Sodium
=============

Swift-Sodium provides a safe and easy to use interface to perform
common cryptographic operations on iOS and OSX.

It leverages the [Sodium](http://libsodium.org/doc/) library, and
although Swift is the primary target, the framework can also be used in
Objective C.

Swift-Sodium is a work in progress.

Public-key authenticated encryption
===================================

```swift
let sodium = Sodium()!
let aliceKeyPair = sodium.box.keyPair()!
let bobKeyPair = sodium.box.keyPair()!
let message: NSData = "My Test Message".toData()!

let encryptedMessageFromAliceToBob: NSData = sodium.box.seal(message, recipientPublicKey: bobKeyPair.publicKey, senderSecretKey: aliceKeyPair.secretKey)!
let decryptedMessageByBob = sodium.box.open(encryptedMessageFromAliceToBob, senderPublicKey: bobKeyPair.publicKey, recipientSecretKey: aliceKeyPair.secretKey)
```

`seal()` automatically generates a nonce and prepends it to the
ciphertext. `open()` extracts the nonce and decrypts the ciphertext.

The `Box` class also provides alternative functions and parameters to
deterministically generate key pairs, to retrieve the nonce and/or the
authenticator, and to detach them from the original message.

Public-key signatures
=====================

Detached signatures
-------------------

```swift
let sodium = Sodium()!
let message = "My Test Message".toData()!
let keyPair = sodium.sign.keyPair()!
let signature = sodium.sign.signature(message, secretKey: keyPair.secretKey)!
if sodium.sign.verify(message, publicKey: keyPair.publicKey, signature) {
  // signature is valid
}
```

Attached signatures
-------------------

```swift
let sodium = Sodium()!
let message = "My Test Message".toData()!
let keyPair = sodium.sign.keyPair()!
let signedMessage = sodium.sign.sign(message, secretKey: keyPair.secretKey)!
if let unsignedMessage = sodium.sign.open(message, publicKey: keyPair.publicKey) {
  // signature is valid
}

Hashing
=======

Deterministic hashing
---------------------

```swift
let sodium = Sodium()!
let message = "My Test Message".toData()!
let h = sodium.genericHash.hash(message)
```

Keyed hashing
-------------

```swift
let sodium = Sodium()!
let message = "My Test Message".toData()!
let key = "Secret key".toData()!
let h = sodium.genericHash.hash(message, key: key)
```

Streaming
---------

```swift
let sodium = Sodium()!
let (message1, message2) = ("My Test ".toData()!, "Message".toData()!)
let key = "Secret key".toData()!
let stream = sodium.genericHash.initStream(key)!
stream.update(message1)
stream.update(message2)
let h = stream.final()
```

Short-output hashing (SipHash)
==============================

```swift
let sodium = Sodium!
let message = "My Test Message".toData()!
let key = sodium.randomBytes.buf(ShortHash.KeyBytes)!
let h = sodium.shortHash.hash(message, key: key)
```

Random numbers generation
=========================

```swift
let sodium = Sodium()!
let randomData = sodium.randomBytes.buf(1000)
```

Utilities
=========

Zeroing memory
--------------

```swift
var dataToZero: NSMutableData
sodium.utils.zero(dataToZero)
```

Constant-time comparison
------------------------

```swift
let secret1: NSData
let secret2: NSData
let equality = sodium.utils.equals(secret1, to: secret2)
```

Constant-time hexadecimal encoding
----------------------------------

```swift
let data: NSData
let hex = sodium.utils.bin2hex(data)
```

Hexadecimal decoding
--------------------

```swift
let data1 = sodium.utils.hex2bin("deadbeef")
let data2 = sodium.utils.hex2bin("de:ad be:ef", ignore: " :")
```

# hider [![Travis-CI Build Status](https://travis-ci.org/bfatemi/hider.svg?branch=master)](https://travis-ci.org/bfatemi/hider) [![codecov](https://codecov.io/gh/bfatemi/hider/branch/master/graph/badge.svg?token=5Iuh0xYKFZ)](https://codecov.io/gh/bfatemi/hider) [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/hider)](https://cran.r-project.org/package=hider)

The goal of hider is to simplify secure encryption so the average R user can utilize it hasslefree

## Example 

This package provides two functions (wrappers around functionality from the package 'sodium') to hide and unhide any object with as few steps as possible.

Most often this object will be a dataset but these wrappers will *hide* or *unhide* anything

```R
# The function keychain creates a private key,
# then uses it to generate the public key.
# Both are returned in a named list.
keys <- keychain()

keys.public  <- keys$pubkey    # pubkey is used for Encryption
keys.private <- keys$privkey   # privkey is used for Decryption

## example of encryption

# hide will serialize and encrypt using a public key
hiddenObj <- hide("hello world", keys.public)
hiddenObj

# unhide will decrypt and deserialize a hidden object, using 
# the private key that generated the public key used to hide 
# the object initially
unhide(hiddenObj, keys.private)

```


# The function keychain creates a private key,
# then uses it to generate the public key.
# Both are returned in a named list.
keys <- keychain()

keys.public  <- keys$pubkey    # pubkey is used for Encryption
keys.private <- keys$privkey   # privkey is used for Decryption

## example of encryption
##
hiddenObj <- hide("hello world", keys.public)
hiddenObj

# unhide will decrypt and deserialize a hidden object
unhide(hiddenObj, keys.private)




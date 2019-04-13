
# library(sodium)
# library(protolite)
#
# keychain <- function(){
#   key <- sodium::keygen()
#   pub  <- sodium::pubkey(key)
#   list(privkey = key, pubkey = pub)
# }
#
# ##
# ## Generate keys needed for encryption, decryption, and authentication
# ##
# client_keys <- keychain()                                 #stored with client, copy of public key stored on server
# srv_keys    <- keychain()                                 #stored with server, copy of public key stored on client
# shared_key  <- "018ec6a3d3927f773a0d1b0adf516fa36b300929" #shared- client has copy, server keeps only the hash
#
# ##
# ## create the server locations to save required keys internally
# ##
# fp_client_pub <- tempfile("client_pub_key_") # srv location of clients pub key
# fp_srv_keys   <- tempfile("srv_keychain_")   # srv location of server's key chain
# fp_key_hash   <- tempfile("key_hash_")       # srv location of the hashed shared key
#
# ##
# ## SAVE TO SERVER: copy of the client's public key
# ##
# invisible(file.create(fp_client_pub))
# conn <- file(fp_client_pub, "r+b")
# invisible(serialize(client_keys$pubkey, connection = conn))
# close(conn)
#
# ##
# ## SAVE TO SERVER: its own key ring
# ##
# invisible(file.create(fp_srv_keys))
# conn <- file(fp_srv_keys, "r+b")
# invisible(serialize(srv_keys, connection = conn))
# close(conn)
#
# ##
# ## SAVE TO SERVER: make and store hash of the shared key
# ##
# invisible(file.create(fp_key_hash))
# conn <- file(fp_key_hash, "r+b")
# invisible(serialize(password_store(shared_key), connection = conn))
# close(conn)
#
#
#
#
# ##
# ## NOW CLIENT WILL AUTHENTICATE BY SENDING AN ENCRYPTED TOKEN
# ##    key is not hashed, instead its encrypted using the clients private key and the servers public key
# ##
# client_ciph <- sodium::auth_encrypt(protolite::serialize_pb(shared_key), client_keys$privkey, srv_keys$pubkey)
#
#
# ## STEP 1: client sends client_cipher to server
# ## STEP 2: server will decrypt client_cipher after receiving, using server private key, and client public key
# ## STEP 3: after client_cipher is decrypted, server unserializes into the plain text token that client sent
# ## STEP 4: server will compare the plain text token to the hash of the real token it has securely stored internally
# ## STEP 5: return bool indicating whether server's hash and client key are matched
# ##
# verify_access <- function(ciph, priv, pub, hash){
#   check_key <- unserialize_pb(auth_decrypt(ciph, priv, pub))
#   b_access  <- password_verify(hash, check_key)
#   return(b_access)
# }
#
#
# ## server to retrieve hash stored internally
# get_srv_hash <- function(fp_key_hash){
#   conn <- file(fp_key_hash, "r+b")
#   on.exit(close(conn))
#   srv_hash <- unserialize(conn)
#   return(srv_hash)
# }
#
#
#
# ## server to retrieve internally stored client key
# get_client_pubkey <- function(fp_client_pub){
#   conn <- file(fp_client_pub, "r+b")
#   on.exit(close(conn))
#   pubkey <- unserialize(conn)
#   return(pubkey)
# }
#
#
# ## server to retrieve it's own key chain
# get_srv_keychain <- function(fp_srv_keys){
#   conn <- file(fp_srv_keys, "r+b")
#   on.exit(close(conn))
#   srvkeys <- unserialize(conn)
#   return(srvkeys)
# }
#
#
# verify_access(client_ciph, srvkeys$privkey, pubkey, srv_hash)
#
#
#
#
#
# ##
# ## NEXT STEPS:
# ##        A.  TWO FACTOR AUTH: server will generate a secure random string, text it via rtwilio to
# ##            user, and wait for user to sent it back to server to verify
# ##        B.  Alternatively, if server's hash and the clients token are verified as a match, access is granted, and server
# ##            will encrypt a new authorization token with the server's private key and the client's public key. Server will
# ##            then expect this key to come back with every authenticated api call
# ##
# ## if(b_access==TRUE){
# ##   #
# ##   # ... RUN AUTHENTICATED CODE AND RETURN SECURE RESPONSE
# ##   #
# ## }else{
# ##   #
# ##   # ... RETURN ACCESS DENIED RESPONSE
# ##   #
# ## }

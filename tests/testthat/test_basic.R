
test_that("Simple test of encyption and decryption", {
  key <- sodium::keygen()         # private key is used for decryption
  pubkey <- sodium::pubkey(key)   # the resulting public key is used for encryption
  expect_identical(unhide(hide("hello world", pubkey), key), "hello world")
})

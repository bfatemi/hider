test_that("Simple test of encyption and decryption", {
  keys <- keychain()
  expect_identical(unhide(hide("hello world", keys$pubkey), keys$privkey), "hello world")
})

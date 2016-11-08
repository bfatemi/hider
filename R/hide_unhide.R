#' Encrypt and Decrypt Private Datasets
#'
#' Use the functions \code{hide} and \code{unhide} to encrypt and decrypt data.
#'
#' @details
#' \code{hide} will utilize public/private key encryption functionality provided by
#' the package \href{https://cran.r-project.org/web/packages/sodium/vignettes/intro.html}{sodium}.
#' The public key is stored locally with this package's files.
#' In order to decrypt the output of \code{hide}, the function \code{unhide}
#' will authenticate through an external deployR server. Decryption requires an interactive
#' environment when the user runs for the first time as credentials (username + password)
#' are saved locally thereafter.
#'
#' @param obj An object to hide using secure encryption
#' @param hidden_obj A hidden object to decrypt ('unhide')
#' @param public A public key used to encrypt data with the function \code{hide}
#' @param privatekey A private key that is used to decrypt data
#'
#' @import sodium
#' @example inst/examples/ex-hide_unhide.R
#' @name encryption
NULL

#' @describeIn encryption A function to hide (encrypt) an R object
#' @export
hide <- function(obj, pubkey){
  sObj <- serialize(dat, NULL)                       # serialize data
  hidden_obj <- sodium::simple_encrypt(sObj, pubkey) # encrypt data with public key
  hidden_obj
}

#' @describeIn encryption Use to unhide a hidden (encrypted) R object
#' @export
unhide <- function(hidden_obj, privatekey){
  sObj <- sodium::simple_decrypt(hidden_obj, privatekey)    # decrypt data with private key
  obj <- unserialize(sObj)                                  # deserialize data
  obj
}

#' @describeIn encryption used to generate the keychain if needed
#' @export
keychain <- function(){
  # private key is used for decryption
  # the resulting public key is used for encryption
  list(privkey = sodium::keygen(),
       pubkey = sodium::pubkey(key))
}




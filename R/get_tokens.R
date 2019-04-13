#' Secure Retrieval of Access Tokens
#'
#' Various tokens.
#'
#' @param pwd Password
#' @import sodium
#' @importFrom protolite unserialize_pb
#' @name tokens
NULL

#' @describeIn tokens check pwd
#' @export
verify <- function(pwd){
  if(is.null(pwd)) stop("provide password")
  key_serv <- readRDS(system.file("key_serv", package = "rauth"))

  key_serv <- readRDS("inst/key_serv")
  pub_serv <- readRDS("inst/pub_serv")
  pwd      <- readRDS("inst/ext/pwd")
  pwd_ciph <- readRDS("inst/ext/pwd_ciph")
  pubkey   <- readRDS("inst/ext/pubkey")

  hsh <- password_store("Newyork1")
  auth_encrypt(hsh, pubkey)
  chk <- rawToChar(auth_decrypt(pwd_ciph, key_serv, pubkey))
  stopifnot(sodium::password_verify(chk, pwd))
  return(chk)
}


#' @describeIn tokens github token
#' @export
gh_token <- function(pwd=NULL){
  verify(pwd)
  path <- system.file("tokens", "gh_home_ciph", package = "rauth")
  readRDS(path)
}


#' @describeIn tokens digitalocean token
#' @export
do_token <- function(pwd=NULL){
  verify(pwd)
  path <- system.file("tokens", "do_api_ciph", package = "rauth")
  readRDS(path)
}

#' @describeIn tokens travis ci token
#' @export
trav_token <- function(pwd=NULL){
  verify(pwd)
  path <- system.file("tokens", "trav_ciph", package = "rauth")
  readRDS(path)
}

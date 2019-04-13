#' Authenticate to Personal R Server
#'
#' Client functions to authenticate into my personal R server
#'
#' @param url API call
#' @param pwd Provide password explicitly if not stored internally or as environmental variable
#' @param ... Body arguments
#' @param fn internal
#' @param tk_name internal
#' @param package internal
#'
#' @importFrom httr GET stop_for_status content_type
#' @importFrom protolite unserialize_pb
#' @importFrom rlang fn_env global_env
#' @importFrom pryr do_call
#'
#' @name ocpu_api
NULL

#' @describeIn ocpu_api POST request
#' @export
POST_OCPU <- function(url, pwd, ...){
  api <- "http://138.68.11.251"
  nurl <- paste0(api, "/", url)
  r <- httr::POST(nurl, body = list(pwd=pwd))
  return(strsplit(rawToChar(httr::content(r, "raw")), "\n")[[1]][1])
}

#' @describeIn ocpu_api GET request (typically comes after POST)
#' @export
GET_OCPU <- function(url, ...){
  api <- "http://138.68.11.251"
  nurl <- paste0(api, "/", url, "/pb")
  ctype <- httr::content_type("application/x-protobuf")
  r <- httr::GET(nurl, ctype)
  return(protolite::unserialize_pb(httr::content(r, "raw")))
}

#' @describeIn ocpu_api tbd
#' @export
hpds_fn <- function(package="rauth", fn="check_auth", ...){
  url <- paste0("http://138.68.11.251", "/ocpu/user/ruser/library/", package, "/R/", fn, "/pb")
  r <- httr::GET(url, httr::content_type("application/protobuf"))
  httr::stop_for_status(r)
  FUN <- protolite::unserialize_pb(r$content)

  # set global environment for function
  rlang::fn_env(FUN) <- rlang::global_env()

  ## modify FUN or env if desired
  ## or execute call with '...' for convenience
  if(length(list(...)) > 0)
    return(pryr::do_call(FUN, list(...)))
  return(FUN)
}

#' @describeIn ocpu_api DigitalOcean API
#' @export
get_token <- function(pwd = NULL, tk_name){
  hpds_fn(package = "rauth", fn = "hpds_auth", pwd, tk_name)
}

#' A Reference Class that represents an R Script
#'
#' @field id A character id used by rstudio api to identify script
#' @field fpath The encrypted full file path. Is retrieved with \code{getPath}
#' @field contents The encrypted contents of the script. Is retrieved with \code{getScript}
#' @import methods
SCR <- setRefClass(
  Class = "script",
  fields = list(id = "character", fpath = "raw", contents = "raw"),
  methods = list(
    wrap = function(pubkey=NULL){
      'Get all script information and wrap contents'

      tmp <- rstudioapi::getSourceEditorContext()
      id <<- tmp$id
      fpath <<- hide(path.expand(tmp$path), pubkey)
      contents <<- hide(tmp$contents, pubkey)
    },
    getScript = function(privkey=NULL){
      'Unwrap (e.g. decrypt) script'

      unhide(contents, privkey)
    },
    getPath = function(privkey=NULL){
      'Unwrap (e.g. decrypt) script path'

      unhide(fpath, privkey)
    }
  )
)


# key <- keychain()
#
#
# script <- SCR$new()
# script$wrap(key$pubkey)
#
# script$getPath(key$privkey)
# script$getScript(key$privkey)



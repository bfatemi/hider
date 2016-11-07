options(devtools.name = "Bobby Fatemi")
Sys.setenv(GITHUB_PAT = "6c8caea9547f6e08917dde0e58c83e2241df7be7")

use_license <- function(pkg = ".", bPrivate=TRUE){

  pkg <- as.package(pkg)
  path <- file.path(pkg$path, "LICENSE")
  # message("* Updating license field in DESCRIPTION.")
  descPath <- file.path(pkg$path, "DESCRIPTION")
  DESCRIPTION <- read_dcf(descPath)
  DESCRIPTION$License <- "file LICENSE"
  write_dcf(descPath, DESCRIPTION)

  contents <- paste0("YEAR: ", format(Sys.Date(), "%Y"), "\n", "COPYRIGHT HOLDER: Bobby Fatemi")
  if(bPrivate)
    contents <- paste0("Proprietary\n\nDo not distribute outside of Intuitive Surgical Inc.\n\n", contents)

  writeLines(contents, path)
  return(TRUE)
}

write_dcf <- function(path, desc){
  desc <- unlist(desc)
  desc <- gsub("\n[ \t]*\n", "\n .\n ", desc, perl = TRUE,
               useBytes = TRUE)
  desc <- gsub("\n \\.([^\n])", "\n  .\\1", desc, perl = TRUE,
               useBytes = TRUE)
  starts_with_whitespace <- grepl("^\\s", desc, perl = TRUE,
                                  useBytes = TRUE)
  delimiters <- ifelse(starts_with_whitespace, ":", ": ")
  text <- paste0(names(desc), delimiters, desc, collapse = "\n")
  if ("Encoding" %in% names(desc)) {
    Encoding(text) <- desc[["Encoding"]]
  }
  if (substr(text, nchar(text), 1) != "\n") {
    text <- paste0(text, "\n")
  }
  cat(text, file = path)
}
read_dcf <- function(path){
  fields <- colnames(read.dcf(path))
  as.list(read.dcf(path, keep.white = fields)[1, ])
}

# library(devtools)
# library(roxygen2)
# library(testthat)
#
# devtools::use_readme_md()
# devtools::use_testthat()
# devtools::use_data_raw()
#
#
# dir.create("R/development")
# dir.create("R/old")
# dir.create("old")
# dir.create("inst")
# dir.create("inst/ext")
# dir.create("private")
#
# use_build_ignore("old", escape = TRUE)
# use_build_ignore("private", escape = TRUE)
#
# # Sys.setenv(GITHUB_PAT = "b5c0936889d465cda6ca9db6c271400956090ced")
# create_github(pkg = ".", private = TRUE, protocol = "https")
# use_github()







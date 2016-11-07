library(devtools)
library(roxygen2)
library(testthat)

devtools::use_readme_md()
devtools::use_testthat()
devtools::use_data_raw()


as.package(pkg)$package

dir.create("R/development")
dir.create("R/old")
dir.create("old")
dir.create("inst")
dir.create("inst/ext")
dir.create("private")

use_build_ignore("old", escape = TRUE)
use_build_ignore("private", escape = TRUE)

Sys.setenv(GITHUB_PAT = "6c8caea9547f6e08917dde0e58c83e2241df7be7")
use_github(pkg = ".", private = TRUE, protocol = "https")
use_github()







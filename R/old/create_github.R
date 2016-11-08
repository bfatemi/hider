# create_github <- function (private = FALSE, pkg = ".", host = "https://api.github.com", protocol = c("ssh", "https"), credentials = NULL){
#   auth_token <- "b5c0936889d465cda6ca9db6c271400956090ced"
#
#   protocol <- match.arg(protocol)
#   pkg <- as.package(pkg)
#   devtools::use_git(pkg = pkg)
#
#   # added this line to ignore private and old directories
#   use_git_ignore(c("private", "old"), pkg = pkg)
#
#
#   create <- github_POST("user/repos",
#                         pat = auth_token,
#                         body = list(name = jsonlite::unbox(pkg$package),
#                                     description = jsonlite::unbox(gsub("\n", " ", pkg$title)),
#                                     private = jsonlite::unbox(private)),
#                         host = host)
#
#   # message("* Adding GitHub remote")
#   r <- git2r::repository(pkg$path)
#   origin_url <- switch(protocol, https = create$clone_url,ssh = create$ssh_url)
#
#   git2r::remote_add(r, "origin", origin_url)
#   # message("* Adding GitHub links to DESCRIPTION")
#
#   use_github_links(pkg$path, auth_token = auth_token, host = host)
#
#   if (git_uncommitted(pkg$path)) {
#     git2r::add(r, "DESCRIPTION")
#     git2r::commit(r, "Add GitHub links to DESCRIPTION")
#   }
#   message("* Pushing to GitHub and setting remote tracking branch")
#   if (protocol == "ssh") {
#     git2r::push(r, "origin", "refs/heads/master", credentials = credentials)
#   }
#   else {
#     cred <- git2r::cred_user_pass("EMAIL", auth_token)
#     git2r::push(r, "origin", "refs/heads/master", credentials = cred)
#   }
#   git2r::branch_set_upstream(git2r::head(r), "origin/master")
#   message("* View repo at ", create$html_url)
#   invisible(NULL)
# }

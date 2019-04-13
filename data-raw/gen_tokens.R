library(sodium)
library(protolite)

pubkey <- readRDS("inst/keys/ext/pubkey")
# key_serv <- readRDS("/home/ruser/key/key_serv")


do_api <- "ae058a7e68c529d19e6f9258881f2e1a947e20322a8817fe60ee9cd53b4e04b4"
do_api_ciph <- simple_encrypt(serialize_pb(do_api), pubkey)
saveRDS(do_api_ciph, "inst/tokens/do_api_ciph")

gh_home <- "018ec6a3d3927f773a0d1b0adf516fa36b300929"
gh_home_ciph <- simple_encrypt(serialize_pb(gh_home), pubkey)
saveRDS(gh_home_ciph, "inst/tokens/gh_home_ciph")

gh_work <- "895032ca1c6d747e5c8800cdf98e35f129b667eb"
gh_work_ciph <- simple_encrypt(serialize_pb(gh_work), pubkey)
saveRDS(gh_home_ciph, "inst/tokens/gh_work_ciph")

trav <- "pYv3R1FRGogyEqfAKVfU"
trav_ciph <- simple_encrypt(serialize_pb(trav), pubkey)
saveRDS(trav_ciph, "inst/tokens/trav_ciph")




#' @importFrom jsonlite base64_enc
build_auth_header <- function (email=getOption("zendesk.email"),
                               token=getOption("zendesk.token"),
                               password=getOption("zendesk.password")) {
    if (is.null(email)) {
        halt('You must set `options(zendesk.email="you@example.com")`')
    }
    if (is.null(token)) {
        token <- password
        if (is.null(token)) {
            halt('You must set a zendesk.token or zendesk.password in options()')
        }
    } else {
        # Given token auth, append a "token" suffix to the email
        email <- paste0(email, "/token")
    }
    # Encode, and strip out newlines that base64_enc seems to add
    encoded <- gsub("\\n", "", base64_enc(paste(email, token, sep=":")))
    # TODO: support oauth bearer token
    return(paste("Basic", encoded))
}

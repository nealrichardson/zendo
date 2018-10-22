#' HTTP methods for the Zendesk API
#' @importFrom httr GET PUT PATCH POST DELETE
#' @export
zd_api <- function (verb, url, config=list(), ...) {
    FUN <- get(verb, envir=asNamespace("httr"))
    resp <- FUN(url, ..., config=c(zd_config(), config))
    return(zd_handle_response(resp))
}

#' @importFrom httr add_headers
zd_config <- function () {
    add_headers(
        Authorization=build_auth_header(),
        `user-agent`=ua("zendo")
    )
}

#' @importFrom httr http_status content
zd_handle_response <- function (resp) {
    status <- resp$status_code
    if (status == 429 && "retry-after" %in% tolower(names(resp$headers))) {
        wait <- get_header("Retry-After", resp$headers)
        message("We've been rate limited. Retrying. Please stand by...")
        Sys.sleep(as.numeric(wait))
        return(zd_api(resp$request$method, resp$url))
    } else if (status >= 400L)  {
        msg <- http_status(resp)$message
        # If the API returns a useful error message in the content(), you can
        # append it to `msg`
        try(print(content(resp))) # Just so we can see if there is any
        # TODO: see if API documents how error messages are returned
        # $error
        # [1] "ParameterMissing"
        #
        # $description
        # [1] "Parameter start_time is required"
        stop(msg, call.=FALSE)
    } else {
        return(content(resp))
    }
}

get_header <- function(x, headers, default=NULL) {
    m <- tolower(names(headers)) == tolower(x)
    if (any(m)) {
        return(headers[[which(m)[1]]])
    } else {
        return(default)
    }
}

#' @export
zd_url <- function (...) {
    base <- getOption(
        "zendesk.url",
        stop('You must set `options(zendesk.url="https://yoursitename.zendesk.com")`',
            call.=FALSE)
    )
    paste(base, "api/v2", ..., sep="/")
}

#' @importFrom utils packageVersion
ua <- function (pkg) paste(pkg, as.character(packageVersion(pkg)), sep="/")

#' @rdname zd_api
#' @export
zd_GET <- function (url, ...) zd_api("GET", url, ...)

#' @rdname zd_api
#' @export
zd_PUT <- function (url, ...) zd_api("PUT", url, ...)

#' @rdname zd_api
#' @export
zd_PATCH <- function (url, ...) zd_api("PATCH", url, ...)

#' @rdname zd_api
#' @export
zd_POST <- function (url, ...) zd_api("POST", url, ...)

#' @rdname zd_api
#' @export
zd_DELETE <- function (url, ...) zd_api("DELETE", url, ...)

zd_GET_paginated <- function (url, query=NULL, ..., value=NULL) {
    # TODO: query=NULL overrides any query already in url
    resp <- zd_GET(url, query=query, ...)
    if (is.null(value)) {
        # Guess the name of the attribute we're accumulating
        data_attr <- vapply(resp, is.list, logical(1))
        if (sum(data_attr) == 1) {
            value <- names(resp)[data_attr]
        } else {
            stop("Please specify 'value' field to collect across pagination",
                call.=FALSE)
        }
    }
    out <- resp[[value]]
    url <- resp$next_page
    while (!is.null(url)) {
        # Note that query is not passed through. The next page URL generally
        # has a query param in it. We just want to follow the paging it tells us
        resp <- zd_GET(url, ...)
        out <- c(out, resp[[value]])
        if (identical(url, resp$next_page)) {
            # The "incremental export" paginates by timestamp. When you've hit
            # the last page, the next_page URL is the same as the current page
            resp$next_page <- NULL
        }
        url <- resp$next_page
    }
    return(out)
}

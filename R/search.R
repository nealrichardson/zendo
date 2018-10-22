#' Search your Zendesk site
#'
#' `zd_search()` is a general search function. `search_tickets()` restricts
#' the query to just tickets.
#'
#' @param query character search string, as you'd type in the web app
#' @return A list of search results.
#' @export
zd_search <- function (query) {
    zd_GET_paginated(zd_url("search.json"), query=list(query=query))
}

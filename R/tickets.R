#' Download tickets
#' 
#' adf
#' 
#' This function uses the "incremental export" API
#' (\url{https://developer.zendesk.com/rest_api/docs/core/incremental_export#incremental-ticket-export})
#' because the official "tickets" API omits archived tickets, which may be of
#' interest. 
#'
#' @param start_time A timestamp (length 1), which may be
#' * A date format (`POSIXct`, `POSIXlt`, or `Date`)
#' * An ISO-8601-formatted string
#' * An integer Unix-time representation (number of seconds since 1970-01-01)
#' This limits query results to tickets modified after that time. Default is 
#' `0`, meaning return all.
#' @return A list of tickets.
#' @export
#' @seealso [search_tickets()] if you want to filter by something other than
#' timestamp.
get_all_tickets <- function (start_time=0) {
    # TODO: be more liberal with accepting time and conver to Unix time
    zd_GET_paginated(
        zd_url("incremental/tickets.json"),
        query=list(start_time=to_unixtime(start_time))
    )
}

#' @rdname zd_search
#' @export
search_tickets <- function (query) {
    zd_search(paste("type:ticket", query))
}

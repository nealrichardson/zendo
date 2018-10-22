#' Download tickets
#'
#' @param start_time An integer Unix-time representation. This limits query
#' results to tickets modified after that time. Default is `0`, meaning return
#' all.
#' @return A list of tickets.
#' @export
#' @seealso This uses the "incremental export" API (\url{https://developer.zendesk.com/rest_api/docs/core/incremental_export#incremental-ticket-export}).
get_all_tickets <- function (start_time=0) {
    zd_GET_paginated(
        zd_url("incremental/tickets.json"),
        query=list(start_time=start_time)
    )
}

#' @rdname zd_search
#' @export
search_tickets <- function (query) {
    zd_search(paste("type:ticket", query))
}

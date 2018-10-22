#' Get all Zendesk users
#'
#' @return A list of users
#' @export
#' @seealso \url{https://developer.zendesk.com/rest_api/docs/core/users}
get_users <- function () {
    zd_GET_paginated(zd_url("users.json"))
}

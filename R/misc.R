halt <- function (...) stop(..., call.=FALSE)

to_unixtime <- function (x) {
    orig <- x
    if (is.character(x)) {
        x <- from8601(x)
    }
    if (inherits(x, c("POSIXt", "Date"))) {
        x <- as.POSIXct(x)
    }
    x <- as.integer(x)
    if (is.na(x)) {
        halt(deparse(orig), " is not a valid timestamp. ",
            "Timestamps must be integers or ISO-8601 strings.")
    }
    return(x)
}

from_unixtime <- function (x) {
    as.POSIXct(x, origin="1970-01-01")
}

# Borrowed/modified from `crunch`
# If this is a big deal, use the parsedate package
#' @importFrom stats na.omit
from8601 <- function (x) {
    # Parse ISO-8601-formatted date strings and return POSIXlt
    if (all(grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", na.omit(x)))) {
        pattern <- "%Y-%m-%d"
    } else if (any(grepl("+", x, fixed = TRUE))) {
        # Strip out a : from the timezone offset, if present
        x <- sub("^(.*[+-][0-9]{2}):([0-9]{2})$", "\\1\\2", x)
        pattern <- "%Y-%m-%dT%H:%M:%OS%z"
    } else {
        pattern <- "%Y-%m-%dT%H:%M:%OS"
    }
    return(strptime(x, pattern, tz = "UTC"))
}

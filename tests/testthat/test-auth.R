context("Authentication helpers")

withr::with_options(
    # Ensure that there are no credentials set globally
    list(
        zendesk.email=NULL,
        zendesk.password=NULL,
        zendesk.token=NULL,
        zendesk.url=NULL
    ), {
    test_that("build_auth_header errors usefully if settings aren't set", {
        expect_error(build_auth_header(),
            'You must set `options(zendesk.email="you@example.com")`',
            fixed=TRUE
        )
        expect_error(build_auth_header("u@example.org"),
            'You must set a zendesk.token or zendesk.password in options()',
            fixed=TRUE
        )
    })

    test_that("build_auth_header encodes correctly", {
        decode <- function (x) {
            rawToChar(jsonlite::base64_dec(substr(x, 7, nchar(x))))
        }
        expect_true(startsWith(build_auth_header("u@example.org", "asdf"),
            "Basic "))
        expect_identical(decode(build_auth_header("u@example.org", "asdf")),
            "u@example.org/token:asdf")
        expect_identical(decode(build_auth_header("u@example.org", password="asdf")),
            "u@example.org:asdf")
    })
})

with_mock_api({
    test_that("The auth header is included in requests", {
        u <- "https://example.zendesk.com/api/v2/incremental/tickets.json?start_time=1405469030"
        expect_header(zd_GET(u), "Authorization: Basic ")
    })
})

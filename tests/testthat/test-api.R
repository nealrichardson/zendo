context("API wrappers")

withr::with_options(
    # Ensure that there are no credentials set globally
    list(
        zendesk.email=NULL,
        zendesk.password=NULL,
        zendesk.token=NULL,
        zendesk.url=NULL
    ), {
    test_that("We error usefully if no URL is set", {
        expect_error(zd_url("tickets.json"),
            'You must set `options(zendesk.url="https://yoursitename.zendesk.com")`',
            fixed=TRUE
        )
    })
})

# TODO:
# * rate limiting
# * error message handling

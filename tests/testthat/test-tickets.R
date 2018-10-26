context("Tickets")

with_mock_api({
    test_that("get_all_tickets via the incremental export API", {
        tix <- get_all_tickets()
        expect_length(tix, 3)
    })
})

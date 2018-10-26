context("Miscellany")

test_that("to_unixtime handles inputs", {
    expect_identical(to_unixtime(1), 1L)
    expect_identical(to_unixtime("1970-01-01"), 0L)
    expect_identical(to_unixtime("1970-01-02"), 60L*60L*24L)
    expect_identical(to_unixtime(as.Date("1970-01-02")), 60L*60L*24L)
    expect_identical(to_unixtime("1970-01-01T12:00:01"), 60L*60L*12L + 1L)
    expect_identical(to_unixtime("1970-01-01T12:00:01+0100"), 60L*60L*11L + 1L)
    expect_identical(to_unixtime("1970-01-01T12:00:01+01:00"), 60L*60L*11L + 1L)
    expect_error(to_unixtime("no time"),
        '"no time" is not a valid timestamp. Timestamps must be integers or ISO-8601 strings.')
})

test_that("from_unixtime", {
    t1 <- 60L*60L*11L + 1L
    expect_identical(to_unixtime(from_unixtime(t1)), t1)
})

# zendo: An R client for the [Zendesk](https://zendesk.com/) [API](https://developer.zendesk.com/rest_api/docs/core/introduction)

[![Build Status](https://travis-ci.org/nealrichardson/zendo.png?branch=master)](https://travis-ci.org/nealrichardson/zendo) [![Build status](https://ci.appveyor.com/api/projects/status/tnkfvuqyucxypfeg/branch/master?svg=true)](https://ci.appveyor.com/project/nealrichardson/zendo/branch/master)
 [![codecov](https://codecov.io/gh/nealrichardson/zendo/branch/master/graph/badge.svg)](https://codecov.io/gh/nealrichardson/zendo)
[![cran](https://www.r-pkg.org/badges/version-last-release/zendo)](https://cran.r-project.org/package=zendo)

## Installing

<!-- If you're putting `zendo` on CRAN, it can be installed with

    install.packages("zendo") -->

The pre-release version of the package can be pulled from GitHub using the [remotes](https://github.com/r-lib/remotes) package:

```r
# install.packages("remotes")
remotes::install_github("nealrichardson/zendo")
```

## Getting started

1. Set credentials:

```r
options(
    zendesk.email,
    zendesk.token, # Or, zendesk.password
    zendesk.url
)
```

2. Query

* `get_all_tickets(start_time)` downloads all tickets since a given time (if omitted, returns all)
* `search_tickets(query)` searches for tickets
* `get_users()`

## For developers

The repository includes a Makefile to facilitate some common tasks, if you're into that kind of thing.

### Running tests

`$ make test`. Requires the [testthat](http://testthat.r-lib.org/) package. You can also specify a specific test file or files to run by adding a "file=" argument, like `$ make test file=api`. `testthat::test_package()` will do a regular-expression pattern match within the file names (ignoring the `test-` prefix and the `.R` file extension).

### Updating documentation

`$ make doc`. Requires the [roxygen2](https://github.com/klutometis/roxygen) package.

## See also

[zendeskR](https://github.com/tcash21/zendeskR) is another Zendesk API client in R. It's not clear that it is actively supported anymore, and it's last CRAN update was in 2014. There is some overlap between what is implemented here and there. `zendo` offers support for the incremental export and search APIs, as well as token authentication.

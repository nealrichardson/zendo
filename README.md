# zendo: An R client for the [Zendesk](https://zendesk.com/) [API](https://developer.zendesk.com/rest_api/docs/core/introduction)

[![Build Status](https://travis-ci.org/nealrichardson/zendo.png?branch=master)](https://travis-ci.org/nealrichardson/zendo)  [![codecov](https://codecov.io/gh/nealrichardson/zendo/branch/master/graph/badge.svg)](https://codecov.io/gh/nealrichardson/zendo)
[![cran](https://www.r-pkg.org/badges/version-last-release/zendo)](https://cran.r-project.org/package=zendo)

## How to finish setting up your new package

Now that you've got a working package skeleton, there are a few steps to finish setting up all the integrations:

### 1. Git(Hub)

Go to https://github.com/nealrichardson and create a new repository. Then, in the directory where this package is, create your git repository from the command line, add the files, and push it to GitHub:

    git init
    git add --all
    git commit -m "Initial commit of package skeleton"
    git remote add origin git@github.com:nealrichardson/zendo.git
    git push -u origin master

### 2. Travis

Now you can go to [Travis](https://travis-ci.org/profile/nealrichardson) and turn on continuous integration for your new package. You may need to click the "Sync account" button to get your new package to show up in the list.

If you have a codecov.io account, running your tests on Travis will trigger the code coverage job. No additional configuration is necessary

### 3. Appveyor

Go to [Appveyor's new project page](https://ci.appveyor.com/projects/new) and select your new repository from the list. Then you can go to the [badges](https://ci.appveyor.com/project/nealrichardson/zendo/settings/badges) page, copy the markdown code it provides, and paste it up with the other badges above. (Their badge API has a random token in it, so `skeletor` can't include it in the template for you.)

### 4. Delete this "How to finish setting up your new package" section from your README.md

## Installing

<!-- If you're putting `zendo` on CRAN, it can be installed with

    install.packages("zendo") -->

The pre-release version of the package can be pulled from GitHub using the [devtools](https://github.com/r-lib/devtools) package:

    # install.packages("devtools")
    devtools::install_github("nealrichardson/zendo")

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

[zendeskR](https://github.com/tcash21/zendeskR) is another Zendesk API client in R. It's not clear that it is actively supported anymore, and it's last CRAN update was in 2014. There is some overlap between what is implemented here and there. `zendo` offers support for the incremental export and search APIs.

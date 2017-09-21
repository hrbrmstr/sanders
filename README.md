
sanders
=======

Web-scraping and Web-crawling Content Parsing, Validation and Sanitization Helpers

Description
-----------

When researchers crawl/scrape the web for content they are talking to strange computers running software created by a diverse array of humans. Content -- even content that is supposed to adhere to internet stadards -- can have very rough edges that need to be smoothed out to be useful and potentially less harmful to the systems running the scraping and analysis code. Methods are provided that sand off the rough edges of many different types of scraped content and metadata.

The following functions are implemented:

-   `normalize_media_types`: Sand the rough edges off of bare, scraped media (MIME) types into a smooth data frame

Installation
------------

``` r
devtools::install_github("hrbrmstr/sanders")
```

Usage
-----

``` r
library(sanders)

# current verison
packageVersion("sanders")
```

    ## [1] '0.1.0'

``` r
content_type <- c("text/html; charset=utf-8", "text/css",
                  "text/javascript; charset=UTF-8", "text/javascript",
                  "application/x-javascript", "text/plain; charset=utf-8")

x <- normalize_media_types(content_type)

x
```

    ## # A tibble: 6 x 3
    ##          type      subtype     params
    ##         <chr>        <chr>     <list>
    ## 1        text         html <list [1]>
    ## 2        text          css <list [0]>
    ## 3        text   javascript <list [1]>
    ## 4        text   javascript <list [0]>
    ## 5 application x-javascript <list [0]>
    ## 6        text        plain <list [1]>

``` r
x$params
```

    ## [[1]]
    ## [[1]][[1]]
    ## # A tibble: 1 x 2
    ##       key value
    ##     <chr> <chr>
    ## 1 charset utf-8
    ## 
    ## 
    ## [[2]]
    ## list()
    ## 
    ## [[3]]
    ## [[3]][[1]]
    ## # A tibble: 1 x 2
    ##       key value
    ##     <chr> <chr>
    ## 1 charset utf-8
    ## 
    ## 
    ## [[4]]
    ## list()
    ## 
    ## [[5]]
    ## list()
    ## 
    ## [[6]]
    ## [[6]][[1]]
    ## # A tibble: 1 x 2
    ##       key value
    ##     <chr> <chr>
    ## 1 charset utf-8

Test Results
------------

``` r
library(sanders)
library(testthat)

date()
```

    ## [1] "Thu Sep 21 18:50:27 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================

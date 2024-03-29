---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# demes

<!-- badges: start -->
<!-- badges: end -->

_demes_ is an R library for parsing and validation of population genetic models
in the [Demes](https://academic.oup.com/genetics/article/222/3/iyac131/6730747)
file format, making such models easy to inspect in R and leverage them for
simulation of genomic data using downstream software according to their
preferences.

In a sense, the _demes_ package is intended as an R equivalent of the official
[Python module](https://popsim-consortium.github.io/demes-docs/latest/index.html).
Its output is a "low-level" representation of a model encoded in a Demes YAML
file that is an entirely unambiguous and portable and can be used by many different
simulation frameworks as input. Thus, we can see part of the role of this package
as *compiling* the high-level description of a model into the corresponding
"low-level" description at a level of standard R data structures.

A proof-of-concept implementation of _Demes_ for simulation using the
[_slendr_](https://github.com/bodkan/slendr/) R package is in progress.

This package is being developed by @IsabelMarleen as part of her Master's student
project in the [Racimo group](https://www.racimolab.net) at the Globe Institute
at the University of Copenhagen. If you have feature requests or other comments, please open an issue.

## Installation

You can install the development version of demes from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("RacimoLab/demes-r")
```

<!--
## Example

This is a basic example which shows you how to solve a common problem:


```r
# library(demes)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so:


```r
# summary(cars)
```

You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:



In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN.
-->

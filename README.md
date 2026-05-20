# roben

> **Ro**bust **B**ayesian Variable Selection for Gene-**en**vironment
> Interactions

<!-- badges: start -->
<!-- [![CRAN](https://www.r-pkg.org/badges/version/spinBayes)](https://cran.r-project.org/package=spinBayes) -->
<!-- [![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/spinBayes)](http://www.r-pkg.org/pkg/spinBayes) -->

[![CRAN
status](https://www.r-pkg.org/badges/version/roben)](https://CRAN.R-project.org/package=roben)
[![Codecov test
coverage](https://codecov.io/gh/jrenstat/roben/branch/master/graph/badge.svg)](https://app.codecov.io/gh/jrenstat/roben?branch=master)
[![R-CMD-check](https://github.com/jrenstat/roben/actions/workflows/R-CMD-check.yaml/badge.svg?branch=master)](https://github.com/jrenstat/roben/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Gene-environment (G×E) interactions have important implications to
elucidate the etiology of complex diseases beyond the main genetic and
environmental effects. Outliers and data contamination in disease
phenotypes of G×E studies have been commonly encountered, leading to the
development of a broad spectrum of robust penalization methods.
Nevertheless, within the Bayesian framework, the issue has not been
taken care of in existing studies. We develop a robust Bayesian variable
selection method for G×E interaction studies. The proposed Bayesian
method can effectively accommodate heavy–tailed errors and outliers in
the response variable while conducting variable selection by accounting
for structural sparsity. In particular, the spike–and–slab priors have
been imposed on both individual and group levels to identify important
main and interaction effects. An efficient Gibbs sampler has been
developed to facilitate fast computation. The Markov chain Monte Carlo
algorithms of the proposed and alternative methods are efficiently
implemented in C++.

## How to install

- To install from github, run these two lines of code in R

<!-- -->

    install.packages("remotes")
    remotes::install_github("jrenstat/roben")

- Released versions of roben are available on CRAN
  [(link)](https://cran.r-project.org/package=roben), and can be
  installed within R via

<!-- -->

    install.packages("roben")

## Examples

#### Example.1 (default method: robust sparse group selection)

    library(roben)
    data(GxE_small)

    iter = 5000
    fit=roben(X, Y, E, clin, iterations = iter)
    fit$coefficient

    ## True values of parameters of main G effects and interactions
    coeff$GE

    ## Compute TP and FP
    sel = GxESelection(fit)
    pos = which(sel$indicator != 0)
    tp = length(intersect(which(coeff$GE != 0), pos))
    fp = length(pos) - tp
    list(tp=tp, fp=fp)

#### Example.2 (alternative: non-robust sparse group selection)

    fit=roben(X, Y, E, clin, iterations = iter, robust=FALSE)
    sel = GxESelection(fit)
    pos = which(sel$indicator != 0)
    tp = length(intersect(which(coeff$GE != 0), pos))
    fp = length(pos) - tp
    list(tp=tp, fp=fp)

## Methods

This package provides implementation for methods proposed in

- Ren J., Zhou F., Li X., Ma S., Jiang Y., Wu C. (2023) Robust Bayesian
  variable selection for gene–environment interactions. Biometrics, 79,
  684–694. doi:
  [10.1111/biom.13670](https://doi.org/10.1111/biom.13670). PMID:
  35394058 PMCID: PMC11086965.

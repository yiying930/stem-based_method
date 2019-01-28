# Stem-based method to correct publication bias
This repository contains the `R` code to implement the [stem-based method](https://economics.mit.edu/files/12424) to correct publication bias in meta-analyses.

## Introduction
Stem-based method provides a meta-analysis estimate that is robust under various assumptions of publication selection processes and underlying distribution of true effects. The method is non-parametric and fully data-dependent, and the resulting estimates are generally more conservative than other commonly used methods. The method offers a formal criterion to choose the optimal number of most precise studies to compute the meta-analysis estimate.

This repository contains the following:
* code and data
  * stem
  * sample_data
* figures

## Description
The major advantage of stem-based method over other methods is its robustness under various publication selection processes.
Most commonly used bias correction methods make specific assumptions on the publication selection processes. The maximum-likelihood estimation method first proposed by Hedges (1992) assumes that any statistically insignificant results are uniformly less likely to be published than significant results. The trim-and-fill method proposed by Duval and Tweedie (2000) assumes that results with extremely negative results will be unpublished. Yet the model of communication among researchers with aggregation frictions (Furukawa 2019) suggests that imprecise null results are unlikely to be published so that publication selection process will depend on both p-values and estimates in a non-parsimonious way.

![Figure 1](https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_vertical0.png)

What could meta-analysts do to provide a meta-analysis estimate that builds consensus among contradictory findings, when the bias correction methods themselves mutually contradict with one another?


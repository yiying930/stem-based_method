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


The stem-based method focuses on **n** most precise studies to provide a meta-analysis estimates because the models commonly suggest that the precise studies suffer less from publication selection. Heuristically, more precise studies are more reliable so that there is less reason not to publish the studies. Graphically, the following figure depicts the mean of coefficients conditional on precision levels across publication selection processes discussed above, showing that the precise studies have less publication bias.


![Figure 2](https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_vertical1.png)

**Estimation:** the stem-based method chooses the optimal **n** most precise studies to include by minimizing the Mean Squared Error (MSE) of the estimates. <p align="center">
  <a href="https://www.codecogs.com/eqnedit.php?latex=\min_{n}&space;MSE(n)&space;=&space;Bias^2(n)&space;&plus;&space;Var(n)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\min_{n}&space;MSE(n)&space;=&space;Bias^2(n)&space;&plus;&space;Var(n)" title="\min_{n} MSE(n) = Bias^2(n) + Var(n)" /></a>
</p>

On the one hand, as n increases, the bias squared increases since estimates with precisions of more bias will be included; on the other hand, as n increases, the variance decreases since more studies will be included in the sample. [Section 4.2](https://economics.mit.edu/files/12424) of the paper describes the algorithm to implement this trade-off.

**Simulation:**  the stem based method's estimates have a more adequate coverage probability than other methods. In a simulation study in [Section 4.3](https://economics.mit.edu/files/12424), the coverage probability could be around 13% or 43% when existing methods are applied to the data with selection process assumed in other methods. In contrast, the stem-based method has the coverage probability of around 76% across various selection processes. While the estimates' confidence intervals are roughly 1.5 ~ 2 times larger, their mis-specification problem is less severe than other methods.

## Installation
Open `R` or `RStudio` and download the code from [code and data](https://github.com/Chishio318/stem-based_method/tree/master/code%20and%20data) repository and save in your working directory. Install stem-based method by running the command:
```
read(stem)
```

## Example
The following example illustrates the use of stem-based method, along with `simulated_data` in [code and data](https://github.com/Chishio318/stem-based_method/tree/master/code%20and%20data) repository.
```
stem_results = stem (simulated_data$coefficient, simulated_data$standard_error)
```

```
stem_funnel (simulated_data, stem_results$estimates)
```
![Figure 3](https://github.com/Chishio318/stem-based_method/blob/master/figures/stem_funnel.png)

```
stem_MSE (stem_results$MSE)
```
![Figure 4](https://github.com/Chishio318/stem-based_method/blob/master/figures/MSE_tradeoff.png)

## Technical Description



## Additional Notes
![Figure 4](https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_photo.png)

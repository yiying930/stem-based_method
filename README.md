# Stem-based method to correct publication bias
This repository contains the `R` code to implement the [stem-based method](https://economics.mit.edu/files/12424) to correct publication bias in meta-analyses.

## Introduction
Stem-based method provides a meta-analysis estimate that alleviates publication bias in a way robust under various assumptions of publication selection processes and underlying distribution of true effects. The method is non-parametric and fully data-dependent, and the resulting estimates are generally more conservative than other commonly used methods. The method offers a formal criterion to choose the optimal number of most precise studies to compute the meta-analysis estimate.

This repository contains the following:
* code and data
  * stem_method.R
  * simulated_data.csv
  * laborunion_data.csv
* figures

## Description
The major advantage of stem-based method over other most popular methods is its robustness under various publication selection processes.
Most commonly used bias correction methods make specific assumptions on the publication selection processes. The maximum-likelihood estimation method first proposed by [Hedges (1992)](https://www.jstor.org/stable/2246311?seq=1#metadata_info_tab_contents) assumes that publication probability will depend on statistical significance. The trim-and-fill method proposed by [Duval and Tweedie (2000)](https://www.ncbi.nlm.nih.gov/pubmed/10877304) assumes that results with extremely negative results will be unpublished. Yet a game-theoretic model of communication among researchers with aggregation frictions ([Furukawa 2019](https://economics.mit.edu/files/12424)) suggests that imprecise null results are unlikely to be published so that publication selection process will depend on both p-values and estimates in a non-parsimonious way.

![Figure 1](https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_vertical0.png)
> This figure illustrates the three publication selection processes discussed above in funnel plots. 
The x-axis is the study estimate, and the y-axis is the study precision (standard errors with negative signs). 
Each dot represents one study's main estimate. Each model suggests that the omission occurs 
in the shaded regions.

What could meta-analysts do to provide a meta-analysis estimate that builds a consensus by accounting for publication bias while the existing bias correction methods make assumptions that mutually contradict with one another?


The stem-based method focuses on **n** most precise studies to provide a meta-analysis estimates because the models commonly suggest that the precise studies suffer less from publication selection. Heuristically, more precise studies are more reliable so that there is less reason not to publish the studies. Graphically, the following figure shows that the precise studies have less publication bias by depicting the mean of coefficients conditional on precision levels across publication selection processes discussed above. This method extends "top10" estimator that uses the most precise 10% of studies, as proposed in [Stanley et al. 2010](https://www.tandfonline.com/doi/abs/10.1198/tast.2009.08205), by providing a formal method to choose the optimal number of studies to include.


![Figure 2](https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_vertical1.png)
> The orange lines in the funnel plots describe the mean of coefficients at each precision levels.

**Estimation:** the stem-based method chooses the optimal **n** most precise studies to include by minimizing the Mean Squared Error (MSE) of the estimates. <p align="center">
  <a href="https://www.codecogs.com/eqnedit.php?latex=\min_{n}&space;MSE(n)&space;=&space;Bias^2(n)&space;&plus;&space;Var(n)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\min_{n}&space;MSE(n)&space;=&space;Bias^2(n)&space;&plus;&space;Var(n)" title="\min_{n} MSE(n) = Bias^2(n) + Var(n)" /></a>
</p>

On the one hand, as n increases, the bias squared increases since estimates with precisions of more bias will be included; on the other hand, as n increases, the variance decreases since more studies will be included in the sample. [Section 4.2](https://economics.mit.edu/files/12424) of the paper describes the algorithm to implement this trade-off by applying non-parametric methods to estimate the empirical analogue of bias squared term.

**Simulation:**  the stem based method's estimates have a more adequate coverage probability than other methods. In a simulation study in [Section 4.3](https://economics.mit.edu/files/12424), the coverage probability could be around 13% or 43% when existing methods are applied to the data with selection process assumed in other methods. In contrast, the stem-based method has the coverage probability of around 76% across various selection processes. While the estimates' confidence intervals are roughly 1.5 ~ 2 times larger, their mis-specification problem is less severe than other methods.

## Installation
Open `RStudio` and download the code from [code and data](https://github.com/Chishio318/stem-based_method/tree/master/code%20and%20data) repository and save in your working directory. Install stem-based method by running the command:
```
source("stem_method.R")
```

## Example
The following example illustrates the use of stem-based method with `simulated_data.csv` in [code and data](https://github.com/Chishio318/stem-based_method/tree/master/code%20and%20data) repository. This data is simulated for an illustrative purpose, as described in [Section 4.3.1](https://economics.mit.edu/files/12424), and generated under the assumption that the selection is based on p-values. To read the data, run:
```
eg_data = read.csv("simulated_data.csv")
```
To run the stem-based method on this data, type:
```
stem_results = stem (eg_data$coefficient, eg_data$standard_error, param)
```
Here, `param` corresponds to some parameters used in estimation, as discussed in Technical Description below. The output wil be:
```
View(stem_results$estimates)

      estimate         se sd of total heterogeneity n_stem n_iteration multiple % info used
[1,] 0.4222988 0.07565684                 0.2638446     17           2        0   0.4426252
```
In this example, the mean of true effect is estimated to be 0.42 with standard error .075. The standard deviation of distribution of true effect is estimated to be 0.26, as the model assumes "random effects" model. (so far the code only has random effects option.) The estimation of the mean has used the most precise 17 studies. The computation has taken 2 iterations in the outer algorithm to compute the standard deviation of distribution of true effect, and this process did not have "multiplicity" discussed in [Section 4.2.1.II](https://economics.mit.edu/files/12424). As a reference, this estimation of the mean has used "44% of the total information" contained in the data.

To visualize the stem-based method in a funnel plot, run:
```
stem_funnel (eg_data$coefficient, eg_data$standard_error, stem_results$estimates)
```
![Figure 3](https://github.com/Chishio318/stem-based_method/blob/master/figures/stem_funnel.png)
> The orange diamond is the stem-based bias corrected estimate of mean of true effects, with the line indicating the 95 confidence interval (the estimate is statistically significant at conventional level). The connected gray line illustrates how inclusion of less precise studies change the estimate, describing how more studies lead to larger bias. The diamond in the middle indicates the minimum precision level that all included studies satisfy.

An appropriate scale of the precision measures will depend on the distribution of standard errors in the data set. An appropriate position of the legend will also depend on the distribution of estimates. It is possible to modify them in the `R` code by changing resppective specifications.

<!---
To visualize the bias-variance trade-off to minimize the Mean Squared Error (MSE), run:
```
stem_MSE (stem_results$MSE)
```
![Figure 4](https://github.com/Chishio318/stem-based_method/blob/master/figures/MSE_tradeoff.png)
> Bias^2 - b_0^2 describes the relevant component of bias squared term in the MSE formula above. Variance is the total variance, and MSE - b_0^2 describes the relevant component of MSE.
This figure illustrates how the stem-based method chooses the optimal number of studies to include by minimizing the relevant component of MSE. As the theory suggests, as more studies are included in the sample, bias squared increases whereas variance decreases. Consequently, it is optimal to include some intermediate number of studies (here, n=17) for meta-analysis estimation.
--->

## Technical Description

- **`param`:** The estimation of standard deviation (sd) of underlying true effect involves an iterative computation until convergence. The default tolerance level is set to be 10^(-4) for one step of adjustment, and the default maximum number of iteration is set to be 10^3. It is possible to modify them in the `R` code.
- **minimum number of studies = 3:**
  The dataset must contain at least 3 studies for the estimation to give any estimates. This is because computation of MSE uses (i) most precise study to be used as a testing set in the Cross Validation process, and (ii) studies other than the most precise study must contain more than two studies to produce unbiased estimate of b_0^2.
- **a caveat:**
The assumption of this method is that the most precise study reasonably approximates the true mean on average. To ensure that the most precise study is reliable, it is encouraged to pay extra attention to quality of the study with the smallest standard error.

## Additional Support
The code also contains a function `data_median()` that selects the study with median coefficient when each study contains multiple estimates (when the number of studies is even, the code computes the median value by the canned median function in `R` and chooses the estimate closest to the value.) This occurs often in economics meta-analysis data set, including the labor union data set used in the empirical test in [Section 3.3](https://economics.mit.edu/files/12424). While it may be fine to include multiple estimates per study, shoosing the estimate with median magnitude is one common way to produce a meta-analysis estimate, as done in [Havránek (2015)](https://academic.oup.com/jeea/article-abstract/13/6/1180/2319801).

The function `data_median(data, "x1", "x2", "x3")` takes an argument of the `data` with multiple estimates within the study ID `"x1"`, and coefficient `"x2"` and standard error `"x3"`. For example, in the labor union data contained in the [code and data](https://github.com/Chishio318/stem-based_method/tree/master/code%20and%20data) repository, run:

```
original_data <- read.csv("laborunion_data.csv")
median_data <- data_median(original_data, "studyno", "partialr", "se")
stem_results <- stem(median_data$coefficient, median_data$standard_error, param)
```
## Final Remark
The name "stem-based" method is derived from how the most precise studies in meta-analyses corresponds to the "stem" of the "funnel" plot!

<p align="center"> 
<img src="https://github.com/Chishio318/stem-based_method/blob/master/figures/funnel_photo.png">
</p>

## Acknowledgement
I thank Amy Kim for her Research Assistance to translate the `MATLAB` code to implement the stem-based method into the `R` code. I also thank Chris Doucouliagos for sharing and allowing me to post the example data. I thank Anna Mikusheva and Tom Havranek for their advice.

## Contact
Please feel free to contact me at cfurukawa@mit.edu to ask any related questions.

## References
- Duval, Sue, and Richard Tweedie. 2000. “Trim and Fill: A Simple Funnel-Plot–based Method of Testing and Adjusting for Publication Bias in Meta-Analysis.” Biometrics 56 (2)
- Furukawa, Chishio. 2019. "Publication Bias under Aggregation Frictions: Theory, Evidence, and a New Correction Method" MIT Working Paper.
- Havránek, Tomáš. 2015. “Measuring Intertemporal Substitution: The Importance of Method Choices and Selective Reporting.” Journal of the European Economic Association 13 (6): 1180–1204.
- Hedges, Larry V. 1992. “Modeling Publication Selection Effects in Meta-Analysis.” Statistical Science, 246–255. 
- Stanley, T. D., Stephen B. Jarrell, and Hristos Doucouliagos. 2010. “Could It Be Better to Discard 90% of the Data? A Statistical Paradox.” The American Statistician 64 (1): 70–77. 

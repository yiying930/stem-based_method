install.packages("rsample")
library("rsample")

set.seed(1000)
bootstrap_number <- 100
median_resamples <- rsample::bootstraps(median_dataset_final, times = bootstrap_number)

combined_data <- map_df(median_resamples$splits, ~as.data.frame(.x), .id = "bootstrap")

new_generate <- combined_data %>%
  mutate(new_beta = rnorm(1, mean = median, sd = se))

bootstrap_data <- new_generate %>%
  group_by(bootstrap) %>%
  summarise(
    beta_bootstrap = sum(new_beta/se^2)/sum(1/se^2),
    SE_bootstrap = 1/sqrt(sum(1/se^2))
    ) %>%
  mutate(bootstrap = as.numeric(bootstrap)) %>%
  arrange(bootstrap)


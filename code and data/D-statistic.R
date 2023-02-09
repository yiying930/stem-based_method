set.seed(1000)
bootstrap_number <-100
rnorm_number<- 10000

median_original_sample <- rnorm(rnorm_number,mean=0.9943538,sd = 0.0009221)

median_resample_list <-
  mapply(rnorm,
         mean=bootstrap_data$beta_bootstrap,
         sd = bootstrap_data$SE_bootstrap,
         MoreArgs = list(n=rnorm_number))

median_resample_data <-
  data.frame(median_resample_list)
colnames(median_resample_data) <-as.numeric(1:bootstrap_number)
 # paste0("bootstrap_",1:bootstrap_number)


for(j in 1:bootstrap_number){  
  print(ks.test(median_original_sample, median_resample_data[[j]]))
}

dks <-  data.frame(
    bootstrap=numeric(bootstrap_number),
    D=numeric(bootstrap_number), 
    p=numeric(bootstrap_number), 
    stringsAsFactors=F)
for(j in 1:bootstrap_number){  
  k <- ks.test(median_original_sample, median_resample_data[[j]])
  dks$bootstrap[j] <- names(median_resample_data)[j]
  dks$D[j]       <- k$statistic
  dks$p[j]       <- k$p.value
}

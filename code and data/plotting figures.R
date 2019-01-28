
MSE_plot <- function(V){
  MSE = V[1,]
  bias_squared = V[3,]
  variance_MSE = V[2,]
  N_study = dim(V)[2]+1
  N_min = 3
  lineset <- 2.5
  
  #Saving to png
  #png(filename = paste0(output_folder,output_title))
  
  layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE))
  plot(bias_squared[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Num of included studies i', ylab='', main= expression(Bias^2 - b[0]^2))
  plot(variance_MSE[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Num of included studies i', ylab='', main = 'Variance')
  plot(MSE[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Num of included studies i', ylab='', main = 'MSE')
  
}

study_id <- 76 
beta_sample <- beta_uniform[study_id,]
se_sample <- se_uniform[study_id,]

stem_output <- stem(beta_sample, se_sample, stem_param)
MSE_measures <- stem_output$MSE

MSE_plot(MSE_measures)


MSE_plot(MSE_measures)

V <- MSE_measures
MSE = V[1,]
bias_squared = V[3,]
variance_MSE = V[2,]
N_study = dim(V)[2]+1
N_min = 3
lineset <- 2.5

#Saving to png
#png(filename = paste0(output_folder,output_title))

layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE))
plot(bias_squared[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Number of included studies', ylab='', main= expression(Bias^2 - b[0]^2))
plot(variance_MSE[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Number of included studies', ylab='', main = expression(Variance))
plot(MSE[N_min:N_study],type='l',  col="blue", lwd = lineset, xlab = 'Number of included studies', ylab='', main = expression(MSE - b[0]^2))

dev.off()
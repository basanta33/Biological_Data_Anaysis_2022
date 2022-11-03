library(tidyverse, ggplot)
birds <- read_csv("data/birds.csv")
ggplot(data = birds, mapping = aes(x=trait)) + geom_density()
#################################################################
norm_samples <- rnorm(10000, mean = 4.5)
hist(norm_samples)
#################################################################
ks.test(x = birds, y = norm_samples) 
#################################################################
install.packages("mixtools")
library(mixtools)
#################################################################
mx_norm <- rnormmix(1000, lambda=c(.X,.X), mu=c(X, X), sigma=c(X,X))
hist(mx_norm)
#################################################################
ks.test(birds, mx_norm)
#################################################################
#################################################################

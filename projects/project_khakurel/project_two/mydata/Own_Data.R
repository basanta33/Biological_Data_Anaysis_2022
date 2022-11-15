##to clean the column title
#this package helps clean the data. e.g.- remove any spaces in the column titles
install.packages("janitor")
#load the package
library(janitor)
#mutate the data frames with cleaner column names
mydata2 <- mydata %>%
  clean_names()

##to visualize the columns
#load ggplot2 library
library(ggplot2)
#plot the desired column into each variable
One <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= max_pairwise_difference))+geom_point()
Two <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= max_pairwise_difference_excluding_ambiguous))+geom_point()
Three <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= max_variable_block_length))+geom_point()
Four <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= max_variable_block_length_excluding_ambiguous))+geom_point()
Five <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= min_pairwise_difference))+geom_point()
Six <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= min_pairwise_difference_excluding_ambiguous))+geom_point()
Seven <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= theta))+geom_point()
Eight <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= tajima_d))+geom_point()
Nine <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= tajima_pi))+geom_point()
Ten <- ggplot(mydata2, mapping = aes(x= 1:nrow(mydata2), y= segregating_sites))+geom_point()
#this package helps to combine multiple plots to one
library(patchwork)
# combine all the graphs to one
Final <- One + Two + Three + Four + Five + Six + Seven + Eight + Nine + Ten


##select the columns with values
mydata_selected <- mydata2 %>%
#select the columns with values
  select(max_pairwise_difference, max_pairwise_difference_excluding_ambiguous, max_variable_block_length, max_variable_block_length_excluding_ambiguous, min_pairwise_difference, min_pairwise_difference_excluding_ambiguous, theta, tajima_d, tajima_pi, segregating_sites)
#view the dataframe
View(mydata_selected)




***
  # Effect Size Calculations
```{r}
statID = c("max_pairwise_difference", "max_pairwise_difference_excluding_ambiguous", "max_variable_block_length", "max_variable_block_length_excluding_ambiguous", "min_pairwise_difference", "min_pairwise_difference_excluding_ambiguous", "theta", "tajima_d", "tajima_pi", "segregating_sites")
```

```{r}
for (x in 2:ncol(simulated_data)){
  names(simulated_data) <- NULL
  numbers <- simulated_data[,x]
  numbers <- is.numeric(numbers)
  m = median(numbers)
  empValue = empirical_data[,1]
  effect_size = abs((m-empValue)/sd(numbers))
}
```

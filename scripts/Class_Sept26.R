library(tidyverse)

data <- read_csv("data/Butterfly_data.csv")

filter_years <- function(dataset = data){
  new_data <- data %>% 
  filter(years>1997)
return(new_data)
}
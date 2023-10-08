library(janitor)
library(tidyverse)
url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-08/IMDb_Economist_tv_ratings.csv'
tvrating <- read_csv(url) %>%
  clean_names()
usethis::use_data(tvrating, overwrite = TRUE)

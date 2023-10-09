library(tidyverse)
url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-08/IMDb_Economist_tv_ratings.csv'
tv_ratings <- read_csv(url)
usethis::use_data(tv_ratings, overwrite = TRUE)

#' TV Ratings Data Set
#'
#' This data set contains information about TV ratings.
#'
#' @format A data frame with 2,266 rows and 7 columns:
#'   \describe{
#'     \item{titleId}{Unique identifier for TV show titles. Character.}
#'     \item{seasonNumber}{Season number of the TV show. Numeric.}
#'     \item{title}{Title of the TV show. Character.}
#'     \item{date}{Date of the TV show. Date.}
#'     \item{av_rating}{Average viewer rating of the TV show. Numeric.}
#'     \item{share}{Viewer share of the TV show. Numeric.}
#'     \item{genres}{Genres of the TV show. Character.}
#'   }
#'
#' @import tidyverse
#' @name tv_ratings
#' @docType data
#' @keywords datasets
#' @export

library(tidyverse)
url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-08/IMDb_Economist_tv_ratings.csv'
tv_ratings <- read_csv(url)
usethis::use_data(tv_ratings, overwrite = TRUE)

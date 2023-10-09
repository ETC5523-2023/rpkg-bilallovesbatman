#' Calculating the Five-Number Summary for TV Ratings
#'
#' This function calculates the five-number summary (minimum, Q1, median, Q3, maximum) for the "av_rating" column in the TV ratings dataset.
#'
#' If the input is a numerical vector of at least 5 values, it returns a data frame with two columns in which the first column consists of the names of the values (minimum, Q1, median, Q3, maximum) while the second column returns the five-number summary values.
#'
#' If the input is a numerical vector of less than 5 values, it returns NULL.
#'
#' @param tvrating A data frame that contains the TV ratings data.
#'
#' @return A data frame with two columns: "Statistic" (the name of the statistic) and "Value" (the five-number summary values).
#'
#' @examples
#' summary_tvrating(tv_ratings)
#'
#' # where "tv_ratings" is the dataset used.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr select
#' @importFrom dplyr filter
#' @importFrom dplyr count
#' @importFrom dplyr slice_max
#'
#' @export

  summary_tvrating <- function(tvrating) {

    if (length(tvrating$av_rating) < 5) {
      warning("The 'av_rating' column must contain a minimum of 5 values")
      return(NULL)
    }

    summary_data <- quantile(tvrating$av_rating, probs = c(0, 0.25, 0.5, 0.75, 1))
    summary_df <- data.frame(
      Statistic = c("Minimum", "1st Quartile (Q1)", "Median", "3rd Quartile (Q3)", "Maximum"),
      Value = as.numeric(summary_data)
    )

    return(summary_df)
  }

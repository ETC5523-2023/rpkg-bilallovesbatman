#' Generating a parameterized genre distribution plot.
#'
#' This function generates the genre distribution plot based on the selected
#' top genres.
#'
#' @param tv_data The TV ratings data.
#' @param selected_genre The number of top genres to include in the plot (constant number).
#'
#' @return The plot for the genre distribution.
#'
#' @examples
#' # example code
#'
#'genre_plot(tv_ratings, selected_genre = 5)
#'
#' # tv_ratings is the dataset while selected_genre = 5 shows the top 5 genres in the plot.
#'
#' @import ggplot2
#' @import tidyr
#' @importFrom tidyr separate_rows
#' @importFrom dplyr %>%
#' @importFrom dplyr select
#' @importFrom dplyr filter
#' @importFrom dplyr count
#' @importFrom dplyr slice_max
#' @export
#'
#' @export
genre_plot <- function(tv_data, selected_genre) {
  separate_genres <- tv_data |>
    separate_rows(genres, sep = ",")

  genre_count <- separate_genres |>
    count(genres, sort = TRUE) |>
    slice_max(order_by = n, n = selected_genre)

  p1 <- ggplot(genre_count,
               aes(
                 x = reorder(genres, n),
                 y = n,
                 text = paste("Genre: ", genres, "<br>Count: ", n)
               )) +
    geom_bar(stat = "identity",
             fill = "navy") +
    coord_flip() +
    labs(x = "Genre",
         y = "Number of Shows") +
    theme_classic() +
    theme(axis.text.x = element_text(size = 15),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 15),
          axis.title.y = element_text(size = 15))

  return(p1)
}

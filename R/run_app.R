#' Run the Shiny app.
#'
#' This function runs the Shiny app included in the package.
#'
#' @import shiny
#' @import shinydashboard
#'
#' @export
run_app <- function() {
  app_dir <- system.file("eda-app", package = "tvrating")
  shiny::runApp(app_dir, display.mode = "normal")
}

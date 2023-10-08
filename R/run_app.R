#' @export
run_app <- function() {
  app_dir <- system.file("eda-app", package = "tvrating")
  shiny::runApp(app_dir, display.mode = "normal")
}

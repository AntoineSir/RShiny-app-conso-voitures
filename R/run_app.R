#' Lancement de l'application
#'
#' @return lance l'application
#'
#' @import shiny
#' @export
#'
run_app <- function() {
  shinyApp(ui = app_ui(), server = app_server)
}

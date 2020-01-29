
run_app <- function() {
  shinyApp(ui = app_ui(), server = app_server)
}

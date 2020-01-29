#' @import shiny
#' @importFrom graphics hist
#' @importFrom stats rnorm
#' @import datasets
#' @import DT
app_server <- function(input, output,session) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- datasets::faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  output$df_voitures <- DT::renderDataTable(
    app.voitures::df_print(),
    filter = "top",
    options = list(
      pageLength = 10)
  )

}

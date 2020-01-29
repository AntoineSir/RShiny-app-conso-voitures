#' @import shiny
#' @import shinythemes
#'
app_ui <- function() {
  navbarPage(theme = shinythemes::shinytheme("united"), "Mon appli",

     tabPanel("plot",

       # Application title
       titlePanel("Old Faithful Geyser Data"),

       # Sidebar with a slider input for number of bins
       sidebarLayout(
         sidebarPanel(
           sliderInput("bins",
                       "Number of bins:",
                       min = 1,
                       max = 50,
                       value = 30)
         ),

         # Show a plot of the generated distribution
         mainPanel(
           plotOutput("distPlot")
         )

       )
     ),


     tabPanel("rien")


  )
}

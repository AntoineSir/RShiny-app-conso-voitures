#' @import shiny
#' @import shinythemes
#'
app_ui <- function() {
  navbarPage(theme = shinythemes::shinytheme("united"), "Mon appli",

     tabPanel("Représentation graphique des performances",

       # Titre de l'onglet
       titlePanel("Émissions de Co2 & consommation"),

       # Sidebar with a slider input for number of bins
       sidebarLayout(
         sidebarPanel("Choix des variables",
           sliderInput("annee",
                       "Année des modèles des voitures :",
                       min = 2007,
                       max = 2013,
                       value = c(2007, 2013)),
           selectInput("marque",
                       "Choisissez des marques : ",
                       choices = sort(unique(df_print()[["Marque"]])),
                       selected = sort(unique(df_print()[["Marque"]])),
                       multiple = TRUE),
           checkboxGroupInput("carbu",
                       "Choisissez des carburants : ",
                       choices = unique(df_print()[["Type de carburant"]]),
                       selected = unique(df_print()[["Type de carburant"]])),
           selectInput("var_group", "Ventiler par :",
                       choices = c("Aucun", "Type de carburant", "Marque", "Type de voiture", "Année modèle"),
                       selected = "Aucun"),
           actionButton("go", "Actualiser le graphique")
         ),

         # Show a plot of the generated distribution
         mainPanel(
           plotOutput("distPlot")
         )

       )
     ),


     tabPanel("Voir les données",

      # Titre de l'onglet
      titlePanel("Caractéristiques et émissions des voitures en 2014"),

      splitLayout(DTOutput('df_voitures'))

      )


  )
}

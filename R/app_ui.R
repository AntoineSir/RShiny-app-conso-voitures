#' @import shiny
#' @import shinythemes
#' @import DT
#' @export
#'
app_ui <- function() {
  navbarPage(theme = shinythemes::shinytheme("united"), "Performances écologiques des voitures françaises en 2014",

     tabPanel("Représentation graphique des performances",

       # Titre de l'onglet
       titlePanel("Émissions de Co2 & consommation"),

       # Sidebar with different inputs
       sidebarLayout(
         sidebarPanel(
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
                       selected = "Essence uniquement"),
           selectInput("var_group", "Ventiler par :",
                       choices = c("Aucun", "Type de carburant", "Marque", "Type de voiture", "Année modèle"),
                       selected = "Aucun"),
           actionButton("go", "Actualiser le graphique")
         ),

         # Show a plot of the generated distribution
         mainPanel(
           plotOutput("my_plot",  width = "100%")
         )

       )
     ),


     tabPanel("Voir les données",

      # Titre de l'onglet
      titlePanel("Caractéristiques et émissions des voitures en 2014"),

      splitLayout(DT::DTOutput('df_voitures'))

      ),


     tabPanel("Estimer le niveau de pollution de ma voiture",

      sidebarLayout(
        sidebarPanel(
          numericInput("annee2",
                      "Choisissez l'année du modèle :",
                      min = 2007,
                      max = 2013,
                      value = 2013),
          selectInput("carbu2",
                      "Choisissez un type de carburant : ",
                      choices = sort(unique(df_print()[["Type de carburant"]])),
                      selected = "Essence uniquement",
                      multiple = FALSE),
          radioButtons("carrosserie",
                       "Choisissez une carroserie : ",
                       choices = unique(df_print()[["Carrosserie"]]),
                       selected = "BERLINE"),
          selectInput("gamme", "Choisissez une gamme : ",
                      choices = unique(df_print()[["Gamme"]]),
                      selected = "INFERIEURE"),
          actionButton("go2", "Lancer la prédiction")
        ),

        # Afficher résultat prédiction
        mainPanel(
          textOutput("my_text")
        )

      )

     )
  )

}

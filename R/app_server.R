#' @import shiny
#' @import ggplot2
#' @import dplyr
#' @import DT
app_server <- function(input, output, session) {

  data <- app.voitures::df_print()
  voitures_plot <- eventReactive(input$go, {
    data %>% filter(`Année du modèle` %in% c(input$annee[1] : input$annee[2]) &
                      Marque %in% input$marque &
                      `Type de carburant` %in% input$carbu)
  })
  var_group <- eventReactive(input$go, {
    input$var_group
  })

  output$distPlot <- renderPlot({
    plot <- voitures_plot() %>% ggplot(aes(x = `Consommation mixte (en l/100km)`, y = `Émissions de co2 (en g/100km)`))
    if (var_group() == "Type de carburant"){
      plot + geom_point(aes(color = `Type de carburant`)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon le type de carburant",
             y = "Émissions de Co2 en g/100km",
             x = "Consommation en l/100km")
    } else if (var_group() == "Marque"){
      plot + geom_point(aes(color = Marque)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon la marque",
             y = "Émissions de Co2 en g/100km",
             x = "Consommation en l/100km")
    } else if (var_group() == "Type de voiture"){
      plot + geom_point(aes(color = Carrosserie)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon la carrosserie",
             y = "Émissions de Co2 en g/100km",
             x = "Consommation en l/100km")
    } else if (var_group() == "Année modèle"){
      plot + geom_point(aes(color = `Année du modèle`)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon l'année du modèle",
             y = "Émissions de Co2 en g/100km",
             x = "Consommation en l/100km")
    } else {
      plot + geom_point(color = "orange") +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2",
             y = "Émissions de Co2 en g/100km",
             x = "Consommation en l/100km")
    }
  })

  output$df_voitures <- DT::renderDataTable(
    app.voitures::df_print(),
    filter = "top",
    options = list(
      pageLength = 10)
  )

}

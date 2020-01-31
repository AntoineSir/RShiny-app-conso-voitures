#' @import shiny
#' @import ggplot2
#' @import dplyr
#' @import DT
#' @export
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

  output$my_plot <- renderPlot({
    plot <- voitures_plot() %>% ggplot(aes(x = `Consommation mixte (en l/100km)`, y = `Émissions de co2 (en g/km)`))
    if (var_group() == "Type de carburant"){
      plot + geom_point(aes(color = `Type de carburant`)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon le type de carburant",
             y = "Émissions de Co2 en g/km",
             x = "Consommation en l/100km")+
        theme(legend.position = "bottom")
    } else if (var_group() == "Marque"){
      plot + geom_point(aes(color = Marque)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon la marque",
             y = "Émissions de Co2 en g/km",
             x = "Consommation en l/100km")+
        theme(legend.position = "bottom")
    } else if (var_group() == "Type de voiture"){
      plot + geom_point(aes(color = Carrosserie)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon la carrosserie",
             y = "Émissions de Co2 en g/km",
             x = "Consommation en l/100km")+
        theme(legend.position = "bottom")
    } else if (var_group() == "Année modèle"){
      plot + geom_point(aes(color = `Année du modèle`)) +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2 selon l'année du modèle",
             y = "Émissions de Co2 en g/km",
             x = "Consommation en l/100km")+
        theme(legend.position = "bottom")
    } else {
      plot + geom_point(color = "orange") +
        xlim(0, 16) + ylim(0, 400) +
        labs(title = "Consommation de carburant et émissions de Co2",
             y = "Émissions de Co2 en g/km",
             x = "Consommation en l/100km") +
        theme(legend.position = "bottom")
    }
  })

  output$df_voitures <- DT::renderDT(
    app.voitures::df_print(),
    filter = "top",
    options = list(
      pageLength = 10)
  )

  modele_pred <- app.voitures::predict_conso()
  predict_co2 <- eventReactive(input$go2, {
    data <- data.frame(gamme = as.factor(input$gamme),
                       carbu = as.factor(input$carbu2),
                       carross = as.factor(input$carrosserie),
                       annee = as.numeric(input$annee2))
    predict(modele_pred, newdata = data)
  })
  output$my_text <- renderText({paste0("Avec les critères que vous avez choisis, notre modèle de prédiction linéaire estime une consommation d'environ ", max(round(predict_co2(), 0), 0),
                                       " grammes de CO2 par kilomètre parcouru.",
                                      " Pour comparaison, le niveau moyen de consommation des voitures circulant en france en 2014 est de ",
                                      round(mean(app.voitures::df_print()[["Émissions de co2 (en g/km)"]], 0)),
                                      " grammes de CO2 par kilomètre parcouru")})

}

#' Fonction entrapinant le modèle permettant de prédire le niveau de consommation
#'
#' @param train table sur laquelle on entraîne le modèle
#'
#' @return un modèle qu'on peut utiliser pour la prédiction
#'
#' @import dplyr
#' @export
#'
predict_conso <- function(train = app.voitures::df_print()){
  data_in <- train %>%
    transmute(carross = as.factor(Carrosserie),
              gamme = as.factor(Gamme),
              carbu = as.factor(`Type de carburant`),
              co2 = `Émissions de co2 (en g/km)`,
              annee = `Année du modèle`) %>%
    filter_at(vars(carross, gamme, carbu, co2, annee), all_vars(!is.na(.)))
  return(lm(data = data_in, co2 ~ gamme + carbu + carross + annee))

}


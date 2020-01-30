#' Fonction pour définir le dataframe qui s'affiche pour l'utilisateur
#'
#' @param df
#'
#' @return un dataframe avec des jolis noms de variable
#'
#' @import dplyr
#' @export
#'
#'
df_print <- function(df = voitures_2014){
  df %>%
    mutate(cod_cbr = case_when(cod_cbr == "EE" ~ "Essence + Electrique",
                               cod_cbr == "EH" ~ "Hybride essence élec non rechargeable",
                               cod_cbr == "EL" ~ "Electrique uniquement",
                               cod_cbr == "ES" ~ "Essence uniquement",
                               cod_cbr %in% c("ES/GN", "GN/ES") ~ "Essence + Gaz naturel",
                               cod_cbr %in% c("ES/GP", "GP/ES") ~ "Essence + GPL",
                               cod_cbr == "FE" ~ "Super éthanol",
                               cod_cbr == "GH" ~ "Hybride gazole élec non rechargeable",
                               cod_cbr == "GL" ~ "Gazole + Electrique",
                               cod_cbr == "GN" ~ "Gaz naturel",
                               cod_cbr == "GO" ~ "Gazole uniquement"),
           conso_urb = round(as.numeric(gsub(",", ".", conso_urb)), 2),
           conso_exurb = round(as.numeric(gsub(",", ".", conso_exurb)), 2),
           conso_mixte = round(as.numeric(gsub(",", ".", conso_mixte)), 2),
           position_annee = unlist(gregexpr(pattern ='EURO', champ_v9)),
           `Année du modèle` = as.numeric(substr(champ_v9, position_annee - 4, position_annee - 1)),
           `Année du modèle` = replace(`Année du modèle`, is.na(`Année du modèle`), 2008)) %>%
    arrange(co2) %>%
    select(Marque = lib_mrq, `Modèle` = dscom,
           `Type de carburant` = cod_cbr,
           `Année du modèle`, Carrosserie, Gamme = gamme,
           `Consommation urbaine (en l/100km)` = conso_urb,
           `Consommation exo-urbaine (en l/100km)` = conso_exurb, `Consommation mixte (en l/100km)` = conso_mixte,
           `Émissions de co2 (en g/km)` = co2
           ) %>%
    filter(`Type de carburant` != "Electrique uniquement") %>%
    distinct()

}

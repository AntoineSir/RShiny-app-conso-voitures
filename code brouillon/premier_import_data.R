# pgm d'import des données et sauvegarde en RDS pour la version utilisée par l'application

library(dplyr)
voitures_2014 <- tibble::as_tibble(data.table::fread("code brouillon/mars-2014-complete.csv", sep = ";")) %>%
  select(-V27, -V28, -V29, -V30)

usethis::use_data(voitures_2014, voitures_2014)


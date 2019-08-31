# učitavanje datoteke JarunSviCisto.csv
library(readr)
library(tidyverse)
Jarun_potrosnja <- read_csv2("D:/OneDrive/OneDrive - EIHP/R/00 Analize/00 Finalno/datasets/JarunSviCisto.csv", col_types = cols(Grad = col_factor(),
                                                          Adresa = col_factor(),
                                                          KrajnjiKupac = col_factor(),
                                                          OMM = col_factor(),
                                                          MjesecGodina = col_factor(),
                                                          Mjesec = col_factor(),
                                                          Godina = col_factor(),
                                                          Datum = col_factor(),
                                                          KategorijaPotrosnje = col_factor(),
                                                          GrupaKK = col_factor(),
                                                          ModelSnaga = col_factor(),
                                                          ModelEnergija = col_factor(),
                                                          ModelVoda = col_factor(),
                                                          Povrsina = col_double(),
                                                          Povrsina3EG = col_double(),
                                                          Povrsina2EG = col_double(),
                                                          EnergijaGrijanjeOMM = col_double(),
                                                          EnergijaVodaOMM = col_double(),
                                                          ToplinaOMM = col_double(),
                                                          ProsjekVoda01 = col_double(),
                                                          ProsjekVoda02 = col_double(),
                                                          OsobeOMM = col_double(),
                                                          OsobeKK = col_double(),
                                                          ImpulsiOMM = col_double(),
                                                          ImpusliKK = col_double(),
                                                          VolumenVodaOMM = col_double(),
                                                          VolumenVodaKK = col_double(),
                                                          UR = col_factor(),
                                                          UPOV = col_factor(),
                                                          KorekcijskiFaktor = col_factor(),
                                                          SnagaKK = col_double(),
                                                          CijenaSnagaProizvodnja = col_double(),
                                                          CijenaSnagaDistribucija = col_double(),
                                                          CijenaSnagePrije2014 = col_double(),
                                                          ToplinaKK = col_double(),
                                                          VodaKK = col_double(),
                                                          EnergijaKK = col_double(),
                                                          CijenaEnergijaProizvodnja = col_double(),
                                                          CijenaEnergijaDistribucija = col_double(),
                                                          CijenaEnergijaPrije2014 = col_double(),
                                                          NaknadaOpskrba = col_double(),
                                                          NaknadaKupac = col_double(),
                                                          NaknadaUpravljanje = col_double(),
                                                          Godine0_6 = col_factor(),
                                                          Godine7_18 = col_factor(),
                                                          Godine18_65 = col_factor(),
                                                          Godine65 = col_factor(),
                                                          UpitnikOsobe = col_factor(),
                                                          Kat = col_factor(),
                                                          VrijemeBoravka = col_factor(),
                                                          AdaptacijaProzora = col_factor(),
                                                          TipProzora = col_factor(),
                                                          ToplinskaUgodnost = col_factor(),
                                                          NegrijaneProstorije = col_factor(),
                                                          Prozracivanje = col_factor())) 
Jarun_potrosnja <- as.data.frame(Jarun_potrosnja)
Jarun_potrosnja$ToplinaKK <- ifelse(is.na(Jarun_potrosnja$ToplinaKK), 0, Jarun_potrosnja$ToplinaKK)
Jarun_potrosnja$Povrsina2EG <- ifelse(is.na(Jarun_potrosnja$Povrsina2EG), 0, Jarun_potrosnja$Povrsina2EG)
Jarun_potrosnja$Povrsina3EG <- ifelse(is.na(Jarun_potrosnja$Povrsina3EG), 0, Jarun_potrosnja$Povrsina3EG)
Jarun_potrosnja$ImpulsiOMM <- ifelse(is.na(Jarun_potrosnja$ImpulsiOMM), 0, Jarun_potrosnja$ImpulsiOMM)
Jarun_potrosnja$ImpusliKK <- ifelse(is.na(Jarun_potrosnja$ImpusliKK), 0, Jarun_potrosnja$ImpusliKK)
Jarun_potrosnja$EnergijaGrijanjeOMM  <- ifelse(is.na(Jarun_potrosnja$EnergijaGrijanjeOMM ), 0, Jarun_potrosnja$EnergijaGrijanjeOMM )

# učitavanje datoteke Temperature.csv
Temperature <- read_csv2("D:/OneDrive/OneDrive - EIHP/R/00 Analize/00 Finalno/datasets/Temperature.csv", col_types = cols(Mjesec = col_factor(),
                                                             Godina = col_factor(),
                                                             Vanjska_temperatura = col_double(),
                                                             Broj_dana = col_double()))

# Temperature <- as.data.frame(Temperature)
# Temperature$SDG <- Temperature$Broj_dana*(20 - Temperature$Vanjska_temperatura)
# Temperature$SDG <- ifelse(Temperature$SDG < 0, 0, Temperature$SDG)

# DODAVANJE NOVOG STUPCA SDG prema kojem se normira potrošnja (2014. godina)
# SDG_2014 <- filter(Temperature,Temperature$Godina==2014)
# colnames(SDG_2014)[5] <- "SDG_2014"
# SDG_2014 <- SDG_2014[,c(1,5)]

# Temperature_NewDataFrame <- merge(SDG_2014, Temperature, by = c("Mjesec"))
# 
# # NORMIRANJE PREMA 2014. GODINI
# Temperature_NewDataFrame$faktor <- Temperature_NewDataFrame$SDG_2014/Temperature_NewDataFrame$SDG
# Temperature_NewDataFrame$faktor <- ifelse(Temperature_NewDataFrame$faktor =="NaN" | Temperature_NewDataFrame$faktor == "Inf" , 0, Temperature_NewDataFrame$faktor)

# Spajanje podatkovnog okvira Temperature_NewDataFrame i podatkovnog okvira Jarun_NewDataFrame
Svipodaci <- merge(Jarun_potrosnja, Temperature, by = c("Mjesec", "Godina"))

# Svipodaci %>% select(-NaknadaUpravljanje,-NaknadaKupac,-NaknadaOpskrba,
#                      -CijenaSnagaProizvodnja,-CijenaSnagaDistribucija,-CijenaSnagePrije2014,
#                      -CijenaEnergijaProizvodnja,-CijenaEnergijaDistribucija,-CijenaEnergijaPrije2014,-SnagaKK,
#                      -KorekcijskiFaktor,-UPOV,-UR,-OsobeKK,-OsobeOMM,-ProsjekVoda01,-EnergijaVodaOMM)

Svipodaci %>% select(Mjesec,Godina,Grad,Adresa,OMM,KategorijaPotrosnje,
                     GrupaKK,ModelSnaga,ModelEnergija,Povrsina,Povrsina3EG,Povrsina2EG,
                     EnergijaGrijanjeOMM,ToplinaOMM,ImpulsiOMM,ImpusliKK,ToplinaKK,
                     Godine0_6,Godine7_18,Godine18_65,Godine65,UpitnikOsobe,Kat,VrijemeBoravka,
                     AdaptacijaProzora,TipProzora,ToplinskaUgodnost,NegrijaneProstorije,
                     Prozracivanje,Vanjska_temperatura) -> vv
vv %>% drop_na() -> vvv


dd <- data.frame(ModelEnergija=Svipodaci$ModelEnergija,Povrsina2EG=Svipodaci$Povrsina2EG,Povrsina3EG=Svipodaci$Povrsina3EG,
                 Toplina=Svipodaci$ToplinaKK,Temperatura=Svipodaci$Vanjska_temperatura,Godina=Svipodaci$Godina,
                 Povrsina=Svipodaci$Povrsina,Mjesec=Svipodaci$Mjesec,Grad=Svipodaci$Grad,Adresa=Svipodaci$Adresa,
                 KrajnjiKupac=Svipodaci$KrajnjiKupac,GrupaKK=Svipodaci$GrupaKK,OMM=Svipodaci$OMM,
                 ModelSnaga=Svipodaci$ModelSnaga,Kat=Svipodaci$Kat,VrijemeBoravka=Svipodaci$VrijemeBoravka)
dd %>% drop_na() -> ddd

Svipodaci <- as.data.frame(Svipodaci)

# Dodavanje Apsolutne i Normirane potrošnje u podatkovni okvir Svipodaci
# Svipodaci$Normirana_potrosnja <- Svipodaci$ToplinaKK*Svipodaci$faktor
# Svipodaci$Aps_potrosnja_m2 <- Svipodaci$ToplinaKK/Svipodaci$Povrsina
# Svipodaci$Norm_potrosnja_m2 <- Svipodaci$Normirana_potrosnja/Svipodaci$Povrsina


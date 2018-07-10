
# 1 hour R Intro code
# Berry Boessenkool, berry-b@gmx.de, 2018-06


wd <- getwd()
if(!grepl("Material", wd)) setwd("Material/")

# Benötigtes Paket ----
if(!requireNamespace("rdwd")) install.packages("rdwd")
if(packageVersion("rdwd")<"0.10.5") berryFunctions::instGit("brry/rdwd")

library(rdwd)
vignette("rdwd")


# Daten ----
link <- selectDWD("Potsdam", res="daily", var="kl", per="recent")
file <- dataDWD(link, read=FALSE, force=NA, overwrite=TRUE)
clim <- readDWD(file)
meta <- readVars(file)

str(clim)


# Daten zum spaeteren einlesen exportieren:

meta$Label <- paste0(meta$Kurz, "  [", meta$Einheit, "]")
write.table(clim, file="Rintro/clim.txt", sep="\t", quote=FALSE, row.names=FALSE)
write.table(meta, file="Rintro/meta.txt", sep=";", quote=FALSE, row.names=FALSE)


# ZIP Ordner erstellen:

file.copy("Rintro_1h.pdf", "Rintro", overwrite=TRUE)
zip("Rintro.zip", "Rintro")


if(!grepl("Material", wd)) setwd("..")

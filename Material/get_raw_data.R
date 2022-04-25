
# 1-3 hour R Intro code
# Berry Boessenkool, berry-b@gmx.de, 2018-06


wd <- getwd()
if(!grepl("Material", wd)) setwd("Material/")

# needed package ----
if(!requireNamespace("rdwd")) install.packages("rdwd")

library(rdwd) # See intro at https://github.com/brry/rdwd#rdwd


# Data ----
link <- selectDWD("Potsdam", res="daily", var="kl", per="recent")
file <- dataDWD(link, read=FALSE, force=NA, overwrite=TRUE, dir="DWDdata")
clim <- readDWD(file)
meta <- readVars(file)

str(clim)


# Export data for later reading ----

meta$Label <- paste0(meta$Kurz, "  [", meta$Einheit, "]")
write.table(clim, file="Rintro/clim.txt", sep="\t", quote=FALSE, row.names=FALSE)
write.table(meta, file="Rintro/meta.txt", sep=";", quote=FALSE, row.names=FALSE, fileEncoding="utf-8")


# Update PDF slides ----
if(requireNamespace("knitPres"))  # https://github.com/brry/knitpres#knitpres
  knitPres::knit_hand_pres("Rintro.Rnw")


# Create ZIP folder ----

file.copy("Rintro.pdf",      "Rintro", overwrite=TRUE)
unlink("Rintro.zip")
zip("Rintro.zip", "Rintro")


if(!grepl("Material", wd)) setwd("..")
rm(wd, file, link, clim, meta)

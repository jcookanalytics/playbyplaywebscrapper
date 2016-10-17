#function(url,home,road)
#bring in libraries
library(XML)
library(stringr)
source("data/callurl.R")
#teams
home <- "Boise State"
road <- "Utah State"
source("analysis/gametable.R")
source("analysis/plays.R")

drives <- game[which(is.na(game$V2)),]

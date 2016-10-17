#function(url,home,road)
#bring in libraries
library(XML)
library(stringr)
thegame <- function(home="Utah State",road="Boise State",url="http://www.cbssports.com/collegefootball/gametracker/playbyplay/NCAAF_20161001_UTAHST@BOISE"){
source("data/callurl.R")
#teams
#home <- "Boise State"
#road <- "Utah State"
source("analysis/gametable.R")
source("analysis/plays.R")}

drives <- game[which(is.na(game$V2)),]

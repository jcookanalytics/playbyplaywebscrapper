#function(url,home,road)
#bring in libraries
library(XML)
library(stringr)
game <- function(home="Utah State",road="Boise State",siteurl="http://www.cbssports.com/collegefootball/gametracker/playbyplay/NCAAF_20161001_UTAHST@BOISE"){
siteurl <<- siteurl
road <<- road
home <<- home
source("data/callurl.R")
#teams
source("analysis/gametable.R")
source("analysis/plays.R")
drives <- game_table[which(is.na(game_table$V2)),]
}



#URL that needs to be set
url <- "http://www.cbssports.com/collegefootball/gametracker/playbyplay/NCAAF_20161001_UTAHST@BOISE"
#pull the HTML tables
tables <- readHTMLTable(url)
game <- tables[[1]]
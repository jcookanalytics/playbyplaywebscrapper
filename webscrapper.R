#function(url,home,road)
#bring in libraries
library(XML)
library(stringr)
#URL that needs to be set
url <- "http://www.cbssports.com/collegefootball/gametracker/playbyplay/NCAAF_20161001_UTAHST@BOISE"
#pull the HTML tables
tables <- readHTMLTable(url)
game <- tables[[1]]
#teams
home <- "Utah State"
road <- "Boise State"
#building the table for the game
game$drive <- str_extract(game$V1,paste(home,road,sep="|"))
game.rows <- nrow(game)
possession <- character(game.rows)
r <- 1
for (i in game$drive[1:game.rows]){
if (is.na(game$drive[r])){
possession[r] <- team
r <- r +1}
else {possession[r] <- game$drive[r]
team <- game$drive[r]
r <- r +1}
}
game$possession <- as.data.frame(possession)

drives <- game[which(is.na(game$V2)),]
plays <- game[which(!is.na(game$V2)),]
plays$down.distance <- str_extract(plays$V1,"([1234567890]+-[1234567890])")
plays$down <- str_extract(plays$V1,"([1-4])")
plays$distance <- str_extract(plays$V1,"(?<=-)[0-9]+")
plays <- subset(plays, select=-c(drive))
colnames(plays) <- c("Situation","Play","Possession","Down.and.Distance","Down","Distance")
plays$Time <- str_extract(plays$Play,"[0-9]+:[0-9]+")
plays.rows <- nrow(plays)
plays$Minute <- str_extract(plays$Time,"[0-9]+")
plays <- transform(plays, Minute = as.numeric(Minute))
plays$Seconds <- str_extract(plays$Time,"(?<=:)[0-9]+")
r <- 2
current.quarter <- 1
quarter <- numeric(plays.rows)
quarter[1] <- 1
for (i in plays$Minute[2:plays.rows]){
if (plays$Minute[r] <= plays$Minute[r-1]){
quarter[r] <- current.quarter
r <- r +1}
else {current.quarter <- current.quarter + 1
quarter[r] <- current.quarter
r <- r + 1}
}
plays$Quarter <- as.data.frame(quarter)
type <- paste("kick","rush","pass","punt",sep="|")
plays$Type <- str_extract(plays$Play,type)
plays$Yards <- str_extract_all(plays$Play, " [0-9]+")
plays$Yards[is.na(plays$Yards)] <- 0
type <- paste(home,,sep="|")

#Pull data for each quarter
#first <- 43
#first.quarter.boise <- tables[[first]]
#second <- 44
#second.quarter.boise <- tables[[second]]
#third <- 45
#third.quarter.boise <- tables[[third]]
#fourth <- 46
#fourth.quarter.boise <- tables[[fourth]]
#game <- rbind(first.quarter.boise,second.quarter.boise,third.quarter.boise,fourth.quarter.boise)
#game$Distance <- substr($Down,3,4)

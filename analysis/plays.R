#create the plays table
plays <- game[which(!is.na(game$V2)),]

#down and distance
plays$down.distance <- str_extract(plays$V1,"([1234567890]+-[1234567890]+)")
#Down
plays$down <- str_extract(plays$V1,"([1-4])")
#distance
plays$distance <- str_extract(plays$V1,"(?<=-)[0-9]+")
#get rid of drive column
plays <- subset(plays, select=-c(drive))
#rename columns for easy use
colnames(plays) <- c("Situation","Play","Possession","Field.Side","Down.and.Distance","Down","Distance")
#get the clocktime
plays$Time <- str_extract(plays$Play,"[0-9]+:[0-9]+")

#get rows of table
plays.rows <- nrow(plays)

#break time into minutes for easier manipulation
plays$Minute <- str_extract(plays$Time,"[0-9]+")

#Convert minute field to numeric
plays <- transform(plays, Minute = as.numeric(Minute))

#seconds just in case
plays$Seconds <- str_extract(plays$Time,"(?<=:)[0-9]+")

#Loop to get quarter out of the plays
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
#add quarter to the table
plays$Quarter <- quarter
#create a play type
type <- paste("kick","rush","pass","punt","lost","sack","pen",sep="|")
plays$Type <- str_extract(plays$Play,type)
plays$Type[plays$Type=="lost"] <- "rush"

#Need to know if the play had a negative result
plays$negative.play <- str_extract(plays$Play, "loss|lost") 
plays$negative.play[which(plays$negative.play=="loss")] <- "TRUE"
plays$negative.play[which(plays$negative.play=="lost")] <- "TRUE"

#collect yards for each play
plays$allYards <- (str_extract_all(plays$Play, " [0-9]+"))
num <- plays.rows
yards <- character(num)
for (i in 1:num){
  yards[i] <- unlist(plays$allYards[i])[1]
}
returnyards <- character(num)
for (i in 1:num){
  returnyards[i] <- unlist(plays$all[i])[2]
}
yards <- as.numeric(yards)
returnyards <- as.numeric(returnyards)

#plays <- plays[,-dim(plays)[2]]
plays$AbsYards <- yards
plays$AbsReturnYards <- returnyards

plays$negative.play[is.na(plays$negative.play)] <- ""
yards <- character(num)
for (i in 1:num){
  if (plays$negative.play[i]=="TRUE"){
    yards[i] <- -(plays$AbsYards[i])
  }else{yards[i] <- plays$AbsYards[i]}
}

plays$negative.play[is.na(plays$negative.play)] <- ""
returnyards <- character(num)
for (i in 1:num){
  if (plays$negative.play[i]=="TRUE"){
    returnyards[i] <- -(plays$AbsReturnYards[i])
  }else{returnyards[i] <- plays$AbsReturnYards[i]}
}

plays$Yards <- yards
plays$Return.Yards <- returnyards

plays$penalty <- str_extract(plays$Play,"pen")

plays$nogain <- str_extract(plays$Play,"no gain")

RoadPass <- subset(plays, plays$Possession==road&plays$Type=="pass")
sum(as.numeric(RoadPass$Yards),na.rm=TRUE)
RoadRush <- subset(plays, (plays$Possession==road)&(plays$Type=="rush"|plays$Type=="sack"))
sum(as.numeric(RoadRush$Yards),na.rm=TRUE)

HomePass <- subset(plays, plays$Possession==home&plays$Type=="pass")
sum(as.numeric(HomePass$Yards),na.rm=TRUE)
HomeRush <- subset(plays, (plays$Possession==home)&(plays$Type=="rush"|plays$Type=="sack"))
sum(as.numeric(HomeRush$Yards),na.rm=TRUE)

RoadYards <- subset(plays,(plays$Possession==road)&(plays$Type!=c("punt","pen","kick")))
sum(as.numeric(RoadYards$Yards),na.rm = TRUE)





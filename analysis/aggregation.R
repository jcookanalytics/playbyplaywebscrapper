#aggregation
RoadPass <- subset(plays, plays$Possession==road&plays$Type=="pass")
sum(as.numeric(RoadPass$Yards),na.rm=TRUE)
RoadRush <- subset(plays, (plays$Possession==road)&(plays$Type=="rush"|plays$Type=="sack"))
sum(as.numeric(RoadRush$Yards),na.rm=TRUE)

HomePass <- subset(plays, plays$Possession==home&plays$Type=="pass")
sum(as.numeric(HomePass$Yards),na.rm=TRUE)
HomeRush <- subset(plays, (plays$Possession==home)&(plays$Type=="rush"|plays$Type=="sack"))
sum(as.numeric(HomeRush$Yards),na.rm=TRUE)

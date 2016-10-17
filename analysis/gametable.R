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
game$possession <- possession
side <- str_extract(game$V1,"[A-z]+")
game$field.side <- side
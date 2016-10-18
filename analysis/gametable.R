#building the table for the game
game_table$drive <- str_extract(game_table$V1,paste(home,road,sep="|"))
game.rows <- nrow(game_table)
possession <- character(game.rows)
r <- 1
for (i in game_table$drive[1:game.rows]){
  if (is.na(game_table$drive[r])){
    possession[r] <- team
    r <- r +1}
  else {possession[r] <- game_table$drive[r]
  team <- game_table$drive[r]
  r <- r +1}
}
game_table$possession <- possession
side <- str_extract(game_table$V1,"[A-z]+")
game_table$field.side <- side
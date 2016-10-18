
#URL that needs to be set
#example is left in to show what it would do without this being in the function
#pull the HTML tables
tables <- readHTMLTable(siteurl)
game_table <- tables[[1]]
library(dplyr)
library(rusquant)

tk <- "TRNFP"
getSymbols(tk, src = "Finam", period = "day")
v <- get(tk) %>% Cl() %>% diff() %>% na.omit()

### count ups
cnt <- 0
up <- c()

for (i in 1:length(v)){
  if ((v[i] > 0 | v[i] == 0) & (length(v) != i)){
    cnt = cnt + 1
  }
  else if(v[i] < 0 & i != 1) {
    if(v[i-1] > 0) {
      up = append(up, cnt)
      cnt = 0
    } else next(i)
  }
  else if(length(v) == i){
    cnt = cnt + 1
    up = append(up, cnt)
  }
}

### count down
cnt.d <- 0
down <- c()

for (j in 1:length(v)){
  if (v[j] < 0 & (length(v) != j)){
    cnt.d = cnt.d + 1
  }
  else if((v[j] > 0 | v[j] == 0) & j != 1) {
    if(v[j-1] < 0) {
      down = append(down, cnt.d)
      cnt.d = 0
    } else next(j)
  }
  else if(length(v) == j){
    cnt.d = cnt.d + 1
    down = append(down, cnt.d)
  }
}

### save to file
sink(paste0(tk, ".txt"))

cat(tk)
cat('\n')
periodicity(v)
cat('\n')

table(up)
cat('____________________________')
cat('\n')
cat('\n')

table(down)
sink() # Close the sink

library(Quandl)
library(dplyr)
library(xts)
library(lubridate)
library(dygraphs)

# Import from quandl
copper <- Quandl("CHRIS/CME_HG1", type = "xts", collapse = "daily")
gold <- Quandl("CHRIS/CME_GC1", type = "xts", collapse = "daily")  

# prepair data
cop_m <- copper$Settle["2000/"] %>% to.monthly(.) %>% Cl(.)
gd_m <- gold$Settle["2000/"] %>% to.monthly(.) %>% Cl(.)


# copper/gold ratio with converting copper from pound to tons
copper_vs_gold_month_from2006 <- cop_m * 2204.62 / gd_m
avg <- mean(copper_vs_gold_month_from2006)

# plot
dygraph(copper_vs_gold_month_from2006, main = "Copper vs. Gold") %>% 
  dyAxis("y", label = "Copper / Gold (tons/1000 USD), Chicago Mercantile Exchange") %>%
  dyOptions(drawPoints = TRUE, pointSize = 2) %>% 
  dyLimit(avg, color = 'red')
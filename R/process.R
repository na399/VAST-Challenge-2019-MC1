library(readr)
library(tidyverse)
library(zoo)

cat = "shake_intensity"

data_summary <- read_csv(paste("./out/", cat, "_summary.csv", sep=""))

data_summary <- data_summary %>% arrange(loc, time)

# round to 2 d.p. to reduce csv file size
data_summary[4:54] <- round(data_summary[4:54], 2)

time_min <- as.POSIXct("2020-04-06", tz="GMT")
time_max <- as.POSIXct("2020-04-11", tz="GMT")

time_points <- seq(time_min, time_max, by = "5 min")

loc <- unique(data_summary$loc)

data_time <- expand.grid(time = time_points, loc = loc, cat = cat)

processed_data <- left_join(data_time, data_summary, by = c("cat", "loc", "time"))

processed_data <- new_data %>% 
  group_by(loc) %>%
  mutate(time_end = ifelse(row_number() == 1, time, time_end)) %>%
  do(na.locf(.)) %>%
  mutate(time_diff = as.numeric(time) - as.numeric(time_end)) %>%
  mutate(in15min = ifelse(time_diff <= 15 * 60, 1, 0)) %>%
  mutate(in60min = ifelse((15 * 60 < time_diff) & (time_diff <= 60 * 60), 1, 0)) %>%
  mutate(over60min = ifelse(60 * 60 < time_diff, 1, 0))

write.csv(processed_data,
          paste("./out/", cat, "_summary_processed.csv", sep=""),
          quote = F,
          row.names = F)



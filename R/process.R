library(readr)
library(tidyverse)
library(zoo)


categories = c(
  "shake_intensity",
  "buildings",
  "medical",
  "power",
  "roads_and_bridges",
  "sewer_and_water"
)

locNames = c(
  "PALACE HILLS",
  "NORTHWEST",
  "OLD TOWN",
  "SAFE TOWN",
  "SOUTHWEST",
  "DOWNTOWN",
  "WILSON FOREST",
  "SCENIC VISTA",
  "BROADVIEW",
  "CHAPPARAL",
  "TERRAPIN",
  "PEPPER MILL",
  "CHEDDARFORD",
  "EASTON",
  "WESTON",
  "SOUTHTON",
  "OAK WILLOW",
  "EAST PARTON",
  "WEST PARTON"
)

all_summary <- tibble()
all_aggregated <- tibble()

for (cat in categories) {
  data_summary <-
    read_csv(paste("./out/", cat, "_summary.csv", sep = ""))
  
  data_summary <- data_summary %>% arrange(loc, time)
  
  data_summary <-
    data_summary %>% mutate(CIR = ifelse(hdi95.upper > 10, 10 - hdi95.lower, hdi95.upper - hdi95.lower))
  
  # round to 2 d.p. to reduce csv file size
  data_summary[4:13] <- round(data_summary[4:13], 2)
  data_summary$CIR <- round(data_summary$CIR, 2)
  
  time_min <- as.POSIXct("2020-04-06", tz = "GMT")
  time_max <- as.POSIXct("2020-04-11", tz = "GMT")
  
  time_points <- seq(time_min, time_max, by = "5 min")
  
  loc <- unique(data_summary$loc)
  
  data_time <- expand.grid(time = time_points, loc = loc, cat = cat)
  
  processed_data <-
    left_join(data_time, data_summary, by = c("cat", "loc", "time"))
  
  processed_data <- processed_data %>%
    group_by(loc) %>%
    mutate(time_end = ifelse(row_number() == 1, time, time_end)) %>%
    do(na.locf(.)) %>%
    mutate(time_diff = as.numeric(time) - as.numeric(time_end)) %>%
    mutate(in15min = ifelse(time_diff <= 15 * 60, 1, 0)) %>%
    mutate(in60min = ifelse((15 * 60 < time_diff) &
                              (time_diff <= 60 * 60), 1, 0)) %>%
    mutate(over60min = ifelse(60 * 60 < time_diff, 1, 0)) %>%
    mutate(locName = locNames[loc]) 
  
  aggregated_data <- processed_data %>%
    filter(time_diff == 0) %>% 
    mutate(dateHour = format(time, "%Y-%m-%d %H:00:00")) %>%
    group_by(loc, cat, dateHour) %>%
    summarize(maxMAP = max(MAP), maxCIR = max(CIR))
  
  all_summary <- bind_rows(all_summary, processed_data)
  all_aggregated <- bind_rows(all_aggregated, aggregated_data)
  
  write.csv(
    processed_data,
    paste("./out/", cat, "_summary_processed.csv", sep = ""),
    quote = F,
    row.names = F
  )
  
  write.csv(
    processed_data,
    paste("./out/", cat, "_summary_aggregated.csv", sep = ""),
    quote = F,
    row.names = F
  )
}

write.csv(
  all_summary,
  paste("./out/", "all", "_summary_processed.csv", sep = ""),
  quote = F,
  row.names = F
)

write.csv(
  all_aggregated,
  paste("./out/", "all", "_summary_aggregated.csv", sep = ""),
  quote = F,
  row.names = F
)

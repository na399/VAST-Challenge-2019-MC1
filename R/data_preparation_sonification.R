library(readr)
library(tidyr)
library(dplyr)

data_processed <-
  read_csv("out/all_summary_processed.csv",
           col_types = cols(time = col_datetime(format = "%Y-%m-%d %H:%M:%S")))

LOC = 4
CAT = "shake_intensity"

data_processed_time <- data_processed %>%
  dplyr::filter(loc == LOC) %>%
  select(time) %>%
  distinct(time) %>%
  arrange(time) 

data_processed_loc <- data_processed %>%
  dplyr::filter(loc == LOC) %>%
  dplyr::filter(time_diff == 0) %>%
  select(time, loc, cat, MAP) %>%
  mutate(MAP = 10 - MAP) %>%
  spread(cat, MAP) %>% 
  right_join(data_processed_time, by="time") %>%
  mutate_if(is.numeric, replace_na, 0) 

data_processed_cat <- data_processed %>%
  dplyr::filter(loc == LOC) %>%
  dplyr::filter(time_diff == 0) %>%
  dplyr::filter(cat == CAT) %>%
  select(time, loc, cat, MAP, CIR) %>%
  right_join(data_processed_time, by="time") %>%
  mutate_at("MAP", replace_na, 0) %>%
  mutate_at("CIR", replace_na, 10) %>%
  mutate(MAP = 10 - MAP)


write.csv(
  data_processed_loc,
  paste("out/sonification_", LOC, ".csv", sep = ""),
  quote = F,
  row.names = F
)

write.csv(
  data_processed_cat,
  paste("out/sonification_", LOC, "_", CAT, ".csv", sep = ""),
  quote = F,
  row.names = F
)

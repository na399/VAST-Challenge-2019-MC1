library(readr)
library(tidyr)
library(dplyr)

dataset <-
  read_csv(
    "../data/mc1-reports-data.csv",
    col_types = cols(
      buildings = col_number(),
      medical = col_number(),
      power = col_number(),
      roads_and_bridges = col_number(),
      sewer_and_water = col_number(),
      shake_intensity = col_number(),
      time = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
      location = col_factor(levels = loc_ids)
    )
  )

dataset_long <-
  dataset %>% gather(
    cat,
    rating,
    c(
      "buildings",
      "medical",
      "power",
      "roads_and_bridges",
      "sewer_and_water",
      "shake_intensity"
    )
  )

write.csv(dataset_long,
          "./out/mc1-reports-data-long.csv",
          quote = F,
          row.names = F)


dataset_aggregated <- dataset_long %>% drop_na() %>% group_by(location, cat, time) %>% count(rating, sort=T, name="count")


write.csv(dataset_aggregated,
          "./out/mc1-reports-data-aggregated.csv",
          quote = F,
          row.names = F)

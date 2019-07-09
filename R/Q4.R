library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(zoo)


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

dataset_3 <- dataset %>%
  dplyr::filter(location == 3) %>%
  drop_na(shake_intensity) %>%
  mutate(time_num = as.numeric(as.POSIXct(time)))

dataset_3_agg <- dataset_3 %>%
  group_by(time) %>%
  summarize(mean_shake = mean(shake_intensity))



dataset_3_long <-
  dataset_3 %>% gather(
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

# dataset_3_count_shake <- dataset_3_long %>%
#   dplyr::filter(cat == "shake_intensity") %>%
#   group_by(time) %>%
#   count(rating, sort=T, name="count") %>%
#   right_join(tibble(time=dataset_3$time), by="time")

#with(dataset_3, scatter.smooth(x = time, y = shake_intensity, span = 2/3))

loess <- loess(shake_intensity ~ time_num, dataset_3, span = 2 / 3)

ggplot(dataset_3, aes(time, shake_intensity)) +
  geom_count(aes(color = shake_intensity),
             alpha = 0.9,
             shape = 0) +
  scale_color_gradient2(
    low = "#7de2ff",
    mid = "#f8e19d",
    high = "#ff3b12",
    midpoint = 3
  ) +
  labs(x = "Time", y = "Shake Intensity") +
  theme_minimal() +
  geom_line(aes(y = predict(loess)),
            alpha = 0.7,
            color = "salmon",
            size = 1) +
  geom_line(
    data = dataset_3_agg,
    aes(y = mean_shake),
    alpha = 0.6,
    color = "grey",
    size = 0.7
  ) +
  geom_line(
    data = dataset_3_agg,
    aes(y = rollmean(mean_shake, 5, na.pad = T)),
    color = "turquoise",
    alpha = 0.7,
    size = 1
  ) 

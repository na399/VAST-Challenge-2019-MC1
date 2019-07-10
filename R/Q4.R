library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(zoo)
library(svglite)


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

data_processed <-
  read_csv("out/all_summary_processed.csv",
           col_types = cols(time = col_datetime(format = "%Y-%m-%d %H:%M:%S")))


data_summary <-
  read_csv("out/3/shake_intensity/summary/summary-2020-04-10_23-50-00.csv",
           col_types = cols(time = col_datetime(format = "%Y-%m-%d %H:%M:%S")))

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


data_processed_3 <- data_processed %>%
  dplyr::filter(loc == 3) %>%
  dplyr::filter(cat == "shake_intensity") %>%
  full_join(tibble(time=dataset_3$time), by="time")


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
  ylim(0, 10) + 
  labs(x = "Time", y = "Shake Intensity") +
  scale_y_continuous(breaks = seq(0,10, 2)) +
  theme_minimal() + 
  theme(text = element_text(size=16)) +
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
  ) +
  geom_line(
    data = data_processed_3,
    aes(y = MAP),
    color = "navyblue",
    alpha = 0.7,
    size = 1
  ) 


ggsave("out/fig4-1.svg", device = "svg", width = 18, height = 9)

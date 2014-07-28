library(dplyr)
library(ggplot2)

flights <- tbl_df(read.csv("http://inundata.org/flights.csv", stringsAsFactors = FALSE))
flights$date <- as.Date(flights$date)

weather <- tbl_df(read.csv("http://inundata.org/weather.csv", stringsAsFactors = FALSE))
weather$date <- as.Date(weather$date)

planes <- tbl_df(read.csv("http://inundata.org/planes.csv", stringsAsFactors = FALSE))

airports <- tbl_df(read.csv("http://inundata.org/airports.csv", stringsAsFactors = FALSE))

# Motivation: plotting delays on map -------------------------------------------

location <- airports %>% 
  select(dest = iata, name = airport, lat, long)

delays <- flights %>%
  group_by(dest) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE), n = n()) %>%
  arrange(desc(arr_delay)) %>%
  inner_join(location)

ggplot(delays, aes(long, lat)) + 
  borders("state") + 
  geom_point(aes(colour = arr_delay), size = 5, alpha = 0.9) + 
  scale_colour_gradient2() +
  coord_quickmap()

delays %>% filter(arr_delay < 0)


# What weather condition is most related to delays? ----------------------------

hourly_delay <- flights %>% 
  group_by(date, hour) %>%
  filter(!is.na(dep_delay)) %>%
  summarise(
    delay = mean(dep_delay),
    n = n()
  ) %>% 
  filter(n > 10)
delay_weather <- hourly_delay %>% left_join(weather)

arrange(delay_weather, desc(delay))

qplot(temp, delay, data = delay_weather)
qplot(wind_speed, delay, data = delay_weather)
qplot(gust_speed, delay, data = delay_weather)
qplot(is.na(gust_speed), delay, data = delay_weather, geom = "boxplot")
qplot(conditions, delay, data = delay_weather, geom = "boxplot") + coord_flip()
qplot(events, delay, data = delay_weather, geom = "boxplot") + coord_flip()

  

new_cases <-
  cases %>%
  ggplot(aes(reported_date, new_cases)) +
  geom_bar(stat = "identity", fill = "#384765") +
  theme_classic() +
  xlab("") +
  ylab("New Cases Reported") +
  scale_x_date(date_labels = "%b %d", date_breaks = "3 day")

new_deaths <-
  cases %>%
  ggplot(aes(reported_date, new_deaths)) +
  geom_bar(stat = "identity", fill = "#1DABC1") +
  theme_classic() +
  xlab("") +
  ylab("New Deaths Reported") +
  scale_x_date(date_labels = "%b %d", date_breaks = "3 day")

ma_deaths <-
  cases %>%
  filter(!is.na(mean_deaths_7)) %>%
  mutate(day = day - min(day)) %>%
  ggplot(., aes(day, mean_deaths_7)) +
  geom_line(colour = "#384765") +
  theme_classic() +
  ylab("") +
  ggtitle("Daily Coronavirus Deaths (7-day moving average) in Ontario") +
  scale_x_continuous(
    "Number of Days Since Deaths First Reported",
    breaks = seq(0, max(cases$day), 2)
  )
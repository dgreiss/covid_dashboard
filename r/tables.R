t <- cases %>%
  mutate(reported_date = format(reported_date, "%Y-%m-%d")) %>%
  select(
    reported_date,
    total_cases,
    deaths,
    new_cases,
    new_hospital,
    new_icu,
    new_deaths,
    mean_deaths_7
  ) %>%
  rename(
    `Reported On` = reported_date,
    `Total Cases` = total_cases,
    `Total Deaths` = deaths,
    `New Cases` = new_cases,
    `New Deaths` = new_deaths,
    `New Hospitalizations` = new_hospital,
    `New Admissions to ICU` = new_icu,
    `Average Deaths` = mean_deaths_7
  )
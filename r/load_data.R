data <- read_csv("https://data.ontario.ca/dataset/f4f86e54-872d-43f8-8a86-3892fd3cb5e6/resource/ed270bb8-340b-41f9-a7c6-e8ef587e6d11/download/covidtesting.csv")

data <-
  data %>%
  rename(
    reported_date = `Reported Date`,
    total_cases = `Total Cases`,
    deaths = Deaths,
    number_of_patients_hospitalized_with_covid_19 = `Number of patients hospitalized with COVID-19`,
    number_of_patients_in_icu_with_covid_19 = `Number of patients in ICU with COVID-19`
  )

# data <-
#   data %>%
#   janitor::clean_names()

data <-
  data %>%
  filter(total_cases > 20)

cases <-
  data %>%
  mutate(
    new_cases = uncumulate(total_cases),
    new_deaths = uncumulate(deaths),
    new_hospital = uncumulate(number_of_patients_hospitalized_with_covid_19),
    new_icu = uncumulate(number_of_patients_in_icu_with_covid_19),
    mean_deaths_7 = rollmean(new_deaths, 7, fill = NA, align = "right"),
    day = as.numeric(reported_date) - min(as.numeric(reported_date))
  ) %>%
  arrange(reported_date)

cases <-
  cases %>%
  filter(!is.na(total_cases))

cases_summary <-
  cases %>%
  select(
    reported_date, total_cases, deaths, new_cases, new_deaths
  ) %>%
  tail() %>%
  arrange(desc(reported_date)) %>%
  mutate(
    reported_date = as.character(reported_date),
    total_cases = scales::comma(total_cases, accuracy = 1),
    deaths = scales::comma(deaths, accuracy = 1),
    new_cases = scales::comma(new_cases, accuracy = 1),
    new_deaths = scales::comma(new_deaths, accuracy = 1)
  ) %>%
  rename(
    " " = reported_date,
    `Total Cases` = total_cases,
    `Total Deaths` = deaths,
    `New Cases` = new_cases,
    `New Deaths` = new_deaths
  )
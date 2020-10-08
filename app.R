library(shiny)
library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(zoo)
library(r2d3)

options(
  shiny.autoreload = TRUE,
  shiny.reactlog = TRUE
)

source("./r/uncumulate.R")
source("./r/load_data.R")

total_cases <- d3Output("total_cases", height = "100%")
new_cases <- d3Output("new_cases", height = "100%")
total_deaths <- d3Output("total_deaths", height = "100%")
new_deaths <- d3Output("new_deaths", height = "100%")
summmary <- tableOutput("summary")

server <- function(input, output) {
  output$total_cases <- renderD3({
    r2d3(
      data = cases,
      script = "www/assets/totalCases.js",
      d3_version = "5"
    )
  })

  output$new_cases <- renderD3({
    r2d3(
      data = cases,
      script = "www/assets/newCases.js",
      d3_version = "5"
    )
  })

  output$total_deaths <- renderD3({
    r2d3(
      data = cases,
      script = "www/assets/totalDeaths.js",
      d3_version = "5"
    )
  })

  output$new_deaths <- renderD3({
    r2d3(
      data = cases,
      script = "www/assets/newDeaths.js",
      d3_version = "5"
    )
  })

  output$summary <- renderTable({
    cases_summary
  })
}

shinyApp(
  ui =
    htmlTemplate(
      "www/index.html",
      total_cases = total_cases,
      new_cases = new_cases,
      total_deaths = total_deaths,
      new_deaths = new_deaths
    ),
  server
)

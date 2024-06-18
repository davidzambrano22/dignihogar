library(shiny)
library(DBI)
library(tidyverse)
library(polished)
library(RSQLite)
library(rmarkdown)
library(pagedown)

ui <- fluidPage(
  titlePanel(""),
  column(1),
  mainPanel(
    uiOutput("page_content"),
    textOutput("error_message"),
    width = 10
  )
  # )
)


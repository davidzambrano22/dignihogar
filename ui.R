library(shiny)
library(DBI)
library(tidyverse)
library(polished)
library(RSQLite)
library(rmarkdown)
library(pagedown)

ui <- fluidPage(
  titlePanel(""),
  column(2),
  column(9,
  mainPanel(
    uiOutput("page_content"),
    textOutput("error_message"),
    uiOutput("download_ui"),  # Placeholder for download button,
    width = 11
  )
  )
)

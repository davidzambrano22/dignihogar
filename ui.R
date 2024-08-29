library(shiny)
library(DBI)
library(tidyverse)
library(polished)
library(RSQLite)
library(rmarkdown)
library(pagedown)

ui <- fluidPage(
  # titlePanel("Dignihogar"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  # tags$header(
  #   style = "text-align: center;
  #           background-color: grey;
  #           padding: 20px 0;
  #           position: fixed; ",  # Increased padding for vertical space
  #   tags$div(
  #     style = "display: flex; align-items: left; justify-content: center; margin-top: 10px;",
  #     downloadButton("downloadData", "Download Database")
  #   )
  # ),
  fluidRow(
  div(style="height: 30px;"),
  column(1),
  mainPanel(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    # textOutput("error_message"),
    uiOutput("page_content"),
    width = 10
  )
  )
  # tags$footer(
  #   style = "
  #     text-align: center; 
  #     background-color: grey; 
  #     padding: 10px 0; 
  #     position: fixed; 
  #     bottom: 0; 
  #     width: 98%;
  #     color: white;
  #   ",
  #   column(2, offset = 5,
  #          "© 2024 Dignihogar."
  #          ),
  #   column(2, offset = 3,
  #          downloadLink("downloadData", "Database")
  #          )
  # )
)


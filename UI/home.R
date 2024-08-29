
homeUI <- function(output){
      output$page_content <- renderUI({
        tagList(
          tags$div(
            fluidRow(
              column(1,
                     tags$img(src = "logo_urosario.png", height = 100, width = 330, style = "text-align: center;")
              ),
              column(1, offset = 8,
                     tags$img(src = "LogoCODES.png", height = 100, width = 330, style = "text-align: center;")
              ),
            ),
            div(style = "height: 50px"),
            fluidRow(
              column(1, offset = 4,
                     tags$img(src = "logo_dignihogar.jpeg", height = 150, width = 500, style = "text-align: center;")
              )
            ),
            div(style = "height: 30px"),
            wellPanel(
              fluidRow(
              column(10, offset = 1,
               div(style = "height: 30px"),
               p("Dignihogar es una aplicación diseñada especialmente para trabajadores y empleadores de servicio doméstico. El objetivo de esta herramienta es crear una plantilla de contrato que facilite la comprensión y determinación de los deberes y derechos laborales de ambas partes. Además informa de manera clara y accesible los porcentajes a pagar en seguridad social y parafiscales.", style = "font-size: 20px; text-align: justify;"),
               div(style = "height: 30px")
               ),
              style = "background: white;"
            )
            ),
            div(style = "height: 50px"),
            fluidRow(
              slickROutput("image_slider", width = "80%", height = "400px")
            ),
            div(style = "height: 80px"),
            fluidRow(
              column(8, offset = 2,
              column(1, offset = 5, align = "center",
                     actionButton("go_dataPolicy", "Continuar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
              )
              )
            ),
            div(style = "height: 100px"),
          )
        )
      })
}

dataPolicyUI <- function(output){
  output$page_content <- renderUI({
    tagList(
      fluidRow(
        column(1,
               tags$img(src = "logo_urosario.png", height = 100, width = 330, style = "text-align: center;")
        ),
        column(1, offset = 8,
               tags$img(src = "LogoCODES.png", height = 100, width = 330, style = "text-align: center;")
        ),
      ),
      div(style = "height: 60px"),
      wellPanel(
        fluidRow(
          column(10, offset = 1,
                 div(style = "height: 30px"),
                 h2(tags$b("Política de tratamiento de datos"), style = "text-align: center; font-size: 35px;"),
                 div(style = "height: 50px"),
                 p("Por medio del presente documento, autorizo a EL COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO, institución privada de educación superior con el carácter académico de Universidad, para que mis datos personales puedan ser utilizados de conformidad con la reglamentación vigente, así como para el reporte ante entidades administrativas u organismos de control y su gestión administrativa y contable. Reconozco que mis datos serán administrados por LA UNIVERSIDAD DEL ROSARIO con un nivel adecuado de protección y en los casos regulados en el artículo 10 de la Ley 1581 de 2012.", style = "font-size: 20px; text-align: justify;"),
                 div(style = "height: 50px")
          ),
          style = "background: white;"
        )
      ),
      div(style = "height: 50px"),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4,
                      actionButton("volver_home", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1,
                      actionButton("tratamiento_datos", "Acepto >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
               )
      ),
      div(style = "height: 50px")
    )
  })
}
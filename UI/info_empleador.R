
info_empleadorUI <- function(output){
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
        fluidRow(style = "background: white;",
          column(10, offset = 1,
                 div(style = "height: 30px"),
                 h2(tags$b("Datos de la persona que emplea"), style = "text-align: center; font-size: 35px;"),
                 div(style = "height: 50px"),
                 p("La persona empleadora es quien contrata a una persona trabajadora doméstica para realizar tareas en su hogar. Por favor, complete las siguientes preguntas con la información de la persona empleadora.", style = "font-size: 20px; text-align: justify;"),
                 div(style = "height: 50px")
          ),
          div(style = "font-size: 20px;",
              column(6, offset = 3,
                     textInput("nombres_empleador", "Nombre completo:",
                               value = "",
                               width = "600px"),
                     textInput("apellidos_empleador", "Apellidos:",
                               value = "",
                               width = "600px"),
                     selectInput("tipo_documento_empleador", "Tipo de documento de identidad:",
                                 choices = c(
                                   "Cédula de Ciudadanía",
                                   "Tarjeta de Identidad",
                                   "Pasaporte",
                                   "Cédula de Extranjería"
                                 ),
                                 width = "600px"
                     ),
                     textInput("numero_documento_empleador", "Número de documento de identidad:",
                               value = "",
                               width = "600px"),
                     textInput("ciudad_empleador", "Ciudad de residencia:",
                               value = "",
                               width = "600px"),
                     textInput("direccion_empleador", "Dirección de residencia:",
                               value = "",
                               width = "600px"),
                     email_input("correo_empleador", "Correo electrónico:",
                                 value = "",
                                 width = "600px"),
                     selectInput("lugar_prestacion_servicios", "La persona trabajadora doméstica prestará sus servicios en:",
                                 choices = c(
                                   "El domicilio de la persona empleadora",
                                   "Una dirección diferente de la persona empleadora"
                                 ), width = "600px"
                     ),
                     textInput("direccion_trabajo", "Confirme la dirección:"),
                     textOutput("error_message"),
                     div(style = "height: 50px;")
              )
          )
        )
      ),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4, 
                      actionButton("volver_datosTrabajador", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1, 
                      actionButton("datos_empleador", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
               )
      ),
      div(style = "height: 80px;")
    )
  })
}
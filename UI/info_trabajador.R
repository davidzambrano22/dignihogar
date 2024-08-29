
infoTrabajadorUI <- function(output) {
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
                 h2(tags$b("Datos de la persona a emplear"), style = "text-align: center; center; font-size: 35px;"),
                 div(style = "height: 50px"),
                 p("La persona trabajadora doméstica es aquella que realiza un trabajo doméstico y es responsable de realizar tareas como la limpieza, cocina y mantenimiento general del hogar. Por favor, complete las siguientes preguntas con la información de la persona trabajadora.", style = "font-size: 20px; text-align: justify;"),
                 div(style = "height: 50px")
          ),
          div(style = "font-size: 20px;",
              column(6, offset = 3,
                     textInput("nombres_trabajador", "Nombre completo:",
                               value = "",
                               width = "600px"),
                     textInput("apellidos_trabajador", "Apellidos:",
                               value = "",
                               width = "600px"),
                     selectInput("tipo_documento_trabajador", "Tipo de Documento de identidad:",
                                 choices = c(
                                   "Cédula de Ciudadanía",
                                   "Tarjeta de Identidad",
                                   "Pasaporte",
                                   "Cédula de Extranjería"
                                 ),
                                 width = "500px"
                     ),
                     textInput("numero_documento_trabajador", "Número de documento de identidad:",
                               value = "",
                               width = "600px"),
                     textInput("ciudad_trabajador", "Ciudad de residencia:",
                               value = "",
                               width = "600px"),
                     textInput("direccion_trabajador", "Dirección de residencia:",
                               value = "",
                               width = "600px"),
                     email_input("correo_trabajador", "Correo electrónico:",
                                 value = "",
                                 width = "600px"),
                     selectInput("duracion_contrato", "El contrato tendrá una duración:",
                                 choices = c(
                                   "Indefinida (contrato a término indefinido)",
                                   "Fija (contrato con una fecha de terminación)"
                                 ),
                                 width = "600px"),
                     dateInput("fecha_inicio", "Fecha de inicio del contrato",
                               value = Sys.Date(),  # default value (today's date)
                               min = Sys.Date(),  # minimum date allowed
                               max = "2025-12-31"   # maximum date allowed
                               ),
                     textOutput("error_message"),
                     div(style = "height: 50px;"),
              )
          )
        )
      ),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4, 
                      actionButton("volver_dataPolicy", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1, 
                      actionButton("datos_trabajador", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
               )
      ),
      div(style = "height: 80px;")
      
    )
  })
}
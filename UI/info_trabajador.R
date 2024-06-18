
infoTrabajadorUI <- function(output) {
  output$page_content <- renderUI({
    tagList(
      fluidRow(
        column(4,
               tags$img(src = "logo_urosario.png", height = 150, width = 500, style = "text-align: center;")
        ),
        column(4, offset = 4,
               tags$img(src = "LogoCODES.png", height = 150, width = 500, style = "text-align: center;")
        ),
      ),
      div(style = "height: 60px"),
      wellPanel(
        h2(tags$b("Datos del trabajador"), style = "text-align: center;")
      ),
      div(style = "height: 30px"),
      p("El trabajador doméstico es una persona encargada de realizar tareas como la limpieza, cocina, y mantenimiento general del hogar. Por favor, complete las siguientes preguntas con la información del trabajador.", style = "font-size: 20px; text-align: justify;"),
      div(style = "height: 50px"),
      div(style = "font-size: 20px;",
          column(6, offset = 3,
                 textInput("nombres_trabajador", "Nombres del trabajador:",
                           value = "Andrés",
                           width = "600px"),
                 textInput("apellidos_trabajador", "Apellidos del trabajador:",
                           value = "Arias",
                           width = "600px"),
                 selectInput("tipo_documento_trabajador", "Tipo de Documento del Trabajador:",
                             choices = c(
                               "Cédula de CIudadanía",
                               "Tarjeta de Identidad",
                               "Pasaporte",
                               "Cédula de Extranjería"
                             ),
                             width = "500px"
                 ),
                 textInput("numero_documento_trabajador", "Número de documento de identidad del trabajador:",
                           value = "A",
                           width = "600px"),
                 textInput("ciudad_trabajador", "Ciudad de residencia del trabajador:",
                           value = "A",
                           width = "600px"),
                 textInput("direccion_trabajador", "Dirección de residencia del trabajador:",
                           value = "A",
                           width = "600px"),
                 email_input("correo_trabajador", "Correo electrónico del trabajador:",
                             value = "A",
                             width = "600px"),
                 selectInput("duracion_contrato", "El contrato tendrá una duración:",
                             choices = c(
                               "Indefinida (contrato a término indefinido)",
                               "Fija (contrato con una fecha de terminación)"
                             ),
                             width = "600px"),
                 div(style = "height: 50px;"),
                 fluidRow(style = "text-align: justify;",
                          column(1, offset = 2,
                                 actionButton("volver_dataPolicy", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
                          ),
                          column(3),
                          column(1, offset = 2, 
                                 actionButton("datos_trabajador", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
                          )
                 ),
                 div(style = "height: 80px;")
          )
      )
    )
  })
}
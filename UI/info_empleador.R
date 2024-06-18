
info_empleadorUI <- function(output){
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
        h2(tags$b("Datos del empleador"), style = "text-align: center;")
      ),
      div(style = "height: 30px"),
      p("El empleador es la persona que contrata a un trabajador doméstico para realizar tareas en su hogar. Por favor, complete las siguientes preguntas con la información del empleador.", style = "font-size: 20px; text-align: justify;"),
      div(style = "height: 50px"),
      div(style = "font-size: 20px;",
          column(6, offset = 3,
                 textInput("nombres_empleador", "Nombres del empleador:",
                           value = "Angélica",
                           width = "600px"),
                 textInput("apellidos_empleador", "Apellidos del empleador:",
                           value = "Sierra",
                           width = "600px"),
                 selectInput("tipo_documento_empleador", "Tipo de documento del empleador:",
                             choices = c(
                               "Cédula de CIudadanía",
                               "Tarjeta de Identidad",
                               "Pasaporte",
                               "Cédula de Extranjería"
                             ),
                             width = "600px"
                 ),
                 textInput("numero_documento_empleador", "Número de documento de identidad del empleador:",
                           value = "A",
                           width = "600px"),
                 textInput("ciudad_empleador", "Ciudad de residencia del empleador:",
                           value = "A",
                           width = "600px"),
                 textInput("direccion_empleador", "Dirección de residencia del empleador:",
                           value = "A",
                           width = "600px"),
                 email_input("correo_empleador", "Correo electrónico del empleador:",
                             value = "A",
                             width = "600px"),
                 selectInput("lugar_prestacion_servicios", "El trabajador de servicio doméstico prestará sus servicios en:",
                             choices = c(
                               "El domicilio de la persona que lo contrata (empleador)",
                               "Una dirección diferente de la del empleador"
                             ), width = "600px"
                 ),
                 textInput("direccion_trabajo", "Confirme la dirección:", value = "Calle 123"),
                 div(style = "height: 50px;"),
                 fluidRow(style = "text-align: justify;",
                          column(1, offset = 2,
                                 actionButton("volver_datosTrabajador", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
                          ),
                          column(3),
                          column(1, offset = 2, 
                                 actionButton("datos_empleador", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
                          )
                 ),
                 div(style = "height: 80px;")
          )
      )
    )
  })
}
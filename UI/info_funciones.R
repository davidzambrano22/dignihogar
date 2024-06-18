
funcionesUI <- function(output){
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
        h2(tags$b("Información de funciones"), style = "text-align: center;")
      ),
      div(style = "height: 30px"),
      p("Para generar su plantilla legal, por favor complete la siguiente información:", style = "font-size: 20px; text-align: center;"),
      div(style = "height: 50px"),
      div(style = "font-size: 20px;",
          column(6, offset = 3,
                 selectInput("modalidad_prestacion_servicios", "El trabajador de servicio doméstico realizará su labor de manera:",
                             choices = c(
                               "Externa (no vivirá en la residencia de prestación de los servicios)",
                               "Interna (vivirá en la residencia en que preste sus servicios)"
                             ), width = "600px"
                             
                 ),
                 selectizeInput("funciones_trabajador", "El servicio doméstico se compone por las siguientes funciones:",
                                choices = c(
                                  "Barrer",
                                  "Trapear y encerar pisos de instalaciones domésticas",
                                  "Limpiar",
                                  "Brillar y sellar, puertas, muebles, ventanas y otros accesorios de instalaciones domésticas",
                                  "Lavar, planchar y remendar lencería, ropa de cama y prendas de uso personal",
                                  "Preparar, cocinar y servir alimentos y bebidas en instalaciones domésticas",
                                  "Lavar vajillas y utensilios de cocina en instalaciones domésticas",
                                  "Lavar, desinfectar y desodorizar cocinas, cuartos de baño, muebles y enseres en casas de familia",
                                  "Tender camas, cambiar sábanas, poner toallas limpias y artículos de tocador en instalaciones domésticas",
                                  "Desempolvar y aspirar muebles, alfombras, tapetes, cortinas y tapizados en instalaciones domésticas"
                                ),
                                multiple = T,
                                width = "600px"
                                
                 ),
                 textAreaInput("funciones_adicionales", "Sin embargo, de ser de mutuo acuerdo, puede describir de manera opcional las funciones o responsabilidades del trabajador de servicio doméstico adicionales:",
                               value = "A",
                               width = "600px"),
                 selectInput("tipo_vinculacion", "Sobre el tipo de vinculación. El trabajador de servicio doméstico realizará su labor bajo la vinculación laboral:",
                             choices = c(
                               "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)",
                               "Fija (es decir el trabajador de servicio domestica trabaja en un solo hogar varios días a la semana"
                             ), width = "600px"
                             
                 ),
                 uiOutput("out_respuestaDias"),
                 div(style = "height: 50px;"),
                 fluidRow(style = "text-align: justify;",
                          column(1, offset = 2,
                                 actionButton("volver_datosEmpleador", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
                          ),
                          column(3),
                          column(1, offset = 2, 
                                 actionButton("datos_empleo_1", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
                          )
                 ),
                 div(style = "height: 80px;")
          )
      )
    )
  })
}
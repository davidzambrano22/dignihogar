
funcionesUI <- function(output){
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
                        h2(tags$b("Información de funciones"), style = "text-align: center; font-size: 35px;"),
                        div(style = "height: 30px"),
                        p("Para generar su plantilla de contrato, por favor complete la siguiente información. Asegúrese de proporcionar todos los datos solicitados para garantizar que el contrato refleje correctamente los términos y condiciones acordados.", style = "font-size: 20px; text-align: center;"),
                        div(style = "height: 50px"),
                 ),
                 div(style = "font-size: 20px;",
                     column(6, offset = 3,
                            selectInput("modalidad_prestacion_servicios", "La persona trabajadora doméstica realizará su labor de manera:",
                                        choices = c(
                                          "Externa (no vivirá en la residencia de prestación de los servicios)",
                                          "Interna (vivirá en la residencia en que preste sus servicios)"
                                        ), width = "600px"
                                        
                            ),
                            selectizeInput("funciones_trabajador", "El servicio doméstico de este contrato incluye  las siguientes funciones:",
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
                            textAreaInput("funciones_adicionales", "Sin embargo, de ser de mutuo acuerdo, puede describir de manera opcional las funciones o responsabilidades adicionales:",
                                          value = "",
                                          width = "600px"),
                            selectInput("tipo_vinculacion", "Sobre el tipo de vinculación. La persona trabajadora doméstica realizará su labor bajo la vinculación laboral:",
                                        choices = c(
                                          "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)",
                                          "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana"
                                        ), width = "600px"
                                        
                            ),
                            uiOutput("out_respuestaDias"),
                            textOutput("error_message"),
                            div(style = "height: 50px;")
                     )
                 )
        )
      ),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4, 
                      actionButton("volver_datosEmpleador", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1, 
                      actionButton("datos_empleo_1", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
               )
      ),
      div(style = "height: 80px;")
    )
  })
}
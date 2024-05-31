library(shiny)
library(DBI)
library(rmarkdown)
library(pagedown)

server <- function(input, output, session) {
  conn <- dbConnect(RSQLite::SQLite(), "user_data.sqlite")
  dbExecute(conn, "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, gender TEXT)")
  
  # Reactive value to control the visibility of the download and data policy agreed buttons
  formSubmitted <- reactiveVal(FALSE)
  goToDataPolicy <- reactiveVal(FALSE)
  dataPolicyAgreed <- reactiveVal(FALSE)
  submit_infoTrabajador <- reactiveVal(FALSE)
  submit_infoEmpleador <- reactiveVal(FALSE)
  submit_infoEmpleo_1 <- reactiveVal(FALSE)
  submit_infoEmpleo_2 <- reactiveVal(FALSE)
  submit_infoEmpleo_2 <- reactiveVal(FALSE)
  seen_contract <- reactiveVal(FALSE)
  
  # Initialize the page_content with a welcome message
  output$page_content <- renderUI({
    tagList(
      div(column(9, offset = 2,
            tags$img(src = "logos.png", height = 180, width = 700, style = "text-align: center;")
            )
          ),
      div(style = "height: 200px"),
      tags$br(),
      tags$h1("DIGNIHOGAR",
              style = "font-size: 45px; text-align: center; font-weight: bold; color: #B22222;"
      ),
      tags$hr(style = "border-top: 4px solid black; margin-top: 5px; margin-bottom: 10px;  border-color: #D3D3D3; width: 20%;"),
    div(style = "height: 80px"),
    p("¡Bienvenido a nuestra aplicación, diseñada especialmente para empleadas domésticas y empleadores de servicio doméstico! Nuestro objetivo es ofrecer una herramienta fácil y accesible que permita entender y determinar los deberes y derechos laborales, e informar los porcentajes a pagar a seguridad social y parafiscales.", style = "font-size: 20px; text-align: justify;"),
    p("Esta herramienta está diseñada por la Facultad de economía de la Universidad del Rosario y la corporación para el desarrollo de la seguridad social - CODESS. Nuestra aplicación busca cerrar la brecha informativa, ya que las empleadas domésticas y los empleadores suelen desconocer los detalles de los contratos laborales y las prestaciones sociales a las que tienen derecho y los deberes asociados a esta ocupación.", style = "font-size: 20px; text-align: justify;"),
    p("Al final de los 4 pasos, los usuarios recibirán una plantilla con detalles necesarios para garantizar el respeto de sus derechos y un trato justo en su empleo, calculando rápidamente los términos de su contrato laboral, incluyendo salario, vacaciones, entre otros beneficios.", style = "font-size: 20px; text-align: justify;"),
    div(style = "height: 50px"),
    div(style = "height: 30px"),
    div(style = "text-align: justify;",
        column(5),
        column(6,
               actionButton("go_dataPolicy", "Continuar", style = "font-size: 20px; text-align: center;") # tratamiento_datos
               )
        )
    )
  })
  
  observeEvent(input$go_dataPolicy, {
    goToDataPolicy(TRUE)
  })
  
  observeEvent(goToDataPolicy(), {
    if (goToDataPolicy()) {
      output$page_content <- renderUI({
        output$page_content <- renderUI({
          tagList(
            div(style = "height: 70px"),
            h2(tags$b("Política de tratamiento de datos"), style = "text-align: center;"),
            div(style = "height: 30px"),
            p("NOMBRE  identificado (a) con cédula de ciudadanía número XXXXXXX en aplicación de la Ley Estatutaria1581 de dos mil doce (2012) y del Decreto 1377 de dos mil trece (2013), autorizo por medio del presente documento a EL COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO, institución privada, de educación superior, con el carácter académico de Universidad, ubicada en la calle 12 C No. 6-25 en la ciudad de Bogotá D.C. sin ánimo de lucro, con personería jurídica reconocida mediante resolución número 58 del 16 de septiembre de 1895 expedida por el Ministerio de Gobierno, para recolectar, almacenar, usar, circular o suprimir los datos personales que voluntariamente he suministrado con el objeto de consolidar una base de información de hojas de vida para la selección de personal administrativo, docente y de prestación de servicios. Esta autorización no faculta a EL COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO para entregar mis datos personales a ninguna otra compañía, cliente, organización o tercero de cualquier naturaleza. El tratamiento se limitará a los fines aquí establecidos y se guardará la debida reserva, adoptando las medidas técnicas y administrativas adecuadas y suficientes que permitan el cuidado y conservación de mis datos personales. Finalmente, declaro conocer mi derecho a solicitar, en cualquier momento, que se actualice o retire parte de la información suministrada y/o que se me desvincule de las bases de datos del COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO.", style = "font-size: 20px; text-align: justify;"),
            div(style = "height: 100px"),
            div(style = "text-align: justify;",
                column(5),
                column(6,
                       actionButton("tratamiento_datos", "Acepto Términos", style = "font-size: 20px; text-align: center;") # tratamiento_datos
                )
            )
          )
        })
      })
    }
  })
  
  observeEvent(input$tratamiento_datos, {
    dataPolicyAgreed(TRUE)
  })
  
  observeEvent(dataPolicyAgreed(), {
    if (dataPolicyAgreed()) {
      output$page_content <- renderUI({
        tagList(
          div(column(12, offset = 3,
                     tags$img(src = "paso1.png", height = 200, width = 700, style = "text-align: center;")
                     )
          ),
          div(style = "height: 250px"),
          # h2("Datos del trabajador", style = "text-align: center;"),
          div(style = "height: 30px"),
          p("El trabajador doméstico es una persona encargada de realizar tareas como la limpieza, cocina, y mantenimiento general del hogar. Por favor, complete las siguientes preguntas con la información del trabajador.", style = "font-size: 20px; text-align: justify;"),
          div(style = "height: 50px"),
          div(style = "font-size: 20px;",
            column(6, offset = 3,
              textInput("nombres_trabajador", "Nombres del trabajador:",
                        # value = "Andrés",
                        width = "600px"),
              textInput("apellidos_trabajador", "Apellidos del trabajador:",
                        # value = "Arias",
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
              textInput("numero_documento_trabajador", "Número de documento de identidad del trabajador:", width = "600px"),
              textInput("ciudad_trabajador", "Ciudad de residencia del trabajador:", width = "600px"),
              textInput("direccion_trabajador", "Dirección de residencia del trabajador:", width = "600px"),
              email_input("correo_trabajador", "Correo electrónico del trabajador:", width = "600px"),
              div(style = "height: 50px;"),
              div(style = "text-align: justify;",
                  column(5),
                  column(6,
                         actionButton("datos_trabajador", "Enviar", style = "font-size: 20px; text-align: center;")
                  )
              ),
              div(style = "height: 80px;")
            )
          )
        )
      })
    }
  })

  observeEvent(input$datos_trabajador, {
    # Validate fields
    if (input$nombres_trabajador == "") {
      output$error_message <- renderText({ "*El campo Nombres  no puede estar vacío" })
      return(NULL)
    }
    else if (input$apellidos_trabajador == ""){
      output$error_message <- renderText({ "*El campo Apellidos  no puede estar vacío" })
      return(NULL)
    }
    else if (input$tipo_documento_trabajador == ""){
      output$error_message <- renderText({ "*El campo Número de documento no puede estar vacío" })
      return(NULL)
    }
    else if (input$ciudad_trabajador == ""){
      output$error_message <- renderText({ "*El campo Ciudad no puede estar vacío" })
      return(NULL)
    }
    else if (input$direccion_trabajador == ""){
      output$error_message <- renderText({ "*El campo Dirección no puede estar vacío" })
      return(NULL)
    }
    else if (input$correo_trabajador == ""){
      output$error_message <- renderText({ "*El campo Correo electrónico no puede estar vacío" })
      return(NULL)
    }
    else {
      submit_infoTrabajador(TRUE)
    }
  })
  


  observeEvent(submit_infoTrabajador(), {
    if (submit_infoTrabajador()) {
      output$error_message <- renderText({ "" })
      output$page_content <- renderUI({
        tagList(
          div(column(12, offset = 3,
                     tags$img(src = "paso2.png", height = 200, width = 700, style = "text-align: center;")
          )
          ),
          div(style = "height: 250px"),
          # h2("Datos del empleador", style = "text-align: center;"),
          # div(style = "height: 30px"),
          p("El empleador es la persona que contrata a un trabajador doméstico para realizar tareas en su hogar. Por favor, complete las siguientes preguntas con la información del empleador.", style = "font-size: 20px; text-align: justify;"),
          div(style = "height: 50px"),
          div(style = "font-size: 20px;",
              column(6, offset = 3,
                     textInput("nombres_empleador", "Nombres del empleador:",
                               # value = "Angélica",
                               width = "600px"),
                         textInput("apellidos_empleador", "Apellidos del empleador:",
                                   # value = "Sierra",
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
                         textInput("numero_documento_empleador", "Número de documento de identidad del empleador:", width = "600px"),
                         textInput("ciudad_empleador", "Ciudad de residencia del empleador:", width = "600px"),
                         textInput("direccion_empleador", "Dirección de residencia del empleador:", width = "600px"),
                         email_input("correo_empleador", "Correo electrónico del empleador:", width = "600px"),
                         selectInput("lugar_prestacion_servicios", "El trabajador de servicio doméstico prestará sus servicios en:",
                                     choices = c(
                                       "El domicilio de la persona que lo contrata (empleador)",
                                       "Una dirección diferente de la del empleador"
                                     ), width = "600px"
                         ),
                        textInput("direccion_trabajo", "Confirme la dirección:", value = "Calle 123"),
                       div(style = "height: 50px;"),
                       div(style = "text-align: justify;",
                           column(5),
                           column(6,
                                  actionButton("datos_empleador", "Enviar", style = "font-size: 20px; text-align: center;")
                           )
                       ),
                     div(style = "height: 80px;")
              )
          )
        )
      })
    }
  })
  
  observeEvent(input$datos_empleador, {
    # Validate fields
    if (input$nombres_empleador == "") {
      output$error_message <- renderText({ "*El campo Nombres  no puede estar vacío" })
      return(NULL)
    }
    else if (input$apellidos_empleador == ""){
      output$error_message <- renderText({ "*El campo Apellidos  no puede estar vacío" })
      return(NULL)
    }
    else if (input$numero_documento_empleador == ""){
      output$error_message <- renderText({ "*El campo Número de documento no puede estar vacío" })
      return(NULL)
    }
    else if (input$ciudad_empleador == ""){
      output$error_message <- renderText({ "*El campo Ciudad no puede estar vacío" })
      return(NULL)
    }
    else if (input$direccion_empleador == ""){
      output$error_message <- renderText({ "*El campo Dirección no puede estar vacío" })
      return(NULL)
    }
    else if (input$correo_empleador == ""){
      output$error_message <- renderText({ "*El campo Correo electrónico no puede estar vacío" })
      return(NULL)
    }
    else {
      submit_infoEmpleador(TRUE)
    }
  })
  
  
  
  observeEvent(submit_infoEmpleador(), {
    output$error_message <- renderText({ "" })
    if (submit_infoEmpleador()) {
      output$page_content <- renderUI({
        tagList(
          div(column(12, offset = 3,
                     tags$img(src = "paso3.jpg", height = 200, width = 700, style = "text-align: center;")
                     )
          ),
          div(style = "height: 250px"),
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
                   selectInput("tipo_vinculacion", "Sobre el tipo de vinculación. El trabajador de servicio doméstico realizará su labor bajo la vinculación laboral:",
                               choices = c(
                                 "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)",
                                 "Fija (es decir el trabajador de servicio domestica trabaja en un solo hogar varios días a la semana"
                               ), width = "600px"

                   ),
                   selectInput("respuesta_dias", "**Si su respuesta es por días** ¿Quién será el encargado de realizar los trámites de seguridad social?",
                               choices = c(
                                 "El Trabajador",
                                 "El Empleador"
                               ),
                               width = "600px"),
                   tags$p("**Tenga en cuenta que en cualquiera de los casos ambos deben aportar para el pago de seguridad y parafiscales del empleado.", style = "font-size: 18px;"),
                   div(style = "height: 50px;"),
                   div(style = "text-align: justify;",
                       column(5),
                       column(6,
                              actionButton("datos_empleo_1", "Enviar", style = "font-size: 20px; text-align: center;")
                       )
                   ),
                   div(style = "height: 80px;")
              )
          )
        )
      })
    }
  })
  
  observeEvent(input$datos_empleo_1, {
    submit_infoEmpleo_1(TRUE)
  })

  observeEvent(submit_infoEmpleo_1(), {
    if (submit_infoEmpleo_1()){
      output$error_message <- renderText({ "" })
      output$page_content <- renderUI({
        tagList(
          div(column(12, offset = 3,
                     tags$img(src = "paso4.jpg", height = 200, width = 700, style = "text-align: center;")
          )
          ),
          div(style = "height: 250px"),
          div(style = "height: 30px"),
          div(style = "font-size: 20px;",
              column(6, offset = 3,
                numericInput("salario_mensual",
                             "Salario mensual que se pagará al trabajador de servicio doméstico (en pesos, sin incluir auxilio de transporte, ni los beneficios):",
                             value = NULL,
                             width = "600px"),
                textInput("beneficios",
                          "Si existe algún pago o beneficio (vivienda, alimentación, medicina prepagada, etc.) que no haga parte del salario del trabajador de servicio doméstico, indíquelo acá:", width = "600px"),
                textInput("horario_laboral",
                          "Especifique el horario laboral: ej. Lunes a viernes de 8am a 5pm (Recuerde que el horario no debe superar las 8 horas diarias)", width = "600px"),
                numericInput("días_trabajo", "¿Cuántos días trabajará al mes?", value = NULL, width = "600px"),
                selectInput("tiempo_pagos", "¿Cuándo se realizarán los pagos de salario?:",
                            choices = c(
                              "quincenal (el 15 y 30 de cada mes)",
                              "mensual (un día acordado al mes)"
                            ), width = "600px"
                            
                ),
                selectInput("modalidad_pagos", "¿Cómo se realizará el pago de salario?:",
                            choices = c(
                              "En efectivo",
                              "A traves de una cuenta bancaria"
                            ), width = "600px"
                            
                ),
                div(style = "height: 50px;"),
                div(style = "text-align: justify;",
                    column(5),
                    column(6,
                           actionButton("datos_empleo_2", "Enviar", style = "font-size: 20px; text-align: center;")
                    )
                ),
                div(style = "height: 80px;")
              )
          )
        )
      })
    }
  })
  
  observeEvent(input$datos_empleo_2, {
    # Validate fields
    if (input$beneficios == "") {
      output$error_message <- renderText({ "*El campo Beneficios  no puede estar vacío" })
      return(NULL)
    }
    else if (input$horario_laboral == ""){
      output$error_message <- renderText({ "*El campo Horario laboral  no puede estar vacío" })
      return(NULL)
    }
    else if (input$días_trabajo < 1 || input$días_trabajo > 31) {
      output$error_message <- renderText({ "Por favor ingrese un valor entre 1 y 31 para el campo Días de trabajo" })
      return(NULL)
    }
    else {
    submit_infoEmpleo_2(TRUE)
    }
  })
  
  observeEvent(submit_infoEmpleo_2(), {
    if (submit_infoEmpleo_2()){
      output$error_message <- renderText({ "" })
      
      # dbExecute(conn, "INSERT INTO users (name, age, gender) VALUES (?, ?, ?)",
      #           params = list(input$name, input$age, input$gender))
      
      output$page_content <- renderUI({
        tagList(
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$h2(sprintf("CONTRATO DE TRABAJO ENTRE %s %s y %s %s ",
                         toupper(input$nombres_trabajador),
                         toupper(input$apellidos_trabajador),
                         toupper(input$nombres_empleador),
                         toupper(input$apellidos_empleador)
                         ),
                  style = "text-align: center;"
          ),
          tags$br(),
          tags$br(),
          tags$p(sprintf("Entre las partes, por un lado %s %s, quien en adelante y para los efectos del presente contrato se denomina EL EMPLEADOR, y por el otro, %s %s, quien en adelante y para los efectos del presente contrato se denomina EL TRABAJADOR, identificados como aparece al pie de las firmas, hemos acordado suscribir este contrato de trabajo, el cual se regirá por las siguientes cláusulas:",
                         toupper(input$nombres_empleador),
                         toupper(input$apellidos_empleador),
                         toupper(input$nombres_trabajador),
                         toupper(input$apellidos_trabajador)
                         ),
                 style = "font-size: 21px; text-align: justify;"
                 ),
          tags$p(tags$b("Primera:", style = "font-size: 21px;"),
                 "Objeto. El presente es un contrato de trabajo tiene por finalidad la prestación de servicios domésticos por parte del TRABAJADOR en la forma y condiciones previstas por el EMPLEADOR.",
                 style = "font-size: 21px; text-align: justify;"
                 ),
          tags$p(
            tags$b("Segunda:", style = "font-size: 21px;"),
            sprintf("Lugar de prestación del servicio. La prestación del servicio la hará el TRABAJADOR en la %s ", toupper(input$direccion_trabajo)),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            tags$b("Tercera:", style = "font-size: 21px;"),
            sprintf("El EMPLEADOR deberá pagar al TRABAJADOR, a título de remuneración por las actividades un monto de %s ", input$salario_mensual),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            sprintf("La forma de pago del salario señalado se hará directamente por el EMPLEADOR al TRABAJADOR, así: %s. El pago se hará %s", toupper(input$tiempo_pagos), toupper(input$modalidad_pagos)),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            sprintf("Parágrafo 1. El EMPLEADOR deberá pagar al TRABAJADOR todas las prestaciones sociales establecidas por ley: cesantías, prima, vacaciones y auxilio de transporte, de ser el caso. El pago de dichas prestaciones se hará en proporción a los días trabajados y conforme al salario recibido.", toupper(input$tiempo_pagos), toupper(input$modalidad_pagos)),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            sprintf("Parágrafo 2. De igual forma, deberá hacer los aportes de seguridad social en salud, pensión y riesgos laborales, en proporción a los días trabajados y conforme al salario recibido.  Esto sin perjuicio que el trabajador esté afiliado al Sisbén.", toupper(input$tiempo_pagos), toupper(input$modalidad_pagos)),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            tags$b("Cuarta:", style = "font-size: 21px;"),
            "Obligaciones de las partes",
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$ol(type="A",
                  tags$li("Obligaciones del EMPLEADOR:",
                          tags$ul(
                            tags$li("Pagar en la forma prevista al TRABAJADOR, el salario, junto con las prestaciones sociales."),
                            tags$li("Afiliar y pagar los respectivos aportes al sistema de seguridad social integral.")
                          ),
                          style = "font-size: 21px;"
                          ),
                  tags$li("Obligaciones del TRABAJADOR:",
                          tags$ul(
                            tags$li("Recibir, según lo pactado, el salario")
                          ),
                          tags$ul(lapply(input$funciones_trabajador, function(choice){
                            tags$li(choice)})
                          ),
                          style = "font-size: 21px;"
                  ),
          ),
          tags$p(
            tags$b("Quinta:", style = "font-size: 21px;"),
            "Terminación del contrato. Este contrato podrá terminar unilateralmente por cualquiera de las partes, si se configuran algunas situaciones previstas en el artículo 62 del Código Sustantivo del Trabajo.",
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            tags$b("Sexta:", style = "font-size: 21px;"),
            "Vigencia. Este contrato tendrá la vigencia de (especificar el término durante el cual estará vigente). ",
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p("Se firma a los (días) del mes de (mes) del (año).", style = "font-size: 21px; text-align: justify;"),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$div(
            # style = "display: inline-block; text-align: center; margin-right: 50px;",
            column(2, offset=2,
                   tags$hr(style = "border: none; border-top: 1px solid #000; width: 200px;"),
                   tags$p(paste(input$nombres_empleador, input$apellidos_empleador), style = "font-size: 21px;")
                   ),
            column(2, offset=4,
                   tags$hr(style = "border: none; border-top: 1px solid #000; width: 200px;"),
                   tags$p(paste(input$nombres_trabajador, input$apellidos_trabajador), style = "font-size: 21px;")
            )
          ),
          div(style="height: 160px;"),
          div(style = "text-align: justify;",
              column(5),
              column(6,
                     actionButton("go_infoTable", "Continuar", style = "font-size: 20px; text-align: center;") 
              )
          ),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br()
        )
      })
    }
  })
  
  observeEvent(input$go_infoTable, {
    seen_contract(TRUE)
  })
  
  observeEvent(seen_contract(), {
    if (seen_contract()){
      output$page_content <- renderUI({
        tagList(
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$h2(tags$b("Plantilla Educativa"), style = "text-align: center;"),
          tags$br(),
          tags$br(),
          tags$p(tags$b("Salario acordado sin beneficios ni deducciones:", style = "font-size: 21px; text-align: justify;"), "$", input$salario_mensual, style = "font-size: 21px; text-align: justify;"),
          conditional_paragraph <- if (as.numeric(input$salario_mensual) < 1300000 || input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)") {
            subsidio_transporte <- 162000
            tags$p(tags$b("Subsidio de transporte: "), as.character(subsidio_transporte), style = "font-size: 21px; text-align: justify;")
          } else {
            subsidio_transporte <- 0
            tags$p(tags$b("Subsidio de transporte: "), as.character(subsidio_transporte), style = "font-size: 21px; text-align: justify;")
          },
          tags$b("Prestaciones sociales:", style = "font-size: 21px; text-align: justify;"),
          div(style="height: 30px;"),
          table <- tags$table(
            style = "width: 100%; border-collapse: collapse;",
            tags$thead(
              tags$tr(
                tags$th(style = "border: 1px solid black; padding: 8px;", "Rubro"),
                tags$th(style = "border: 1px solid black; padding: 8px;", "Empleador"),
                tags$th(style = "border: 1px solid black; padding: 8px;", "Trabajador")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Salud")),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.085),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.04)
              ),
              tags$tr(
                tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Pensión")),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.12),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.04)
              ),
              tags$tr(
                tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("ARL* (tipo 1)")),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.00052),
                tags$td(style = "border: 1px solid black; padding: 8px;", "")
              ),
              tags$tr(
                tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Caja de compensación (opcional)")),
                tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.03),
                tags$td(style = "border: 1px solid black; padding: 8px;", "")
              )
            ),
            style = "font-size: 21px;"
          ),
          div(style="height: 30px;"),
          tags$b(sprintf("Salario neto que recibirá el trabajador: %d", (input$salario_mensual - (as.numeric(input$salario_mensual) * 0.04) + subsidio_transporte)), style = "font-size: 21px; text-align: justify;"),
          div(style="height: 30px;"),
          tags$b("Beneficios:", style = "font-size: 21px;"),
          tags$ul(
            tags$li(
              tags$p("Vacaciones pagadas por el empleador: 15 días al año (o proporcional)")
            ),
            tags$li(
              tags$p(sprintf("Prima: Un salario al año (o proporcional) Medio salario el 30 junio (%d)", as.numeric(input$salario_mensual) / 2), sprintf("Prima: Un salario al año (o proporcional) Medio salario el 30 junio (%d)", as.numeric(input$salario_mensual) / 2))
            ),
            tags$li(
              tags$p(sprintf("Cesantías: Consignadas al fondo del empleado. Un salario aL año (%d)", as.numeric(input$salario_mensual)), sprintf("Prima: Un salario al año (o proporcional) Medio salario el 30 junio (%d)", as.numeric(input$salario_mensual) * 0.12))
            ),
            tags$li("Incapacidades y licencias de maternidad cubiertas con la EPS"),
            tags$li("Dotaciones dos veces al año (vestuario y calzado"),
            tags$li("Acuerdos sobre tiempo de periodo de prueba."),
            tags$li("Alimentación y vivienda como se haya acordado entre las partes."),
            div(style="height: 30px;"),
            style = "font-size: 21px;"
          )
          )
      })
    }
    })

      
      
      
      
  
  observeEvent(input$submit, {
    output$error_message <- renderText({ "" })
   
    dbExecute(conn, "INSERT INTO users (name, age, gender) VALUES (?, ?, ?)",
              params = list(input$name, input$age, input$gender))
    
    output$page_content <- renderUI({
      tags$p("Ready to take the Shiny tutorial? If so")
      # HTML(sprintf('<h1 style="text-align: center;">CONTRATO DE TRABAJO ENTRE %s %s y %s %s</h1>
      #              <p style="font-size: 18px;">Entre las partes, por un lado %s %s, quien en adelante y para los efectos del presente contrato se denomina EL EMPLEADOR, y por el otro, (nombre completo del trabajador), quien en adelante y para los efectos del presente contrato se denomina EL TRABAJADOR, identificados como aparece al pie de las firmas, hemos acordado suscribir este contrato de trabajo, el cual se regirá por las siguientes cláusulas:</p>
      #              '
      #              
      #              ,
      #              input$apellidos_trabajador,
      #              input$apellidos_empleador,
      #              
      #              
      #              input$nombres_trabajador,
      #              input$apellidos_empleador,
      #              input$nombres_empleador,
      #              
      #              input$nombres_empleador,
      #              input$apellidos_empleador
      #              )
      #      )
    })
    
    # } else {
    #   output$page_content <- renderUI({
    #     includeHTML("adult_section.html")
    #   })
    # }
    
    
    
    formSubmitted(TRUE)
  })
  
  output$download_ui <- renderUI({
    if (formSubmitted()) {
      downloadButton("download_pdf", "Download PDF")
    }
  })
  
  output$download_pdf <- downloadHandler(
    filename = function() {
      paste("user_info", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      # Create a temporary HTML file
      tempReport <- file.path(tempdir(), "report.html")
      tempParams <- list(name = input$name, age = input$age, gender = input$gender)
      
      # Render the RMarkdown document to HTML
      rmarkdown::render(
        "report_template.Rmd",
        output_file = tempReport,
        params = tempParams,
        envir = new.env(parent = globalenv())
      )
      
      # Convert the HTML to PDF
      pagedown::chrome_print(tempReport, output = file)
    }
  )
  
  onSessionEnded(function() {
    dbDisconnect(conn)
  })
}

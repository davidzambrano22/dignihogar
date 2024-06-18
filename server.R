library(shiny)
library(DBI)
library(rmarkdown)
library(pagedown)
library(shinydashboard)

source("UI/home.R")
source("UI/data_policy.R")
source("UI/info_trabajador.R")
source("UI/info_empleador.R")
source("UI/info_funciones.R")
source("UI/info_salario.R")
source("UI/contrato_dependiente.R")
source("UI/contrato_independiente.R")

server <- function(input, output, session) {
  conn <- dbConnect(RSQLite::SQLite(), "user_data.sqlite")
  dbExecute(conn, "CREATE TABLE IF NOT EXISTS users_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombreTrabajador TEXT,
            apellidosTrabajador TEXT ,
            tipoDocTrabajador TEXT,
            numeroDocumentoTrabajador TEXT,
            ciudadTrabajador TEXT,
            direccionTrabajador TEXT,
            correoTrabajador TEXT,
            duracionContrato TEXT,
            nombreEmpleador TEXT,
            apellidosEmpleador TEXT,
            tipoDocEmpleador TEXT,
            numeroDocumentoEmpleador TEXT,
            ciudadEmpleador TEXT,
            direccionEmpleador TEXT,
            correoEmpleador TEXT,
            lugarPrestacion TEXT,
            direccionTrabajo TEXT,
            funcionesTrabajador TEXT  DEFAULT \"No responde\",
            funcionesAdicionales TEXT,
            modalidadTrabajo TEXT,
            tipoVinculacion TEXT,
            encargadoSeguridad TEXT DEFAULT \"No aplica\",
            salario INTEGER DEFAULT 0, 
            beneficios TEXT DEFAULT \"No responde\",
            horarioLaboral TEXT,
            diasTrabajo INTEGER DEFAULT 0,
            tiempoPago TEXT,
            modalidadPago TEXT,
            numeroCuenta TEXT DEFAULT \"No aplica\",
            tipoCuenta TEXT DEFAULT \"No aplica\",
            banco TEXT DEFAULT \"No aplica\"
            )")
  
  # Reactive value to control the visibility of the download and data policy agreed buttons
  home <- reactiveVal(TRUE)
  goToDataPolicy <- reactiveVal(FALSE)
  goDatapolycyToHome <- reactiveVal(FALSE)
  dataPolicyAgreed <- reactiveVal(FALSE)
  submit_infoTrabajador <- reactiveVal(FALSE)
  goBackWorkerInfo <- reactiveVal(FALSE)
  submit_infoEmpleador <- reactiveVal(FALSE)
  goBackEmployerInfo <- reactiveVal(FALSE)
  submit_infoEmpleo_1 <- reactiveVal(FALSE)
  goBackFuncionesInfo <- reactiveVal(FALSE)
  submit_infoEmpleo_2 <- reactiveVal(FALSE)
  goBackSalarioInfo <- reactiveVal(FALSE)
  submit_infoEmpleo_2 <- reactiveVal(FALSE)
  goBackContractInfo <- reactiveVal(FALSE)
  seen_contract <- reactiveVal(FALSE)
  
  # Initialize the page_content with a welcome message
  observeEvent(home(), {
    if (home()){
      goDatapolycyToHome(FALSE)
      homeUI(output)
      }
    }
  )
 
  observeEvent(input$go_dataPolicy, {
    goToDataPolicy(TRUE)
  })
  
  observeEvent(goToDataPolicy(), {
    if (goToDataPolicy()) {
      dataPolicyUI(output)
    }
  })
  
  observeEvent(input$tratamiento_datos, {
    goToDataPolicy(FALSE)
    dataPolicyAgreed(TRUE)
  })
  
  observeEvent(input$volver_home, {
    goToDataPolicy(FALSE)
    goDatapolycyToHome(TRUE)
  })
  
  observeEvent(goDatapolycyToHome(), {
    if (goDatapolycyToHome()) {
      homeUI(output)
    }
  })
  
  observeEvent(dataPolicyAgreed(), {
    if (dataPolicyAgreed()) {
      infoTrabajadorUI(output)
    }
  })
  
  ######################## Go Back To Data Policy #######################
  observeEvent(input$volver_dataPolicy, {
    dataPolicyAgreed(FALSE)
    goBackWorkerInfo(TRUE)
  })
  
  observeEvent(goBackWorkerInfo(), {
    if (goBackWorkerInfo()) {
      dataPolicyUI(output)
    }
  })
  
  ######################## Check Worker info Anwers #######################
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


  ######################## Go  To Info Employer #######################
  observeEvent(submit_infoTrabajador(), {
    if (submit_infoTrabajador()) {
      output$error_message <- renderText({ "" })
      info_empleadorUI(output)
    }
  })
  
  ######################## Check Employer info Answers #######################
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

  ######################## Go Back To Info Worker #######################
  observeEvent(input$volver_datosTrabajador, {
    submit_infoTrabajador(FALSE)
    goBackEmployerInfo(TRUE)
  })
  
  observeEvent(goBackEmployerInfo(), {
    if (goBackEmployerInfo()) {
      infoTrabajadorUI(output)
    }
  })
  
  
  ######################## Go  To Funciones Info #######################
  observeEvent(submit_infoEmpleador(), {
    if (submit_infoEmpleador()) {
      output$error_message <- renderText({ "" })
      funcionesUI(output)
    }
  })
  
  output$out_respuestaDias <- renderUI({
    if (input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)"){
      tagList(
      selectInput("respuesta_dias", "**Si su respuesta es por días** ¿Quién será el encargado de realizar los trámites de seguridad social?",
                  choices = c(
                    "El Trabajador",
                    "El Empleador"
                  ),
                  width = "600px"),
      tags$p("**Tenga en cuenta que en cualquiera de los casos ambos deben aportar para el pago de seguridad y parafiscales del empleado.", style = "font-size: 18px;"),
      )
    }
  })
  

  ######################## Go Back To Info Employer #######################
  observeEvent(input$volver_datosEmpleador, {
    submit_infoEmpleador(FALSE)
    goBackFuncionesInfo(TRUE)
  })
  
  observeEvent(goBackFuncionesInfo(), {
    if (goBackFuncionesInfo()) {
      info_empleadorUI(output)
    }
  })
  
  
  observeEvent(input$datos_empleo_1, {
    submit_infoEmpleo_1(TRUE)
  })

  ######################## Go To Info Salario Y Beneficios #######################
  observeEvent(submit_infoEmpleo_1(), {
    if (submit_infoEmpleo_1()){
      output$error_message <- renderText({ "" })
      salarioUI(output)
    }
  })
  
  output$tipo_pago <- renderUI({
    if (input$modalidad_pagos == "A traves de una cuenta bancaria"){
      tagList(
        textInput("numero_cuenta", "Ingrese el número de la cuenta bancaria", value = "A"),
        textInput("tipo_cuenta", "Ingrese el tipo de cuenta bancaria", value = "A"),
        textInput("banco", "Ingrese el banco", value = "A")
      )
    }
  })
  
 
  ######################## Check Salario Answers #######################
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

  ######################## Go Back To Info Funciones #######################
  observeEvent(input$volver_datosEmpleo1, {
    submit_infoEmpleo_1(FALSE)
    goBackSalarioInfo(TRUE)
  })
  
  observeEvent(goBackSalarioInfo(), {
    if (goBackSalarioInfo()) {
      funcionesUI(output)
    }
  })

  ######################## Go To Info Contrato #######################
  observeEvent(submit_infoEmpleo_2(), {
    if (submit_infoEmpleo_2()){
      output$error_message <- renderText({ "" })
      
      
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" || input$tipo_vinculacion == "Fija (es decir el trabajador de servicio domestica trabaja en un solo hogar varios días a la semana" || input$respuesta_dias == "El Empleador") {
        contratoDependienteUI(input, output)
      }
      else if (input$respuesta_dias == "El Trabajador") {
        contratoIndependienteUI(input, output)
      }
    }
  })
  
  
  # Create cotract PDF to dowload
  output$download_contrato_pdf <- downloadHandler(
    filename = function() {
      paste("user_info", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" || input$tipo_vinculacion == "Fija (es decir el trabajador de servicio domestica trabaja en un solo hogar varios días a la semana" || input$respuesta_dias == "El Empleador"){
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "report.html")
        tempParams <- list(nombres_trabajador = toupper(input$nombres_trabajador),
                           apellidos_trabajador = toupper(input$apellidos_trabajador),
                           nombres_empleador  = toupper(input$nombres_empleador),
                           apellidos_empleador = toupper(input$apellidos_empleador)
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          "report_template.Rmd",
          output_file = tempReport,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        
        # Convert the HTML to PDF
        pagedown::chrome_print(tempReport, output = file)
        
      } else if (input$respuesta_dias == "El Trabajador") {
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "report.html")
        tempParams <- list(nombres_trabajador = toupper(input$nombres_trabajador),
                           apellidos_trabajador = toupper(input$apellidos_trabajador),
                           nombres_empleador  = toupper(input$nombres_empleador),
                           apellidos_empleador = toupper(input$apellidos_empleador)
        )
        
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
    }
  )
  
  ######################## Go Back To Info Salario y Beneficios #######################
  observeEvent(input$volver_datosEmpleo2, {
    submit_infoEmpleo_2(FALSE)
    goBackContractInfo(TRUE)
  })
  
  observeEvent(goBackContractInfo(), {
    if (goBackContractInfo()) {
      salarioUI(output)
    }
  })
  
  
  observeEvent(input$go_infoTable, {
    seen_contract(TRUE)
  })
  

  observeEvent(seen_contract(), {
    if (seen_contract()){
      
      output$error_message <- renderText({ "" })
      
      if (input$modalidad_pagos == "A traves de una cuenta bancaria"){
        # Write info to the database
        dbExecute(conn, "INSERT INTO users_data (
            nombreTrabajador,
            apellidosTrabajador,
            tipoDocTrabajador,
            numeroDocumentoTrabajador,
            ciudadTrabajador,
            direccionTrabajador,
            correoTrabajador,
            duracionContrato,
            nombreEmpleador,
            apellidosEmpleador,
            tipoDocEmpleador,
            numeroDocumentoEmpleador,
            ciudadEmpleador,
            direccionEmpleador,
            correoEmpleador,
            lugarPrestacion,
            direccionTrabajo,
            modalidadTrabajo,
            funcionesTrabajador,
            funcionesAdicionales,
            tipoVinculacion,
            encargadoSeguridad,
            salario,
            beneficios,
            horarioLaboral,
            diasTrabajo,
            tiempoPago,
            modalidadPago,
            numeroCuenta,
            tipoCuenta,
            banco) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                  params = list(input$nombres_trabajador,
                                input$apellidos_trabajador,
                                input$tipo_documento_trabajador,
                                input$numero_documento_trabajador,
                                input$ciudad_trabajador,
                                input$direccion_trabajador,
                                input$correo_trabajador,
                                input$duracion_contrato, #8
                                input$nombres_empleador,
                                input$apellidos_empleador,
                                input$tipo_documento_empleador,
                                input$numero_documento_empleador,
                                input$ciudad_empleador,
                                input$direccion_empleador,
                                input$correo_empleador,
                                input$lugar_prestacion_servicios,
                                input$direccion_trabajo, #17
                                input$modalidad_prestacion_servicios,
                                paste(input$funciones_trabajador, collapse = ','),
                                input$funciones_adicionales, #19
                                input$tipo_vinculacion,
                                input$respuesta_dias,
                                input$salario_mensual,
                                input$beneficios,
                                input$horario_laboral,
                                input$días_trabajo,
                                input$tiempo_pagos,
                                input$modalidad_pagos,
                                input$numero_cuenta,
                                input$tipo_cuenta,
                                input$banco
                  )
        )
      } else {
        # Write info to the database
        dbExecute(conn, "INSERT INTO users_data (
            nombreTrabajador,
            apellidosTrabajador,
            tipoDocTrabajador,
            numeroDocumentoTrabajador,
            ciudadTrabajador,
            direccionTrabajador,
            correoTrabajador,
            duracionContrato,
            nombreEmpleador,
            apellidosEmpleador,
            tipoDocEmpleador,
            numeroDocumentoEmpleador,
            ciudadEmpleador,
            direccionEmpleador,
            correoEmpleador,
            lugarPrestacion,
            direccionTrabajo,
            modalidadTrabajo,
            funcionesTrabajador,
            funcionesAdicionales,
            tipoVinculacion,
            encargadoSeguridad,
            salario,
            beneficios,
            horarioLaboral,
            diasTrabajo,
            tiempoPago,
            modalidadPago) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                  params = list(input$nombres_trabajador,
                                input$apellidos_trabajador,
                                input$tipo_documento_trabajador,
                                input$numero_documento_trabajador,
                                input$ciudad_trabajador,
                                input$direccion_trabajador,
                                input$correo_trabajador,
                                input$duracion_contrato, #8
                                input$nombres_empleador,
                                input$apellidos_empleador,
                                input$tipo_documento_empleador,
                                input$numero_documento_empleador,
                                input$ciudad_empleador,
                                input$direccion_empleador,
                                input$correo_empleador,
                                input$lugar_prestacion_servicios,
                                input$direccion_trabajo, #17
                                input$modalidad_prestacion_servicios,
                                paste(input$funciones_trabajador, collapse = ','),
                                input$funciones_adicionales, #19
                                input$tipo_vinculacion,
                                input$respuesta_dias,
                                input$salario_mensual,
                                input$beneficios,
                                input$horario_laboral,
                                input$días_trabajo,
                                input$tiempo_pagos,
                                input$modalidad_pagos
                  )
        )
      }
      
      
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)"){
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
            ),
            div(style = "height: 60px;"),
            div(style = "text-align: justify;",
                column(5),
                column(6,
                       downloadButton("download_plantilla_pdf", "Descargue la plantilla", style = "font-size: 20px; text-align: center;")
                )
            ),
            div(style="height: 50px;"),
          )
        })
        
      } else if (input$tipo_vinculacion == "Fija (es decir el trabajador de servicio domestica trabaja en un solo hogar varios días a la semana" || (input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "El Empleador")){
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
              div(style="height: 30px;"),
              style = "font-size: 21px;"
            ),
            div(style = "text-align: justify;",
                 column(5),
                 column(6,
                        downloadButton("download_plantilla_pdf", "Descargue la plantilla", style = "font-size: 20px; text-align: center;")
                 )
            ),
            div(style="height: 50px;"),
          )
        })
        
      } else if (input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "El Trabajador") {
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
            tags$br(),
            tags$br(),
            tags$br(),
            tags$br(),
            tags$h2(tags$b("Plantilla Educativa"), style = "text-align: center;"),
            tags$br(),
            tags$br(),
            tags$p(tags$b("Salario acordado sin beneficios ni deducciones:", style = "font-size: 21px; text-align: justify;"), "$", input$salario_mensual, style = "font-size: 21px; text-align: justify;"),
            
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
                  tags$td(style = "border: 1px solid black; padding: 8px;", ""),
                  tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.125)
                ),
                tags$tr(
                  tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Pensión")),
                  tags$td(style = "border: 1px solid black; padding: 8px;", ""),
                  tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.16)
                ),
                tags$tr(
                  tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("ARL* (tipo 1)")),
                  tags$td(style = "border: 1px solid black; padding: 8px;", ""),
                  tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.00052)
                ),
                tags$tr(
                  tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Caja de compensación (opcional)")),
                  tags$td(style = "border: 1px solid black; padding: 8px;", ""),
                  tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.03)
                )
              ),
              style = "font-size: 21px;"
            ),
            div(style="height: 30px;"),
            tags$br(),
            tags$p("El trabajador se compromete a realizar el pago de la planilla correspondiente según sus salarios mensuales ", style = "font-size: 21px;"),
            tags$br(),
            tags$b(sprintf("Salario neto que recibirá el trabajador: %d", (input$salario_mensual - (as.numeric(input$salario_mensual) * 0.04))), style = "font-size: 21px; text-align: justify;"),
            div(style="height: 30px;"),
            tags$b("Beneficios:", style = "font-size: 21px;"),
            tags$ul(
              tags$li("Incapacidades y licencias de maternidad cubiertas con la EPS"),
              tags$li("Acuerdos sobre tiempo de periodo de prueba."),
              div(style="height: 30px;"),
              style = "font-size: 21px;"
            ),
            div(style = "text-align: justify;",
                column(5),
                column(6,
                       downloadButton("download_plantilla_pdf", "Descargue la plantilla", style = "font-size: 20px; text-align: center;")
                )
            ),
            div(style="height: 50px;"),
          )
        })
      }
      
    }
    })

  
  onSessionEnded(function() {
    dbDisconnect(conn)
  })
}

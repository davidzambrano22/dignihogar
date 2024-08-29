library(shiny)
library(DBI)
library(rmarkdown)
library(pagedown)
library(shinydashboard)
library(htmlwidgets)
library(slickR)

source("UI/home.R")
source("UI/data_policy.R")
source("UI/info_trabajador.R")
source("UI/info_empleador.R")
source("UI/info_funciones.R")
source("UI/info_salario.R")
source("UI/contrato_dependiente.R")
source("UI/contrato_independiente.R")
source("UI/plantilla_diasIndependiente.R")
source("UI/plantilla_fija.R")
source("UI/platilla_interna.R")

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
  goBackPlantillatInfo <- reactiveVal(FALSE)
  
  # Initialize the page_content with a welcome message

  
  output$image_slider <- renderSlickR({
    # List of image paths in the www directory
    images <- list.files("www/slider_2/", pattern = "\\.jpg$", full.names = TRUE)
    slickR(images) +
      settings(
        autoplay = TRUE,      # Enable autoplay
        autoplaySpeed = 2000, # Time between slides in milliseconds
        dots = TRUE,          # Show navigation dots
        infinite = TRUE,      # Infinite loop
        speed = 500,          # Transition speed in milliseconds
        slidesToShow = 1,     # Number of slides to show at once
        slidesToScroll = 1    # Number of slides to scroll at once
      )
  })
  
  observeEvent(home(), {
    if (home()){
      goDatapolycyToHome(FALSE)
      # Poner los demás en falso también, puede ser eso ###############################################################################################################
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
      output$error_message <- renderText({ "**El campo Nombres  no puede estar vacío" })
      return(NULL)
    }
    else if (input$apellidos_trabajador == ""){
      output$error_message <- renderText({ "**El campo Apellidos  no puede estar vacío" })
      return(NULL)
    }
    else if (input$tipo_documento_trabajador == ""){
      output$error_message <- renderText({ "**El campo Número de documento no puede estar vacío" })
      return(NULL)
    }
    else if (input$ciudad_trabajador == ""){
      output$error_message <- renderText({ "**El campo Ciudad no puede estar vacío" })
      return(NULL)
    }
    else if (input$direccion_trabajador == ""){
      output$error_message <- renderText({ "**El campo Dirección no puede estar vacío" })
      return(NULL)
    }
    else if (input$correo_trabajador == "" ){
      output$error_message <- renderText({ "**El campo Correo electrónico no puede estar vacío" })
      return(NULL)
    }
    else if (!grepl("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", input$correo_trabajador)){
      output$error_message <- renderText({ "*Ingrese un correo electrónico válido" })
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
      output$error_message <- renderText({ "**El campo Nombres no puede estar vacío*" })
      return(NULL)
    }
    else if (input$apellidos_empleador == ""){
      output$error_message <- renderText({ "**El campo Apellidos  no puede estar vacío*" })
      return(NULL)
    }
    else if (input$numero_documento_empleador == ""){
      output$error_message <- renderText({ "**El campo Número de documento no puede estar vacío*" })
      return(NULL)
    }
    else if (input$ciudad_empleador == ""){
      output$error_message <- renderText({ "**El campo Ciudad no puede estar vacío*" })
      return(NULL)
    }
    else if (input$direccion_empleador == ""){
      output$error_message <- renderText({ "**El campo Dirección no puede estar vacío*" })
      return(NULL)
    }
    else if (input$correo_empleador == ""){
      output$error_message <- renderText({ "**El campo Correo electrónico no puede estar vacío*" })
      return(NULL)
    }
    else if (!grepl("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", input$correo_empleador)){
      output$error_message <- renderText({ "**Ingrese un correo electrónico válido*" })
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
    if (input$tipo_vinculacion == "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)"){
      tagList(
      selectInput("respuesta_dias", "**Dado que su respuesta es por días** ¿Quién será el encargado de realizar los trámites y pagos de seguridad social?",
                  choices = c(
                    "La persona trabajadora doméstica",
                    "La persona empleadora"
                  ),
                  width = "600px"),
      tags$p("**Tenga en cuenta que la selección del tipo de vinculación determinará quién es responsable de los trámites relacionados con la seguridad social y parafiscales. Es fundamental que ambas partes comprendan sus obligaciones para garantizar el cumplimiento adecuado de todas las normativas laborales.", style = "font-size: 18px;"),
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
    # if (input$beneficios == "") {
    #   output$error_message <- renderText({ "**El campo Beneficios  no puede estar vacío" })
    #   return(NULL)
    # }
    if (input$horario_laboral == ""){
      output$error_message <- renderText({ "**El campo Horario laboral  no puede estar vacío" })
      return(NULL)
    }
    else if (input$días_trabajo < 1 || input$días_trabajo > 31) {
      output$error_message <- renderText({ "**Por favor ingrese un valor entre 1 y 31 para el campo Días de trabajo" })
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
      
      print(input$funciones_trabajador)
      
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" && input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana") {
        contratoDependienteUI(input, output)
      }
      
      else if (input$modalidad_prestacion_servicios == "Externa (no vivirá en la residencia de prestación de los servicios)" && input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana") {
        contratoDependienteUI(input, output)
      }
      
      else if (input$respuesta_dias == "La persona empleadora") {
        contratoDependienteUI(input, output)
      }
      
      else if (input$respuesta_dias == "La persona trabajadora doméstica") {
        contratoIndependienteUI(input, output)
      }
      
      # else if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" && input$respuesta_dias == "La persona trabajadora doméstica") {
      #   contratoIndependienteUI(input, output)
      # }
    }
  })
  
  
  # Create cotract PDF to dowload
  output$download_contrato_pdf <- downloadHandler(
    filename = function() {
      paste("modelo_contrato", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" || input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana)" || input$respuesta_dias == "La persona empleadora"){
        
        date <- strsplit(as.character(Sys.Date()), "-")
        months <- list("01" = "enero",
                       "02" = "febrero",
                       "03" = "marzo",
                       "04" = "abril",
                       "05" = "mayo",
                       "06" = "junio",
                       "07" = "julio",
                       "08" = "agosto",
                       "09" = "septiembre",
                       "10" = "octubre",
                       "11" = "noviembre",
                       "12" = "diciembre"
        )
        
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "contrato_dependiente.Rmd")
        file.copy("contrato_dependiente.Rmd", tempReport, overwrite = T)
        tempParams <- list(nombres_trabajador = toupper(input$nombres_trabajador),
                           apellidos_trabajador = toupper(input$apellidos_trabajador),
                           nombres_empleador  = toupper(input$nombres_empleador),
                           apellidos_empleador = toupper(input$apellidos_empleador),
                           direccion_trabajo = toupper(input$direccion_trabajo),
                           salario_mensual = input$salario_mensual,
                           tiempo_pagos = input$tiempo_pagos,
                           modalidad_pagos = tolower(input$modalidad_pagos),
                           dia = date[[1]][3],
                           mes = months[[date[[1]][2]]],
                           ano = date[[1]][1],
                           dia_inicio = strsplit(as.character(input$fecha_inicio), "-")[[1]][3],
                           mes_inicio = months[[strsplit(as.character(input$fecha_inicio), "-")[[1]][2]]],
                           ano_inicio = strsplit(as.character(input$fecha_inicio), "-")[[1]][1]
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          tempReport,
          output_file = file,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        # Set the maximum attempts to find headless Chrome
        # options(pagedown.remote.maxattempts = 200)
        # options(pagedown.remote.sleeptime=2)
        # # Convert the HTML to PDF
        # pagedown::chrome_print(tempReport, output = file, timeout = 30,  verbose = TRUE)

        
      } else if (input$respuesta_dias == "La persona trabajadora doméstica") {
        
        date <- strsplit(as.character(Sys.Date()), "-")
        months <- list("01" = "enero",
                       "02" = "febrero",
                       "03" = "marzo",
                       "04" = "abril",
                       "05" = "mayo",
                       "06" = "junio",
                       "07" = "julio",
                       "08" = "agosto",
                       "09" = "septiembre",
                       "10" = "octubre",
                       "11" = "noviembre",
                       "12" = "diciembre"
        )
        
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "contrato_independiente.Rmd")
        file.copy("contrato_independiente.Rmd", tempReport, overwrite = T)
        tempParams <- list(nombres_trabajador = toupper(input$nombres_trabajador),
                           apellidos_trabajador = toupper(input$apellidos_trabajador),
                           nombres_empleador  = toupper(input$nombres_empleador),
                           apellidos_empleador = toupper(input$apellidos_empleador),
                           direccion_trabajo = toupper(input$direccion_trabajo),
                           salario_mensual = input$salario_mensual,
                           tiempo_pagos = input$tiempo_pagos,
                           modalidad_pagos = tolower(input$modalidad_pagos),
                           dia = date[[1]][3],
                           mes = months[[date[[1]][2]]],
                           ano = date[[1]][1],
                           dia_inicio = strsplit(as.character(input$fecha_inicio), "-")[[1]][3],
                           mes_inicio = months[[strsplit(as.character(input$fecha_inicio), "-")[[1]][2]]],
                           ano_inicio = strsplit(as.character(input$fecha_inicio), "-")[[1]][1]
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          tempReport,
          output_file = file,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        # # Set the maximum attempts to find headless Chrome
        # options(pagedown.remote.maxattempts = 200)
        # options(pagedown.remote.sleeptime=2)
        # # Convert the HTML to PDF
        # pagedown::chrome_print(tempReport, output = file, timeout = 30,  verbose = TRUE)
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
        plantillaInternaUI(input, output) # Se descarga
        
      } else if (input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana" || (input$tipo_vinculacion == "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "La persona empleadora")){
        plantillaFijaUI(input, output) # No se descarga
        
      } else if (input$tipo_vinculacion == "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "La persona trabajadora doméstica") {
        plantillaDiasUI(input, output)  # No se descarga
      }
      
    }
    })
  
  
  # Create plantilla PDF to dowload
  output$download_plantilla_pdf <- downloadHandler(

    filename = function() {
      paste("plantilla_educativa", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      
      # Define subsidio transporte value
      if (as.numeric(input$salario_mensual) < 1300000 || input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)") {
        subsidio_transporte <- 162000
      } else {
        subsidio_transporte <- 0
      }
      
      
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)"){
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "plantilla_interna.Rmd")
        file.copy("plantilla_interna.Rmd", tempReport, overwrite = T)
        tempParams <- list(
                           salario_mensual = input$salario_mensual,
                           subsidio_transporte = subsidio_transporte
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          tempReport,
          output_file = file,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        
        # Convert the HTML to PDF
        # pagedown::chrome_print(tempReport, output = file, timeout = 120)
        
      } else if (input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana" || (input$tipo_vinculacion == "Por días (es decir el trabajador de servicios domestico trabaja en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "La persona empleadora")){
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "plantilla_fija.Rmd")
        file.copy("plantilla_fija.Rmd", tempReport, overwrite = T)
        tempParams <- list(
                           salario_mensual = input$salario_mensual,
                           subsidio_transporte = subsidio_transporte
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          tempReport,
          output_file = file,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        
        # Convert the HTML to PDF
        # pagedown::chrome_print(tempReport, output = file, timeout = 120)
        
      } else if (input$tipo_vinculacion == "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)" && input$respuesta_dias == "La persona trabajadora doméstica") {
        # Create a temporary HTML file
        tempReport <- file.path(tempdir(), "plantilla_diasIndependiente.Rmd")
        file.copy("plantilla_diasIndependiente.Rmd", tempReport, overwrite = T)
        tempParams <- list(
                           salario_mensual = input$salario_mensual,
                           subsidio_transporte = subsidio_transporte
        )
        
        # Render the RMarkdown document to HTML
        rmarkdown::render(
          tempReport,
          output_file = file,
          params = tempParams,
          envir = new.env(parent = globalenv())
        )
        
        # Convert the HTML to PDF
        # pagedown::chrome_print(tempReport, output = file, timeout = 120)
      }
    }
  )
  
  ######################## Go Back To Info Contrato #######################
  observeEvent(input$volver_plantilla, {
    seen_contract(FALSE)
    goBackPlantillatInfo(TRUE)
  })
  
  observeEvent(goBackPlantillatInfo(), {
    if (goBackPlantillatInfo()) {
      if (input$modalidad_prestacion_servicios == "Interna (vivirá en la residencia en que preste sus servicios)" || input$tipo_vinculacion == "Fija (es decir, la persona trabajadora doméstica que labora en un solo hogar varios días a la semana" || input$respuesta_dias == "La persona empleadora") {
        contratoDependienteUI(input, output)
      }
      else if (input$respuesta_dias == "La persona trabajadora doméstica") {
        contratoIndependienteUI(input, output)
      }
    }
  })

  
  onSessionEnded(function() {
    dbDisconnect(conn)
  })
  
  ## Download database
  output$downloadData <- downloadHandler(
    filename = function() {
      "database.sqlite"
    },
    content = function(file) {
      file.copy("user_data.sqlite", file)
    }
  )
  
}

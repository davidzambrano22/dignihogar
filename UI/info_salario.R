
salarioUI <- function(output){
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
        h2(tags$b("Información de salario y beneficios"), style = "text-align: center;")
      ),
      div(style = "height: 30px"),
      div(style = "font-size: 20px;",
          column(6, offset = 3,
                 numericInput("salario_mensual",
                              "Salario mensual que se pagará al trabajador de servicio doméstico (en pesos, sin incluir auxilio de transporte, ni los beneficios):",
                              value = 1800000,
                              width = "600px"),
                 textInput("beneficios",
                           "Si existe algún pago o beneficio (vivienda, alimentación, medicina prepagada, etc.) que no haga parte del salario del trabajador de servicio doméstico, indíquelo acá:",
                           value = "A",
                           width = "600px"),
                 textInput("horario_laboral",
                           "Especifique el horario laboral: ej. Lunes a viernes de 8am a 5pm (Recuerde que el horario no debe superar las 8 horas diarias)",
                           value = "A",
                           width = "600px"),
                 numericInput("días_trabajo", "¿Cuántos días trabajará al mes?", value = 23, width = "600px"),
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
                 uiOutput("tipo_pago"),
                 div(style = "height: 50px;"),
                 fluidRow(style = "text-align: justify;",
                          column(1, offset = 2,
                                 actionButton("volver_datosEmpleo1", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
                          ),
                          column(2),
                          column(1, offset = 3, 
                                 actionButton("datos_empleo_2", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
                          )
                 ),
                 div(style = "height: 80px;")
          )
      )
    )
  })
}
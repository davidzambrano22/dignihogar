
salarioUI <- function(output){
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
                        h2(tags$b("Información de salario y beneficios"), style = "text-align: center; font-size: 35px;"),
                        div(style = "height: 30px"),
                        p("Para generar su plantilla de contrato, por favor complete la siguiente información. Asegúrese de proporcionar todos los datos solicitados para garantizar que el contrato refleje correctamente los términos y condiciones acordados.", style = "font-size: 20px; text-align: center;"),
                        div(style = "height: 50px"),
                 ),
                 div(style = "font-size: 20px;",
                     column(6, offset = 3,
                            numericInput("salario_mensual",
                                         "Salario que se le pagará a la persona trabajadora doméstica por su servicio (en pesos, sin incluir auxilio de transporte, ni los beneficios):",
                                         value = NULL,
                                         width = "600px"),
                            textInput("beneficios",
                                      "Si existe algún pago o beneficio (vivienda, alimentación, medicina prepagada, etc.) que no haga parte del salario de la persona trabajadora doméstica, indíquelo acá:",
                                      value = "",
                                      width = "600px"),
                            textInput("horario_laboral",
                                      "Especifique el horario laboral: ej. Lunes a viernes de 8am a 5pm (Recuerde que el horario no debe superar las 8 horas diarias)",
                                      value = "",
                                      width = "600px"),
                            numericInput("días_trabajo", "¿Cuántos días trabajará al mes?", value = NULL, width = "600px"),
                            selectInput("tiempo_pagos", "¿Cada cuánto se realizará el pago del salario?:",
                                        choices = c(
                                          "Quincenal (el 15 y 30 de cada mes)",
                                          "Mensual (un día acordado al mes)",
                                          "Diariamente (Por día laborado)"
                                        ),
                                        width = "600px"
                                        
                            ),
                            selectInput("modalidad_pagos", "¿Cómo se realizará el pago del salario?:",
                                        choices = c(
                                          "En efectivo",
                                          "A través de una cuenta bancaria"
                                        ), width = "600px"
                                        
                            ),
                            uiOutput("tipo_pago"),
                            textOutput("error_message"),
                            div(style = "height: 50px;")
                     )
                 )
        )
      ),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4, 
                      actionButton("volver_datosEmpleo1", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1, 
                      actionButton("datos_empleo_2", "Enviar >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") 
               )
      ),
      div(style = "height: 80px;")
    )
  })
}

contratoIndependienteUI <- function(input, output){
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
        column(8, offset = 2,
          wellPanel(
          div(style = "height: 60px"),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$h2(sprintf("CONTRATO DE TRABAJO ENTRE %s %s y %s %s INDEPENDIENTE",
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
            sprintf("Parágrafo 1. El EMPLEADOR deberá pagar al TRABAJADOR todas las prestaciones sociales establecidas por ley.", toupper(input$tiempo_pagos), toupper(input$modalidad_pagos)),
            style = "font-size: 21px; text-align: justify;"
          ),
          tags$p(
            sprintf("Parágrafo 2. El TRABAJADOR De igual forma, deberá hacer los aportes de seguridad social en salud, pensión y riesgos laborales, en proporción a los días trabajados y conforme al salario recibido.  Esto sin perjuicio que el trabajador esté afiliado al Sisbén.", toupper(input$tiempo_pagos), toupper(input$modalidad_pagos)),
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
                            tags$li("Pagar en la forma prevista al TRABAJADOR el salario."),
                            tags$li("Respetar las condiciones.")
                          ),
                          style = "font-size: 21px;"
                  ),
                  tags$li("Obligaciones del TRABAJADOR:",
                          tags$ul(
                            tags$li("Recibir, según lo pactado, el salario"),
                            tags$li("Desempeñar las actividades propias del objeto, entre las cuales se encuentran Barrer, trapear y encerar pisos de instalaciones domésticas. Limpiar, brillar y sellar, puertas, muebles, ventanas y otros accesorios de instalaciones domésticas. Lavar, planchar y remendar lencería, ropa de cama y prendas de uso personal. Preparar, cocinar y servir alimentos y bebidas en instalaciones domésticas. Lavar vajillas y utensilios de cocina en instalaciones domésticas. Lavar, desinfectar y desodorizar cocinas, cuartos de baño, muebles y enseres en casas de familia. Tender camas, cambiar sábanas, poner toallas limpias y artículos de tocador en instalaciones domésticas. Desempolvar y aspirar muebles, alfombras, tapetes, cortinas y tapizados en instalaciones domésticas.")
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
            column(2, offset=1,
                   tags$hr(style = "border: none; border-top: 1px solid #000; width: 300px;"),
                   tags$p(paste(input$nombres_empleador, input$apellidos_empleador), style = "font-size: 21px;")
            ),
            column(2, offset=4,
                   tags$hr(style = "border: none; border-top: 1px solid #000; width: 300px;"),
                   tags$p(paste(input$nombres_trabajador, input$apellidos_trabajador), style = "font-size: 21px;")
            )
          ),
          div(style="height: 200px;"),
          fluidRow(
            div(style = "text-align: center;",
                column(4, offset =4,
                       wellPanel(
                         downloadButton("download_contrato_pdf", "Descargue el contrato", style = "font-size: 20px; text-align: center;"),
                         style = "border-color: #333;"
                       )
                )
            )
          )
          ),
          div(style="height: 70px;"),
          fluidRow(
            column(1, offset = 3, 
                   actionButton("volver_datosEmpleo2", "<< Volver", style = "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") 
            ),
            column(3),
            column(1, 
                   actionButton("go_infoTable", "Continuar >>", style = "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") 
            )
          ),
          div(style="height: 100px;")
      )
    )
  })
}
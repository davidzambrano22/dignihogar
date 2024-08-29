
contratoDependienteUI <- function(input, output){
  
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
  
  
  funciones_adicionales <- strsplit(input$funciones_adicionales, split = ",")[[1]]
  
  
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
      div(style = "height: 80px"),
      column(8, offset = 2,
             wellPanel(
               fluidRow(style = "background: white;",
                 div(style = "height: 100px"),
                 column(1),
                 column(10,
                 tags$h2(sprintf("CONTRATO LABORAL ENTRE %s %s y %s %s",
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
                 tags$p("Parágrafo 1. El EMPLEADOR deberá pagar al TRABAJADOR todas las prestaciones de seguridad social establecidas por ley: salud, pensión, ARL, cesantías, prima, vacaciones y auxilio de transporte. El pago de dichas prestaciones se hará en proporción a los días trabajados y conforme al salario recibido.",
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
                                   tags$li("Desempeñar las actividades propias del objeto, entre las cuales se encuentran:")
                                 ),
                                 tags$ul(lapply(input$funciones_trabajador, function(choice){
                                   tags$li(choice)})
                                 ),
                                 tags$ul(lapply(strsplit(input$funciones_adicionales, split = ",")[[1]], function(choice){
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
                 tags$p(tags$b("Sexta:", style = "font-size: 21px;"), sprintf("Vigencia. Este contrato estará vigente a partir de  %s del mes de %s del %s.", strsplit(as.character(input$fecha_inicio), "-")[[1]][3], months[[strsplit(as.character(input$fecha_inicio), "-")[[1]][2]]], strsplit(as.character(input$fecha_inicio), "-")[[1]][1]),
                        style = "font-size: 21px; text-align: justify;"),
                 
                 tags$p(sprintf("Se firma a los %s del mes de %s del %s.", date[[1]][3], months[[date[[1]][2]]], date[[1]][1]), style = "font-size: 21px; text-align: justify;"),
                 
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
                 div(style="height: 150px;"),
                 ),
                 div(style="height: 100px;"),
                 fluidRow(
                   div(style = "text-align: center;",
                       column(4, offset =4,
                              downloadButton("download_contrato_pdf", "Descargue el contrato", style = "font-size: 20px; text-align: center;")
                       )
                   )
                 ),
                 div(style="height: 50px;"),
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
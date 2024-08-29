

plantillaInternaUI <- function(input, output){
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
      column(8, offset = 2,
           wellPanel(
             fluidRow(style = "background: white;",
               div(style = "height: 60px"),
               tags$h2(tags$b("Composición de los pagos a Seguridad Social"), style = "text-align: center;"),
               div(style = "height: 30px"),
               
               column(2),
               column(8,
                      p("A continuación, se presenta una tabla que detalla la distribución de las contribuciones a la seguridad social. La tabla muestra los valores que corresponden a la persona que emplea y a la persona trabajadora en relación a conceptos de cotización, basados en el salario  proporcionado.", style = "font-size: 20px; text-align: justify;"),
                      div(style = "height: 50px"),
                      tags$p(tags$b("Salario acordado sin beneficios ni deducciones:", style = "font-size: 21px; text-align: justify;"), "$", input$salario_mensual, style = "font-size: 21px; text-align: justify;"),
                      conditional_paragraph <- if (as.numeric(input$salario_mensual) < 2600000 || input$tipo_vinculacion == "Por días (es decir, la persona trabajadora doméstica que labora en diferentes hogares a la semana y recibe pagos por el día laborado)") {
                        subsidio_transporte <- 162000
                        tags$p(tags$b("Subsidio de transporte: "), as.character(subsidio_transporte), style = "font-size: 21px; text-align: justify;")
                      } else {
                        subsidio_transporte <- 0
                        tags$p(tags$b("Subsidio de transporte: "), as.character(subsidio_transporte), style = "font-size: 21px; text-align: justify;")
                      },
                      tags$b("Prestaciones sociales:", style = "font-size: 21px; text-align: justify;"),
                      div(style="height: 30px;"),
                      # table <- tags$table(
                      #   style = "width: 100%; border-collapse: collapse;",
                      #   tags$thead(
                      #     tags$tr(
                      #       tags$th(style = "border: 1px solid black; padding: 8px;", "Rubro"),
                      #       tags$th(style = "border: 1px solid black; padding: 8px;", "Persona empleadora"),
                      #       tags$th(style = "border: 1px solid black; padding: 8px;", "Persona trabajadora doméstica")
                      #     )
                      #   ),
                      #   tags$tbody(
                      #     tags$tr(
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Salud")),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.085),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.04)
                      #     ),
                      #     tags$tr(
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Pensión")),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.12),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.04)
                      #     ),
                      #     tags$tr(
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("ARL* (tipo 1)")),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.00052),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", "")
                      #     ),
                      #     tags$tr(
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", tags$b("Caja de compensación (opcional)")),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", as.numeric(input$salario_mensual) * 0.03),
                      #       tags$td(style = "border: 1px solid black; padding: 8px;", "")
                      #     )
                      #   ),
                      #   style = "font-size: 21px;"
                      # ),
                      
                      table <- tags$table(
                        style = "
                          width: 100%; 
                          border-collapse: collapse; 
                          font-size: 18px; 
                          font-family: Arial, sans-serif; 
                          color: #333;
                        ",
                        tags$thead(
                          tags$tr(
                            style = "background-color: #f2f2f2;",
                            tags$th(style = "border: 1px solid #dddddd; padding: 12px; text-align: left;", "Rubro"),
                            tags$th(style = "border: 1px solid #dddddd; padding: 12px; text-align: left;", "Persona empleadora"),
                            tags$th(style = "border: 1px solid #dddddd; padding: 12px; text-align: left;", "Persona trabajadora doméstica")
                          )
                        ),
                        tags$tbody(
                          tags$tr(
                            style = "background-color: #f9f9f9;",
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", tags$b("Salud")),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              paste0("$", format(as.numeric(input$salario_mensual) * 0.085, big.mark = ",", decimal.mark = ".", nsmall = 2))
                            ),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              paste0("$", format(as.numeric(input$salario_mensual) * 0.04, big.mark = ",", decimal.mark = ".", nsmall = 2))
                            )
                          ),
                          tags$tr(
                            style = "background-color: #ffffff;",
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", tags$b("Pensión")),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              paste0("$", format(as.numeric(input$salario_mensual) * 0.12, big.mark = ",", decimal.mark = ".", nsmall = 2))
                            ),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              format(as.numeric(input$salario_mensual) * 0.04, big.mark = ",", decimal.mark = ".", nsmall = 2)
                            )
                          ),
                          tags$tr(
                            style = "background-color: #f9f9f9;",
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", tags$b("ARL")),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              paste0("$", format(as.numeric(input$salario_mensual) * 0.00052, big.mark = ",", decimal.mark = ".", nsmall = 2))
                            ),
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", "")
                          ),
                          tags$tr(
                            style = "background-color: #ffffff;",
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", tags$b("Caja de compensación (opcional)")),
                            tags$td(
                              style = "border: 1px solid #dddddd; padding: 12px;",
                              paste0("$", format(as.numeric(input$salario_mensual) * 0.03, big.mark = ",", decimal.mark = ".", nsmall = 2))
                            ),
                            tags$td(style = "border: 1px solid #dddddd; padding: 12px;", "")
                          )
                        )
                      ),
                      
                      
                      
                      div(style="height: 30px;"),
                      tags$b(sprintf("Salario neto que recibirá la persona trabajadora: $ %d", (input$salario_mensual - (as.numeric(input$salario_mensual) * 0.04) + subsidio_transporte)), style = "font-size: 21px; text-align: justify;"),
                      div(style="height: 30px;"),
                      tags$b("Beneficios:", style = "font-size: 21px;", style = "text-align: justify;"),
                      tags$ul(
                        tags$li(
                          tags$p("Vacaciones pagadas por el empleador: 15 días al año (o proporcional)", style = "text-align: justify;")
                        ),
                        tags$li(
                          tags$p(sprintf("Prima: Un salario al año (o proporcional) Medio salario el 30 junio ($ %d)", as.numeric(input$salario_mensual) / 2), sprintf("Medio salario el 20 diciembre ($ %d)", as.numeric(input$salario_mensual) / 2), style = "text-align: justify;")
                        ),
                        tags$li(
                          tags$p(sprintf("Cesantías: Un salario al año (o proporcional) Medio salario el 30 junio ($ %d)", as.numeric(input$salario_mensual) / 2), sprintf("y 12%% de intereses anual ($ %d)", as.numeric(input$salario_mensual) / 2), style = "text-align: justify;")
                        ),
                        tags$li("Incapacidades y licencias de maternidad cubiertas con la EPS", style = "text-align: justify;"),
                        tags$li("Dotaciones dos veces al año (vestuario y calzado", style = "text-align: justify;"),
                        tags$li("Acuerdos sobre tiempo de periodo de prueba.", style = "text-align: justify;"),
                        tags$li("Alimentación y vivienda como se haya acordado entre las partes.", style = "text-align: justify;"),
                        div(style="height: 30px;"),
                        style = "font-size: 21px;"
                        )
                      ),
               column(1),
               fluidRow(
                 column(5),
                 column(6,
                        downloadButton("download_plantilla_pdf", "Descargue la plantilla", style = "font-size: 20px; text-align: center;")
                 )
               ),
               div(style="height: 50px;"),
               )
             )
      ),
      fluidRow(
        column(6),
        column(6,
               actionButton("volver_plantilla", "<< Volver", style = "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
        )
      ),
      div(style="height: 100px;"),
    )
  })
}
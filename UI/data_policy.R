
dataPolicyUI <- function(output){
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
      div(style = "height: 70px"),
      wellPanel(
        h2(tags$b("Política de tratamiento de datos"), style = "text-align: center;"),
      ),
      div(style = "height: 30px"),
      p("NOMBRE  identificado (a) con cédula de ciudadanía número XXXXXXX en aplicación de la Ley Estatutaria1581 de dos mil doce (2012) y del Decreto 1377 de dos mil trece (2013), autorizo por medio del presente documento a EL COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO, institución privada, de educación superior, con el carácter académico de Universidad, ubicada en la calle 12 C No. 6-25 en la ciudad de Bogotá D.C. sin ánimo de lucro, con personería jurídica reconocida mediante resolución número 58 del 16 de septiembre de 1895 expedida por el Ministerio de Gobierno, para recolectar, almacenar, usar, circular o suprimir los datos personales que voluntariamente he suministrado con el objeto de consolidar una base de información de hojas de vida para la selección de personal administrativo, docente y de prestación de servicios. Esta autorización no faculta a EL COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO para entregar mis datos personales a ninguna otra compañía, cliente, organización o tercero de cualquier naturaleza. El tratamiento se limitará a los fines aquí establecidos y se guardará la debida reserva, adoptando las medidas técnicas y administrativas adecuadas y suficientes que permitan el cuidado y conservación de mis datos personales. Finalmente, declaro conocer mi derecho a solicitar, en cualquier momento, que se actualice o retire parte de la información suministrada y/o que se me desvincule de las bases de datos del COLEGIO MAYOR DE NUESTRA SEÑORA DEL ROSARIO.", style = "font-size: 20px; text-align: justify;"),
      div(style = "height: 100px"),
      fluidRow(style = "text-align: justify;",
               column(1, offset = 4,
                      actionButton("volver_home", "<< Volver", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
               ),
               column(1),
               column(1, offset = 1,
                      actionButton("tratamiento_datos", "Acepto >>", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;") # tratamiento_datos
               )
      )
    )
  })
}
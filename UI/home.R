
homeUI <- function(output){
      output$page_content <- renderUI({
        tagList(
          tags$div(
            # style = "background-image: url('logo_urosario.png'); 
            #          background-size: cover; 
            #          background-position: center;
            #          width: 100%; 
            #          height: 100vh;",
            fluidRow(
              column(4,
                     tags$img(src = "logo_urosario.png", height = 150, width = 500, style = "text-align: center;")
              ),
              column(4, offset = 4,
                     tags$img(src = "LogoCODES.png", height = 150, width = 500, style = "text-align: center;")
              ),
            ),
            div(style = "height: 50px"),
            fluidRow(
              column(2, offset = 4,
                     tags$img(src = "logo_dignihogar.jpeg", height = 150, width = 500, style = "text-align: center;")
              )
            ),
            div(style = "height: 50px"),
            fluidRow(
              column(5,
                     p("¡Bienvenido a nuestra aplicación, diseñada especialmente para empleadas domésticas y empleadores de servicio doméstico! Nuestro objetivo es ofrecer una herramienta fácil y accesible que permita entender y determinar los deberes y derechos laborales, e informar los porcentajes a pagar a seguridad social y parafiscales.", style = "font-size: 20px; text-align: justify;"),
                     p("Esta herramienta está diseñada por la Facultad de economía de la Universidad del Rosario y la corporación para el desarrollo de la seguridad social - CODESS. Nuestra aplicación busca cerrar la brecha informativa, ya que las empleadas domésticas y los empleadores suelen desconocer los detalles de los contratos laborales y las prestaciones sociales a las que tienen derecho y los deberes asociados a esta ocupación.", style = "font-size: 20px; text-align: justify;"),
                     p("Al final de los 4 pasos, los usuarios recibirán una plantilla con detalles necesarios para garantizar el respeto de sus derechos y un trato justo en su empleo, calculando rápidamente los términos de su contrato laboral, incluyendo salario, vacaciones, entre otros beneficios.", style = "font-size: 20px; text-align: justify;"),
                     div(style = "height: 50px"),
                     div(style = "height: 30px")
              ),
              column(5, offset = 1,
                     
              )
            ),
            fluidRow(
              column(1, offset = 6, align = "center",
                     actionButton("go_dataPolicy", "Continuar", style= "color: #fff; background-color: #333; border-color: #2e6da4; font-size: 20px;")
              )
            ),
            div(style = "height: 50px"),
          )
        )
      })
}
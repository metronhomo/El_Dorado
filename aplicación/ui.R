library(shiny)
library(shinythemes)

shinyUI(navbarPage("",theme = shinytheme("flatly"),
                   tabPanel("Objetivo del estudio",
                            column(6,imageOutput('imagen1')),
                            column(4,
                                   wellPanel(h1('Buscamos un clasificador que sea capaz de discriminar a los clientes de captación 
                                                con mayor propensión a tener un crédito, esto utilizando sus patrones de comportamiento en 
                                                ahorro.',align="justify"),
                                             style = "background-color: white;")
                                   ),
                            column(2)),
                   tabPanel("Nota Técnica",
                            fluidPage(
                              column(12,
                                     imageOutput('nota'),
                                     align="center"
                              )
                                         )
                            
                    ),
                   tabPanel('Calcular',
                            column(4,wellPanel(h2("¿Tienes una nueva base?",align="center"),
                                               p("Aquí puedes subir tus datos y calcular la probabilidad utilizando el modelo que obtuvimos.",style = "font-size:16pt"), 
                                               p("Lo único que tienes que hacer es subir una nueva base que cumpla con los requerimientos
                                                 que el modelo necesita. Estos los puedes consultar en el botón de 'Requerimientos'.",style = "font-size:16pt"),
                                               p("Una vez hecho eso automáticamente corremos el modelo sobre los nuevos datos y calculamos la probabilidad. Del lado derecho
                                                 de la pantalla te mostramos la base que acabas de subir para para que te asegures de que es la que quieres ocupar.",style = "font-size:16pt"),
                                               p("Puedes descargar los datos nuevos utilizando el botón de descarga que se encuentra abajo.",style = "font-size:16pt"),
                                               p("Para hacer más fácil el proceso ponemos a tu disposición el layout que necesita la base, para que solo tengas 
                                                 que rellenarlo.",style = "font-size:16pt")
                                               ),
                                   conditionalPanel(condition ="assert:<output.contenido>",
                                                    downloadButton('archivorequerimientos','Requerimientos')
                                   ),
                                   br(),
                                   conditionalPanel(condition ="assert:<output.contenido>",
                                                    downloadButton('archivolayout','Layout')
                                   ),
                                   br(),
                                   wellPanel(fileInput('archivoupload',h2('Sube la base'),
                                                       accept=c('text/csv',
                                                                'text/comma-separated-values,text/plain',
                                                                '.csv'
                                                       )
                                   ),
                                   checkboxInput('header','El archivo lleva encabezados',TRUE),
                                   radioButtons('sep','Separador',choices=list('Coma'=',','Punto y coma'=';','Tabulador'='\t','Pipe'='|'))
                                   ),
                                   
                                   conditionalPanel(condition ="assert:<output.contenido>",h2('Descarga la base con probabilidad'),
                                                    downloadButton('archivodescarga','Descarga')
                                   )
                                               ),
                            column(8,tableOutput('contenido'))
                   ),tabPanel("Contacto",
                              column(12,imageOutput('contacto'),align="center"))
                   ))



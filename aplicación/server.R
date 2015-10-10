 # server.R
library(shiny)

shinyServer(function(input, output,session){
  
#   observe({
#     if(input$filtrovar!="Total"){
#       datos1<-df %>%
#         dplyr::select(one_of(input$filtrovar))
#       
#       r_options<-eval(parse(text=paste('list(',paste('"',levels(datos1[,1]),'"="',levels(datos1[,1]),'"',
#                                                     collapse=',',sep=''),')')))
#     }else{
#       r_options<-"Total"
#     }
#     updateRadioButtons(session,'filtrocat',choices=r_options)
#   })

  output$imagen1<-renderImage({
    list(src='images/credito.jpg',
         filetype='image/jpg',
         alt='wiiii',
         width = 1200,
         height = 900)
  }, 
  deleteFile = F)
  
output$nota<-renderImage({
    list(src='images/Nota metodológica bosques.pdf',
         filetype='image/pdf',
         alt='wiiii',
         width = 1100,
         height = 1400)
  }, 
  deleteFile = F)
  
### Data import:
  Dataset <- reactive({
    archivodisplay<-input$archivoupload
    if (is.null(archivodisplay)) {
      # User has not uploaded a file yet
      return(data.frame())
    }
    
    Dataset <- read.csv(archivodisplay$datapath,header=input$header,sep=input$sep)
    
    return(Dataset)
  })
  
  output$contenido<-renderTable({
    archivodisplay<-input$archivoupload
    
    if(is.null(archivodisplay)) return(NULL)
    
    return(Dataset())
  })
  
  output$cosa <- renderTable({
    #Checamos que haya variables para elegir 
    if (is.null(input$file)) return(NULL)
    tabla<-indice(Dataset(),df,
               modelo,
               modelo_ambiente,
               modelo_convivencia,
               modelo_jefe,
               modelo_reconocimiento,
               modelo_seguridad)
    return(tabla)
  })
  
  output$archivodescarga <- downloadHandler(
    filename = "probabilidades.csv",
    content = function(file){
      tabla2<-calcula(Dataset(),bosque1)
      write.csv(tabla2,file,row.names=F)
    }
  )
  
  output$archivolayout <- downloadHandler(
    filename = "Layout.csv",
    content = function(file){
      layout <- data.frame(matrix(ncol=length(xx)))
      names(layout)<-names(xx)
      write.csv(layout,file,row.names=F)
    }
  )
  
  output$archivorequerimientos <- downloadHandler(
    filename = "Requerimientos.txt",
    content = function(file){
      fileConn<-file(file)
      writeLines(c(requerimientos()), fileConn)
      close(fileConn)
    }
  )
  
  output$contacto<-renderImage({
    list(src='images/contacto.png',
         filetype='image/png',
         alt='wiiii',
         width = 1400,
         height = 1100)
  }, 
  deleteFile = F)
  
})
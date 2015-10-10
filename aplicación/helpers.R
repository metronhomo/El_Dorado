#Helpers-------

# filtro<-function(df,variable,facet){
#   if(facet=="Total"){
#     df2 <- df %>%
#       select(one_of(variable)) 
#     names(df2)<-c("var_x")
#     df2 <- df2 %>%
#       group_by(var_x) %>%
#       summarise(n=n()) %>%
#       mutate(valor=(n/sum(n))*100) %>%
#       filter(complete.cases(var_x)) %>%
#       select(1,3)
#   }else{
#     df2 <- df %>%
#       select(one_of(facet,variable)) 
#     names(df2)<-c("var_y","var_x")
#     df2 <- df2 %>%
#       group_by(var_y,var_x) %>%
#       summarise(n=n()) %>%
#       mutate(valor=(n/sum(n))*100) %>%
#       filter(complete.cases(var_y)) %>%
#       select(1,2,4)
#   }
#   return(df2)
# }
# 
# filtro2<-function(df,filtrovar,filtrocat){
#   if(filtrovar!="Total"){
#     nrenglon <- df %>%
#       mutate(index=row.names(.)) %>%
#       select(one_of(filtrovar,"index"))
#     names(nrenglon)<-c("x","index")
#     nrenglon<- nrenglon %>%
#       filter(x==filtrocat) %>%
#       select(2)
#     df<-df[nrenglon$index,]
#   }
#   return(df)
# }

calcula <- function(df,bosque){
  df[is.na(df)] <- 0
  df[,2]<-as.double(df[,2])
  df[,3]<-as.double(df[,3])
  df[,4]<-as.double(df[,4])
  df[,5]<-as.double(df[,5])
  df[,6]<-as.double(df[,6])
  df[,7]<-as.double(df[,7])
  
  df$medias1 <- df[,7]
  df$medias2 <- (df[,6] + df[,7])/2
  df$medias3 <- (df[,5] + df[,6] + df[,7])/3
  df$medias4 <- (df[,4] + df[,5] + df[,6] + df[,7])/4
  df$medias5 <- (df[,3] + df[,4] + df[,5] + df[,6] + df[,7])/5
  df$medias6 <- (df[,2] + df[,3] + df[,4] + df[,5] + df[,6] + df[,7])/6
  
  predicciones <- predict(bosque,df[,c(8:13)],type='prob')
  df$probabilidad<-predicciones[,2]
  return(df[,c(1,14)])
}

requerimientos<-function(){
  req<-"Los datos tienen que estar en formato csv, pero no necesariamente separados por comas. Los separadores 
  pueden ser:
  * Coma (,).
  * Punto y coma (;).
  * Tabulador.
  * Pipe (|).
  
  Para calcular la probabilidad el modelo ocupa los últimos seis saldos promedios mensuales y los datos de transaccionalidad;
  necesitamos que la base contenga el identificador de persona y esas seis variables en ese orden. Es decir:
  
  ** id
  ** Saldo mes uno.
  ** Saldo mes dos.
  ** Saldo mes tres.
  ** Saldo mes cuatro.
  ** Saldo mes cinco.
  ** Saldo mes sies.
  ** Datos de transaccionalidad.
  
  Finalmente, para hacer más fácil el trabajo ponemos a tu disposición el layout para que solo lo rellenes. Para
  descargarlo oprime el botón de Layout que se encuentra debajo de donde obtuviste este archivo."
}



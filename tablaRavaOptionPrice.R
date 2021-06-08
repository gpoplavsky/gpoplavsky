library(rvest)

url.opciones <- "https://allaria.com.ar/es/Opcion"
tmp <- read_html(url.opciones)
tmp2 <- html_nodes(tmp, "table")
opciones <- html_table(tmp2[[1]],
                       dec = "."
                       )

mi_df <- opciones[, c(1:14)]

# Ordenando por la columna 'volumen monto' en orden decreciente
df_ordenado <- mi_df[order(mi_df$`Volumen (monto)`), decreasing = T]

# Asigno un dataframe limpio con las primeras 300 filas
df_limpio <- df_ordenado[c(1:300),]
  
#transformamos las fechas a date
df_limpio$Vencimiento <-  as.Date(df_limpio$Vencimiento, format = "%d/%m/%Y")
df_limpio$Hora <-         as.Date(df_limpio$Hora, format = "%d/%m/%Y %H:%M")

#transformamos los precios a numerico

df_limpio$`Último precio (prima)` <- gsub(',', '.', df_limpio$`Último precio (prima)`, ignore.case = TRUE, perl = FALSE,
     fixed = FALSE, useBytes = FALSE) %>% as.numeric(df_limpio$`Último precio (prima)`)  

df_limpio$`Precio compra` <- gsub(',', '.', df_limpio$`Precio compra`, ignore.case = TRUE, perl = FALSE,
                                          fixed = FALSE, useBytes = FALSE) %>% as.numeric(df_limpio$`Precio compra`)  

df_limpio$`Precio venta` <- gsub(',', '.', df_limpio$`Precio venta`, ignore.case = TRUE, perl = FALSE,
                                  fixed = FALSE, useBytes = FALSE) %>% as.numeric(df_limpio$`Precio venta`)  

df_limpio$`Precio ejercicio` <- gsub(',', '.', df_limpio$`Precio ejercicio`, ignore.case = TRUE, perl = FALSE,
                                  fixed = FALSE, useBytes = FALSE) %>% as.numeric(df_limpio$`Precio ejercicio`)  

#transformamos los volumenes a numerico
##monto
df_limpio$`Volumen (monto)` <- gsub('.', '', df_limpio$`Volumen (monto)`, ignore.case = TRUE, perl = FALSE,
                                     fixed = TRUE, useBytes = FALSE)

df_limpio$`Volumen (monto)` <- gsub(',', '.', df_limpio$`Volumen (monto)`, ignore.case = TRUE, perl = FALSE,
                                                                              fixed = FALSE, useBytes = FALSE) %>% 
  as.numeric(df_limpio$`Volumen (monto)`)  


## volumen de lotes
df_limpio$`Volumen (lotes)` <- gsub('.', '', df_limpio$`Volumen (lotes)`, ignore.case = TRUE, perl = FALSE,
                                    fixed = TRUE, useBytes = FALSE)

df_limpio$`Volumen (lotes)` <- gsub(',', '.', df_limpio$`Volumen (lotes)`, ignore.case = TRUE, perl = FALSE,
                                    fixed = FALSE, useBytes = FALSE) %>% 
  as.numeric(df_limpio$`Volumen (lotes)`)  


## cantidad compra
df_limpio$`Cant. compra` <- gsub('.', '', df_limpio$`Cant. compra`, ignore.case = TRUE, perl = FALSE,
                                    fixed = TRUE, useBytes = FALSE)

df_limpio$`Cant. compra` <- gsub(',', '.', df_limpio$`Cant. compra`, ignore.case = TRUE, perl = FALSE,
                                    fixed = FALSE, useBytes = FALSE) %>% 
  as.numeric(df_limpio$`Cant. compra`)  


## cantidad venta
df_limpio$`Cant. venta` <- gsub('.', '', df_limpio$`Cant. venta`, ignore.case = TRUE, perl = FALSE,
                                 fixed = TRUE, useBytes = FALSE)

df_limpio$`Cant. venta` <- gsub(',', '.', df_limpio$`Cant. venta`, ignore.case = TRUE, perl = FALSE,
                                 fixed = FALSE, useBytes = FALSE) %>% 
  as.numeric(df_limpio$`Cant. venta`)  

#mostramos el dataframe ordenado por volumen
options <- df_limpio[order(df_limpio$`Volumen (monto)`, decreasing = TRUE), decreasing = TRUE] 
options <-  options[c(1:100),]
View(options)

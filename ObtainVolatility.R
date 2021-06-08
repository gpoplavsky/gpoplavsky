#Calculo de la volatilidad de un activo subyacente

library(optionstrat)
library(quantmod)
library(lubridate)

# se obtiene el historial de precios del subyacente
Historical <- getSymbols(Symbols, 
                         from = (today(tzone = "GMT")-40), 
                         to = (today(tzone = "GMT")), 
                         periodicity = "daily")

# se obtienen los retornos
Retornos <- dailyReturn(GGAL.BA$GGAL.BA.Adjusted, type='arithmetic')

# se calcula el desvio estandar de los retornos
desvio <- sd(Retornos)

# y se muliplica por la raiz cuadrada de 250 para anualizar
volatilidad <- desvio*sqrt(250)
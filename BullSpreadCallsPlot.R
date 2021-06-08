library(optionstrat)
library(quantmod)
library(lubridate)
#ver docu de optionstrat en https://cran.r-project.org/web/packages/optionstrat/optionstrat.pdf

#Este script genera un gráfico de rendimientos para una estrategia bull spread con calls utilizando las librerías optionstrat, y obteniendo los precios desde quantmod

#Primer paso: le damos los imputs
##le indicamos el ticker del subyacente
Symbols = "GGAL.BA"

##seteamos la fecha de vencimento del call  
vencimiento = "2021-06-18 18:00:00 GMT"

#Segundo paso: seteamos los parámetros para la función que vamos a usar - Esto estaría bueno obtenerlo dinámicamente
##le decimos que se trata de una estrategia con opciones call
type = "call"

##le indicamos el strike de compra
x1 = 143.98

##le indicamos la prima de compra
price1 = 5.35

##le indicamos el strike de venta
x2 = 148.98

##le indicamos la prima de venta
price2 = 3.57

##le indicamos la tasa de interés
r = 0.38

##hacemos algunos cálculos
###obtenemos el último precio del subyacente
Precio <- getQuote(Symbols, src = "yahoo", )
s = Precio$Last

###calculamos la cantidad de años que faltan hasta el vencimiento
####seteamos hoy
hoy <- today(tzone="GMT")
####y calculamos t
t = tdiff(hoy, vencimiento, "year")

###calculamos la volatilidad implícita en el strike más bajo
sigma <- iv.calc(type, price1, s, x1, t, r, d = 0)

###calculamos la volatilidad implícita en el strike más alto
sigma2 <- iv.calc(type, price2, s, x2, t, r, d = 0)

#Tercer paso: como output, llamamos a la función plotbullcall con todos los parámetros dados 
plotbullcall(s, x1, x2, t, r, sigma, sigma2, d = 0,
             ll = 0.75, ul = 1.25, xlab = "Precio Subyacente", ylab = "Ganancia/Pérdida",
             main = "Bull Call Spread")

##tambien le pedimos que nos calcule los días hasta el vencimiento
days_to_expire <- tdiff(hoy, vencimiento, "days")
days_to_expire

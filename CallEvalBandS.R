library(optionstrat)
library(quantmod)
library(lubridate)

# se indica el precio del subyacente
Symbols = "GGAL.BA"
Precio <- getQuote(Symbols, src = "yahoo", )
s = Precio$Last

# se indica la base de la opción
x = 168.98

# se indica la volatilidad del subyacente 
sigma = volatilidad   

# se indica el tiempo hasta el vencimiento (en años)
hoy <- today(tzone="GMT")
vencimiento = "2021-08-20"
days <- tdiff(hoy, vencimiento, "days")
t = (days/365)

  # se indica la tasa libre de riesgo
r = 0.38
  
  # se indica si va a haber un dividendo
d = 0
  
  
print(calleval(s, x, sigma, t, r, d = 0))

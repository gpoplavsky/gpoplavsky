library(httr)

url <- "https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes"

queryString <- list(
  region = "US",
  symbols = "AMD,IBM,AAPL"
)

username <- "default-application_5263295"
password <- "b2213d3835msh2a2fee086e565c6p1ab6ddjsnb63d477d5bda"

response <- GET(url,authenticate(username,password, type = "basic")) 

texto <- content(response, "text")

texto
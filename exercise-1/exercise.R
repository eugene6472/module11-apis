### Exercise 1 ###

# Load the httr and jsonlite libraries for accessing data
library("httr")
library("jsonlite")

## For these questions, look at the API documentation to identify the appropriate endpoint and information.
## Then send GET() request to fetch the data, then extract the answer to the question

# For what years does the API have statistical data?
answer <- GET("http://data.unhcr.org/api/stats/time_series_years.json")
body <- content(answer,"text")
years <- fromJSON(body)
years

# What is the "country code" for the "Syrian Arab Republic"?
answer <- GET("http://data.unhcr.org/api/countries/list.json")
countries <- fromJSON(content(answer, "text"))
filter(countries, name_en == "Syrian Arab Republic") %>%
  select(country_code)

# How many persons of concern from Syria applied for residence in the USA in 2013?
# Hint: you'll need to use a query parameter
# Use the `str()` function to print the data of interest
# See http://www.unhcr.org/en-us/who-we-help.html for details on these terms
query.params <- list(country_of_residence = "USA", country_of_origin = "SYR", year = 2013)
answer <- GET("http://data.unhcr.org/api/stats/persons_of_concern.json", query = query.params)
usa.persons <- fromJSON(content(answer,"text"))
str(usa.persons)

## And this was only 2013...


# How many *refugees* from Syria settled the USA in all years in the data set (2000 through 2013)?
# Hint: check out the "time series" end points
query.params <- list(country_of_residence = "USA", country_of_origin = "SYR", population_type_code = "RF")
answer <- GET("http://data.unhcr.org/api/stats/time_series_all_years.json?", query = query.params)
refugees.usa <- fromJSON(content(answer,"text"))
refugees.usa <- select(refugees.usa, year, usa = value)
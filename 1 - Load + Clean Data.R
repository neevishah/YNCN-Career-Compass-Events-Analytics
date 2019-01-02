library(readr) #read data
library(stringr)
library(dplyr)
event_registration_data <- read_csv("zs_data.csv")

head(event_registration_data) #returns first 6 data rows to peek at it

#clean names
names(event_registration_data) <- sapply(names(event_registration_data), function(x) { 
  #dataframe is a table. each row is a data point, column is a value.
  #names is a function run on the data and then sapply takes a list, runs a function on it, and then returns another list
  #function x will take element x and run str 
  str_to_lower(str_replace(x, " ", ".")) #from stringr they always look like str_
})

#Grab what we care about from the dplyr package
event_registration_data <- event_registration_data %>% select(order.date, attendee.status, discipline, year, `what.industry do you want to work in?`)

#Take a look at column types
sapply(event_registration_data, class)

#Challenge! Make attendee and discipline status a factor
event_registration_data$attendee.status <- as.factor(event_registration_data$attendee.status)  
event_registration_data$discipline <- as.factor(event_registration_data$discipline) 
event_registration_data$year <- as.factor(event_registration_data$year) 

#Let's take a quick peak at our data
summary(event_registration_data)
levels(event_registration_data$discipline)

#Let's see if we can make industry useful

unique(event_registration_data$`what.industry do you want to work in?`)

#hmmm, see a lot of data, software, business, consulting
temp <- event_registration_data$`what.industry do you want to work in?`

event_registration_data$tech <- str_detect(temp, '[Tt]ech') | str_detect(temp, '[Ss]oftw')

event_registration_data$tech

#CHALLENGE: Clean up any other major industries into their own column. for ZS we care about consulting, tech, finance
event_registration_data$consulting <- str_detect(temp, '[Cc]onsulting')
event_registration_data$consulting
event_registration_data$finance <- str_detect(temp, '[Ff]in')
event_registration_data$finance


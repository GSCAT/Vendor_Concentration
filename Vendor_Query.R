library(dplyr)
library(tidyr)
library(readr)
library(RODBC)
library(rChoiceDialogs)

# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre6')
# library(rJava)

choose_file_directory <- function()
{
  v <- jchoose.dir()
  return(v)
}

# Set Start and End Date
Start_date <- paste("Declare @StartDate as date = ", "'", as.character(readline(prompt= "Enter Start Date as pattern YYYY-mm-dd: ")), "'", sep = "")
End_date <- paste("Declare @StartDate as date = ", "'", as.character(readline(prompt= "Enter End Date as pattern YYYY-mm-dd: ")), "'", sep = "")


query <- readLines(paste(choose_file_directory(), "SDS_Query.txt", sep = "/"))

# Replace Declare statements for StartDate and EndDate
query[which(query=="Declare @StartDate")] <- Start_date
query[which(query=="Declare @EndDate")] <- End_date

my_connect <- odbcConnect(dsn= "SDS", uid= my_uid, pwd= my_pwd)

# query_onestring <- paste(query, collapse = "\n")

Vendor_PO_PULL <- sqlQuery(my_connect, 
                       query = paste(query, collapse = "\n"))

close(my_connect)
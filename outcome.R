##  1 Plot the 30-day mortality rates for heart attack

##Read the outcome data into R via the read.csv function and look at the first few rows.

##df_outcome <- read.csv("outcome-of-care-measures.csv", header = FALSE)

library("data.table")

##Warning message:
##  In require_bit64_if_needed(ans) :
##       Some columns are type 'integer64' but package bit64 is not installed. 
##       Those columns will print as strange looking floating point data. There is no need to reload the data. 
##      Simply install.packages('bit64') to obtain the integer64 print method and print the data again.
##install.packages('bit64')

df_outcome <- data.table::fread('outcome-of-care-measures.csv')
head(df_outcome)

## Num of columns.
total_cols <- ncol(df_outcome)

## Num of rows.
total_rows <- nrow(df_outcome)

## Name of each column
names(df_outcome)

## Plot a histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset~df_outome,
df_outcome[, (11) := lapply(.SD, as.numeric), .SDcols = (11)]
df_outcome[, lapply(.SD
                 , hist
                 , xlab= "Deaths"
                 , main = "Hospital 30-Day Readmission Rates from Heart Failure"
                 , col="lightblue")
        , .SDcols = (11)]

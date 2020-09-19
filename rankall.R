rankall <- function(outcome, num = "best") {
  
    ## Defining dataAll.  This data set will return the information.
    dataAll <- data.frame(hospital = character(), state = character())
    
    ## Read outcome data
    df_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
      dataAll <- "invalid outcome"
    }
    else {
      ## Numbers of the columns in the cvs file"heart attack" = 11, 
      ## "heart failure" = 17, "pneumonia" = 23
      keys <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
      outcomeKey <- keys[outcome]
      
      ## For each state, find the hospital of the given rank
      dataPerState <- split(df_data, data$State)
      for (stat in names(dataPerState)) {
        dataOurState <- dataPerState[[stat]]
        dataOutcome <- suppressWarnings(as.numeric(dataOurState[, outcomeKey]))
        good <- complete.cases(dataOutcome)
        dataOutcome <- dataOutcome[good]
        dataOurState <- dataOurState[good,]
        dataOurState <- dataOurState[ order(dataOutcome, dataOurState["Hospital.Name"]), ]
        
        if (num == "best") {
          numState <- c(1)
        } else {
          if (num == "worst") {
            numState <- length(dataOutcome)
          } else {
            numState <- num
          }
        }
        
        dataPart <- data.frame(hospital = dataOurState[numState, "Hospital.Name"], state = stat, row.names = stat)
        dataAll <- rbind(dataAll, dataPart)
      }
    }
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    dataAll
}

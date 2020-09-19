##  Finding the best hospital in a state

best <- function(state, outcome) {
  ## Read outcome data
  
  df_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  
  ## Confirming if the input state is in column state of the cvs file.
  if (!(state %in% df_outcome$State)) {
    result <- "invalid state"
  }
  else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    result <- "invalid outcome"
  }
  else{
    keys <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    outcomeKey <- keys[outcome]
    
    ## Return hospital name in that state with lowest 30-day death rate
    
    dataPerState <- split(df_outcome, data$State)
    dataOurState <- dataPerState[[state]]
    dataOurState <- dataOurState[ order(dataOurState["Hospital.Name"]), ]
    dataOutcome <- suppressWarnings(as.numeric(dataOurState[, outcomeKey]))
    good <- complete.cases(dataOutcome)
    dataOutcome <- dataOutcome[good]
    dataOurState <- dataOurState[good,]
    minimum <- min(dataOutcome)
    index <- match(minimum, dataOutcome)
    result <- dataOurState[index, 2]
  }
  result
}

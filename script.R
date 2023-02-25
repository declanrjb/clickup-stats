library(tidyverse)
library(dplyr)
library(calendR)
library(lubridate)

df <- read_csv("clickup-export_2.22.csv")
colnames(df) <- gsub(" ","",colnames(df))
df <- df %>% select(!TaskContent)
df <- df %>% select(!DateCreated)
df <- df %>% select(!DueDate)
df <- df %>% select(!StartDate) %>% select(!StartDateText)
df <- df %>% select(!ParentID) %>% select(!Attachments) %>% select(!Assignees) %>% select(!Tags) %>% select(!Priority)
df <- df %>% select(TaskID:ListName)

for (i in 1:length(freqs$DueDate)) {
  tempDf <- freqs %>% filter(DueDate == freqs[i,]$DueDate)
  freqs[i,]$Count <- dim(tempDf)[1]
  message(i)
}

freqs %>% complete(DueDate = seq.Date(freqs[1,]$DueDate, freqs[136,]$DueDate, by="day"))
freqs %>% arrange()
freqs <- freqs[order(as.Date(freqs$DueDate, format="%Y/%m/%d")),]
freqs %>% complete(DueDate = seq.Date(ymd("2022-01-01"), ymd("2024-01-01"), by="day"))

completed <- freqs %>% complete(DueDate = seq.Date(ymd("2022-01-01"), ymd("2024-01-01"), by="day"))
completed <- unique(completed)
completed[is.na(completed)] <- 0

write.csv(completed,"due_dates.csv",row.names=FALSE)

df2022 <- completed[1:365,]
df2023 <- completed[366:731,]



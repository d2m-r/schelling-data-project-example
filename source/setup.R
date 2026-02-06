############ LOAD LIBRARIES #############

library(tidyverse)
library(googlesheets4)


########## GOOGLE SHEETS DATA ###########

# Disable authorization (for public sheets)
gs4_deauth()

# Define raw column names
raw_colnames <- c("timestamp", 
                  "where_stranger", "when_stranger",
                  "where_student", "where_friend",
                  "coin_same", "coin_different",
                  "number_0_10", "number_list", "number_big",
                  "demos_status", "demos_identities", "demos_languages",
                  "error_stranger", "error_student", "error_friend")

# Read in raw survey responses
raw_responses <- read_sheet("https://docs.google.com/spreadsheets/d/1T4XEXNxmb3jK2WenIR9vRXggT_-_8HDejP0J3qeXFqM/edit?usp=sharing", 
                            sheet = 1,
                            skip = 1, # ignore sheet headers (=question wording)
                            # col_types = "TcTccffdddfLLlll", # factor not yet implemented
                            col_types = "TcTccccdddcLLlll",
                            col_names = raw_colnames)

############# LOCAL DATA ################

# Create a snapshot of responses after pulling from the Google Sheet
# allowing the project's code to execute by importing local data
# if the user encounters issues connecting to Google Sheets.

# Write out a local copy of the raw responses
# Uncomment to update the local file
# write_csv(raw_responses, "source/raw_responses.csv")

# Uncomment to read in the most recent snapshot file
# col_names will already match raw_colnames
# col_types will need to be specified
#raw_responses <- read_csv("source/raw_responses.csv",
#                          col_types = "TcTccccdddcLLlll",)



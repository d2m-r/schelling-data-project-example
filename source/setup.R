############ LOAD LIBRARIES #############

library(tidyverse)
library(googlesheets4)

########## GOOGLE SHEETS DATA ###########

# Disable authorization (for public sheets)
gs4_deauth()
# Read in raw survey responses
raw_responses <- read_sheet("https://docs.google.com/spreadsheets/d/1T4XEXNxmb3jK2WenIR9vRXggT_-_8HDejP0J3qeXFqM/edit?usp=sharing", sheet = 1)

############# LOCAL DATA ################

# Create a snapshot of responses after pulling from the Google Sheet
# allowing the project's code to execute by importing local data
# if the user encounters issues connecting to Google Sheets.

# Write out a local copy of the raw responses
# Uncomment to update the local file
# write_csv(raw_responses, "source/raw_responses.csv")

# Uncomment to read in the most recent snapshot file
# raw_responses <- read_csv("source/raw_responses.csv")


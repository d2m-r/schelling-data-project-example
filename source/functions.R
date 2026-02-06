############ FUNCTIONS #############



# selects and cleans meetup location responses based on the kind of meetup partner

# Location groups

# Because responses to the location questions are open-ended, we end up with some situations where we *might* choose to simplify into a single response:
# 1) responses that reference single locations represented in multiple ways (e.g., the bean, bean, cloudgate; reg, the reg, regenstein library)
# 2) responses that *may* reference single locations in multiple ways (e.g., the reg, the library; my room, the dorms, Burton Judson)
# 3) responses that represent different but closely related locations (e.g., the reg, mansueto; a coffee shop, Hallowed Grounds, the Div)

# These are reasonable, non-mutually exclusive groupings that we can choose to use by specifying them in the case_when() in the clean_meetup() function

# OBJECTIVES NOTE: These are object assignment, not functions.
# They use regex to create base r objects (vectors)

bean <- "\\bbean|cloudgate"
thereg <- "\\breg"
park <- "m.*park|g.*park"
library <- "reg|library|crerar|mansueto|eckardt"
dorm <- "north|south|\\bMax|burton|dorm|residential|room|island|i\\shouse" # also included in residence
cafe <- "coffee|cafe|dollop|plein|pret|starbucks|amo\\b|Ex\\sL|hallowed" # also included in dining
residence <- "home|house|dorm|Burton|apartment|they\\slive|north|south|i\\shouse|\\bapt\\b|room|island|max|residen"
dining <- "coffee|cafe|dollop|plein|\\bbart|shop|restaurant|Ex\\sL|pret|starbucks|baker|dining|\\bmed|amo\\b|hallowed|cathey"
uc_other <- "quad|UChicago|ratner|hutch|harper|reynold|bookstore|logan|pond|rock.*?er" # "rock.*er" catches misspellings of Rockefeller
chi_other <- "hare\\b|\\blake\\b|navy|magnificent|tower|\\bart\\b|loop|station"
recent <- "\\blast\\b|usual|before|frequent"
kbg <- "kelly|beecher|kbg" # You might want to define groups that could be useful later, even if you're not currently used in clean_meetup() 




######### filter_errors() ###########


# Clean any of the meetup location response columns, collapse as directed, 
# and filter out clear errors

# data : data frame containing raw survey responses
# colName : name of column containing meetup location responses to be cleaned -- TEMP REMOVED FOR SIMPLICITY
# colErr : name of corresponding boolean column that indicates whether 
# response has been manually marked as an error

filter_errors <- function(data, colErr="") {
    # if error column is provided
    if (colErr != "") {
        # filter out rows marked as errors
        data <- data |>
            # `.data` pronoun allows use of character string to select column
            # works 
            filter(is.na(.data[[colErr]]))
    }
    # return cleaned responses
    return(data)
}

filter_errors(raw_responses, "error_stranger")


######### meetup_cleanup() ###########
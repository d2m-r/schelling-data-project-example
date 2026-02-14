# library(tidyverse)

############ DEMOGRAPHICS #############

# Read in raw-responses if not already in the environment
if (!exists("raw_responses")) {
    raw_responses <- read_csv("data/raw-responses.csv",
                            col_types = "dTcTccccdddccclll")
}

# Create new df with only demographics data
demographics <- raw_responses  |> 
    # colnames begin with "demos"
    select(id, starts_with("demos"))  |> 
    # remove "demos_" from the column names
    rename_with(~ str_remove(., "demos_"))  |> 
    # convert ALL strings to lower case
    mutate(across(where(is.character), str_to_lower))


### CREATE AFFILIATION STATUS FACTORS ###

# View unique values in the "status" column
# unique(demographics$status)

demographics <- demographics |> 
    # Fill-down missing status values
    ## Alternatively, we could impute based on timestamps 
    ## (i.e., responses that occurred within the first 10 minutes of an
    ## all-undergrad class session can be assumed to be undergrads)
    ## However, we know from how and when the survey was administered,
    ## the structure of the data, and our informal goals that simply 
    ## filling-down is appropriate & sufficient for these purposes
    fill(status, .direction = "downup") |>
    mutate(
        # Turn `status` into factor `affiliation` with manuscript-ready level labels
        affiliation = factor(
            status,
            levels = c(
                "uchicago undergraduate student",
                "uchicago phd student", 
                "uchicago faculty/staff", 
                "uchicago ma student (e.g., mapss, macss, harris/crown ma)", 
                "other uchicago student",
                "not affiliated with uchicago"),
            labels = c(
                "Undergraduate Student",
                "PhD Student",
                "Faculty/Staff",
                "MA Student",
                "Other Student",
                "Not Affiliated")
                ),
        # Collapse `affiliation` into new factor `student` with 3 levels: 
        # "Undergraduate", "Graduate", "Other"
        student = fct_collapse(affiliation,
            Undergraduate = "Undergraduate Student",
            Graduate = c("PhD Student", "MA Student")
        )
    )

### PARSE GENDER DATA ###

# View unique
# unique(demographics$identities)

# Parsing gender before separating identities column
# allows for easier capture of multiple gender identities

demographics <- demographics |> 
    mutate(
        # Create new column `gender` by parsing `identities`
        gender = case_when(
            # Detect cases where multiple identities are listed 
            # Assign to Other category
            str_count(identities, "man|binary") > 1 ~ "Other",
            str_detect(identities, "binary\\b") ~ "Other",
            str_detect(identities, "\\bwoman\\b") ~ "Woman",
            str_detect(identities, "\\bman\\b") ~ "Man",
            TRUE ~ NA # Set to NA if no match
        ) |> factor()
    ) |> 
    # Separate `identities` into multiple rows using comma as delimiter
    separate_longer_delim(identities, delim = ",") |> 
    # Remove whitespace
    mutate(identities = str_trim(identities))

### CLEAN & SEPARATE LANGUAGES
## Languages was free response, so it requires some cleaning and consistency

demographics <- demographics |> 
    # create consistent delimiter for languages
    mutate(languages = str_replace_all(languages, ";| and |/", ",")) |>
    # Count number of languages listed in `languages` column
    # before separating rows
    mutate(num_languages = ifelse(
        is.na(languages), NA,
            str_count(languages, ",") + 1)) |>
    separate_longer_delim(languages, delim = ",") |> 
    # Remove whitespace
    mutate(languages = str_trim(languages)) |> 
    # Collapse reponses of chinese+mandarin (without delim) to just mandarin
    # Also account for observed typos ("chines" and "mandrain")
    mutate(languages = case_when(
        str_detect(languages, "chines|mandrain") ~ "mandarin",
        TRUE ~ languages
    ))

# Confirm unique languages are clean
# unique(demographics$languages)


### NEW TO UCHICAGO, CHICAGO, USA ###

demographics <- demographics |> 
    mutate(
        new_to_uchicago = str_detect(identities, "new to the university of chicago"),
        new_to_chicago = str_detect(identities, "new to chicago"),
        new_to_usa = str_detect(identities, "new to the us"),
        international = str_detect(identities, "raised outside")
    )


# write out demos dataset
write_csv(demographics, "data/demographics.csv")

# read-in coltypes (reference): "icccfffdllll"
            
# demographics2 <- read_csv("data/demographics.csv",
#          col_types = "icccfffdllll")          
            
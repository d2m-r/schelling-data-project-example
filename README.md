# Schelling Games: D2M-R I Integrative Data Project Example

## Purpose

This repo serves as an example of a complete Quarto project that imports, cleans, analyzes, visualizes, and dynamically reports data from an external source (a Google Sheet linked to a Google Form). The data itself is drawn from a simple interactive exercise in cooperative game theory inspired by Thomas Schelling's work on tacit coordination.

Students can use this as a model of how to structure their own data projects in R and/or GitHub, and specifically how to meet the requirements of the D2M-R I Integrative Data Project assignment.

Importantly, this is by no means intended to present reliable, rigorous data or to make any contribution to any literature whatsoever. Instead, this is intended to be an interactive exercise for two contexts:

1. Introducing students to concepts around non-verbal communication, cooperative interaction, tacit coordination, etc.
2. Offering an example repository to students getting started with R and/or GitHub.

## Project Description

In this brief report, we consider focal points from a cognitive science perspective. We present data from an informal survey mimicking Schelling's early (and also quite informal) study in The Strategy of Conflict (Schelling, 1960). We discuss our findings as they relate to nonverbal communication and how these concepts may be extended to further our understanding of coordination in everyday conversation.

This project imports data from a Google Form where participants play "Schelling games" designed to demonstrate the ability to coordinate in the absence of communication in order to "win" cooperative (vs zero-sum) games.

Participants play the game by completing [this Google Form](https://forms.gle/ke75Tj7vshRa3joA7). 
Raw responses are automatically added to a public Google Sheet available to view [here](https://docs.google.com/spreadsheets/d/1T4XEXNxmb3jK2WenIR9vRXggT_-_8HDejP0J3qeXFqM/edit?usp=sharing).

The Quarto manuscript in this repo imports the data from the Google Sheet (or alternatively from a static CSV snapshot of the data), cleans and wrangles it, analyzes it, and visualizes it to produce a dynamic HTML report summarizing the results of the exercise.

## Repo contents

In meeting expectations for the integrative data project, this repo contains the following elements:

1.  Top level directory:
    1.  `README.md` file (this file) describing the project purpose, contents, and structure.
    2. `.gitignore` file excluding unnecessary files from Git version control, including a `localonly` directory which will not be accessible on GitHub or in cloned repos.
    3. A unified Quarto manuscript (`schelling-manuscript.qmd`) that combines YAML, markdown, and code chunks to produce a dynamic HTML report
2.  Data:
    1.  A static snapshot of the raw data as a CSV file (`responses_raw.csv`) imported from the Google Form, to use as an alternative to live data import from Google sheets
3.  Source:
    1.  A `setup.R` script that imports cleaned data and sets up the environment for analysis and visualization
    2.  A `functions.R` script that defines custom functions used in the manuscript
    3.  An `import_wrangle.R` script that imports and wrangles the data from Google Sheets (or csv)
4.  Output:
    1.  The rendered HTML output of the Quarto manuscript
5.  Local-only files:
    1.  A `localonly` directory excluded from Git version control via the `.gitignore` file, intended for any files users wish to keep private or not share on GitHub (e.g., local data files, personal notes, etc.)
        -   **If you are accessing this project remotely (e.g., viewing on GitHub), you will not see this directory or its contents.**
        -   You should include a localonly (or similar) directory in your own projects to keep any sensitive or personal files out of version control, but it is not something that your instructor should ever see or access. It should not contain any files required to knit your Quarto notebook into an HTML file.

### File tree

The above description of file structure is sufficient for the project's requirements.
You can alternatively/additionally use markdown to create a file tree:

```
-- [top level]
    -- .gitignore
    -- README.md
    -- schelling-manuscript.qmd
    -- data/
        -- responses_raw.csv (static dataset snapshotted from google form data in Fall 2023)
    -- source/
        -- functions.R (required custom functions, sourced in index)
        -- setup.R (basic preparation of response data, defining aesthetic preferences, etc.) 
        -- import_wrangle.R (importing and wrangling data from Google Sheets)
    -- output/
        -- schelling-manuscript.html (rendered HTML output of the Quarto manuscript)
    -- localonly/ (directory excluded from Git version control via .gitignore)
```
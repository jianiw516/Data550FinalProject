# Data550FinalProject
Pandemic Vaccine Research

## Description
This project analyzes the association between immunogenicity and reactogenicity of pandemic influenza vaccines. The dataset includes mock data created for this analysis, exploring how various vaccine formulations, antigen types, and participant characteristics influence outcomes.

## Repository Structure
The repository is organized as follows:
`data/raw_data.csv`

  - raw mock data created from real patient records

`code/01_data_processing.R`

  - introduces the data
  - clean and mutate data
  - saves cleaned data as a `.rds` object in `data/` folder
  
`code/02_descriptive_stats.R`

  - descriptive graphical analysis
  - saves plots as  `.png` objects in `output/` folder
  - summarizes tables as  `.rds` objects in `output/` folder
  
`code/03_modeling.R`

  - modeling the data, immunogenicity vs. reactogenicity across vaccine adjuvants, antigen types and other meaningful demgraphic characteristics
  - saves plot that graphically displays the model as `.png` object in the `output/` folder

`code/04_render_report.R`

  - renders `final_report.Rmd`

`final_report.Rmd`

  - makes the demographic table, graphical analysis, and the model plot

`Makefile`

  - contains rules for building the report
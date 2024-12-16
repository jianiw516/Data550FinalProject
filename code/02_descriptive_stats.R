library(tidyverse)
library(gtsummary)
library(here)
here::i_am("code/02_descriptive_stats.R")

# Load dataset
clean_data <- read.csv(
  file = here::here("data/clean_data.csv")
)

# Create the stats table for continuous and categorical variables
stats_table <- clean_data %>%
  select(GENDER, AGE, ETHNICITY, BMI, log_hai_titer, reaction_scores, antigen, adjuvant) %>%
  tbl_summary(
    by = GENDER,  
    type = list(reaction_scores ~ "continuous"),  # Explicitly treat reaction_scores as continuous
    statistic = list(
      all_categorical() ~ "{n} ({p}%)",  # Counts and percentages for categorical variables
      all_continuous() ~ "{mean} ({sd})" # Mean and standard deviation for continuous variables
    ),
    missing = "no"
  ) %>%
  add_overall()  # Add an overall summary column

# Save the table as an RDS file
saveRDS(
  stats_table,
  file = here::here("output", "descriptive_stats_table.rds")
)

# Overall Scatterplot
fig_1 <- ggplot(clean_data, aes(x = reaction_scores, y = log_hai_titer)) +
  geom_point(alpha = 0.7, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Overall Relationship Between Reaction Scores and Log HAI Titers",
       x = "Reaction Scores",
       y = "Log HAI Titers") +
  theme_minimal()

saveRDS(
  fig_1,
  file = here::here("output", "scatterplot_overall_fig1.rds")
)

# Scatterplot stratified by GENDER
fig_2 <- ggplot(clean_data, aes(x = reaction_scores, y = log_hai_titer, color = GENDER)) +
  geom_point(alpha = 0.7, size = 1) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship Stratified by Gender",
       x = "Reaction Scores",
       y = "Log HAI Titers") +
  theme_minimal()

saveRDS(
  fig_2,
  file = here::here("output", "scatterplot_gender_fig2.rds")
)

# Scatterplot stratified by ETHNICITY
fig_3 <- ggplot(clean_data, aes(x = reaction_scores, y = log_hai_titer, color = ETHNICITY)) +
  geom_point(alpha = 0.6, size = 1) +
  geom_smooth(method = "lm", se = FALSE, size = 0.8) +
  labs(title = "Relationship Stratified by Ethnicity",
       x = "Reaction Scores",
       y = "Log HAI Titers") +
  theme_minimal()

saveRDS(
  fig_3,
  file = here::here("output", "scatterplot_ethnicity_fig3.rds")
)


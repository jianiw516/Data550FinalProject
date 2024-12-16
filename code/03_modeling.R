library(here)
library(broom)  # For tidy model output
library(dplyr)  # For data manipulation
library(gt)     # For creating clean tables
here::i_am("code/03_modeling.R")

# Load dataset
clean_data <- read.csv(
  file = here::here("data/clean_data.csv")
)

# Fit the model with interaction terms
lm_model <- lm(log_hai_titer ~ reaction_scores * GENDER * ETHNICITY, data = clean_data)

# Model summary
summary(lm_model)

# Save model output as an RDS file
saveRDS(lm_model, file = here::here("output", "linear_model_results.rds"))

# Tidy the linear model output
tidy_model <- tidy(lm_model) %>%
  filter(!is.na(p.value)) %>%          # Remove rows with NA p-values
  mutate(signif = case_when(           # Add significance levels
    p.value < 0.001 ~ "***",
    p.value < 0.01  ~ "**",
    p.value < 0.05  ~ "*",
    p.value < 0.1   ~ ".",
    TRUE            ~ ""
  ))

# Filter only relevant terms (e.g., significant or borderline significant)
key_results <- tidy_model %>%
  filter(p.value < 0.1 | term == "reaction_scores") %>%
  select(term, estimate, std.error, p.value, signif)


# Create a clean table
key_results_table <- key_results %>%
  gt() %>%
  tab_header(
    title = "Summary of Key Coefficients",
    subtitle = "Linear model assessing the relationship between Reaction Scores and Log HAI Titers"
  ) %>%
  cols_label(
    term = "Variable",
    estimate = "Estimate",
    std.error = "Std. Error",
    p.value = "P-value",
    signif = "Signif."
  ) %>%
  fmt_number(
    columns = c(estimate, std.error, p.value),
    decimals = 3
  ) %>%
  tab_footnote(
    footnote = "Significance codes: *** p < 0.001, ** p < 0.01, * p < 0.05, . p < 0.1",
    locations = cells_column_labels(columns = signif)
  )

# Save key results as an RDS file
saveRDS(key_results, file = here::here("output", "key_model_summary.rds"))

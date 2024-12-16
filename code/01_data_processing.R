library(here)
here::i_am("code/01_data_processing.R")

# Load the dataset
data_path <- here::here("data/raw_data.csv")
raw_data <- read.csv(data_path)

# Remove NA values & save to clean dataset
clean_data <- na.omit(raw_data)
write.csv(clean_data, "data/clean_data.csv", row.names = FALSE)
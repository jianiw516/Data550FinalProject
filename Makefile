# Variables
DATA_DIR=data
OUTPUT_DIR=output
CODE_DIR=code
REPORT=final_report.Rmd
CLEANED_DATA=$(DATA_DIR)/cleaned_data.rds
TABLES_DIR=$(OUTPUT_DIR)/tables
FIGURES_DIR=$(OUTPUT_DIR)/figures

# Default target: Render the final report
all: $(OUTPUT_DIR)/final_report.html

# Step 0: Install R environment
install:
	Rscript -e 'renv::restore()'

# Step 1: Data Processing
$(CLEANED_DATA): $(DATA_DIR)/raw_data.csv $(CODE_DIR)/01_data_processing.R
	Rscript $(CODE_DIR)/01_data_processing.R

# Step 2: Descriptive Statistics
$(TABLES_DIR)/descriptive_table.rds $(FIGURES_DIR)/descriptive_plots.png: $(CLEANED_DATA) $(CODE_DIR)/02_descriptive_stats.R
	Rscript $(CODE_DIR)/02_descriptive_stats.R

# Step 3: Modeling
$(FIGURES_DIR)/model_plot.png: $(CLEANED_DATA) $(CODE_DIR)/03_modeling.R
	Rscript $(CODE_DIR)/03_modeling.R

# Step 4: Render Report
$(OUTPUT_DIR)/final_report.html: $(REPORT) $(CLEANED_DATA) $(TABLES_DIR)/descriptive_table.rds $(FIGURES_DIR)/model_plot.png $(CODE_DIR)/04_render_report.R
	Rscript $(CODE_DIR)/04_render_report.R

# Clean up generated files
clean:
	rm -rf $(CLEANED_DATA) $(TABLES_DIR)/*.rds $(FIGURES_DIR)/*.png $(OUTPUT_DIR)/final_report.html

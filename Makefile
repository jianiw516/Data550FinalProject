# Step 1: clean the data
data/clean_data.csv: data/raw_data.csv code/01_data_processing.R
	Rscript code/01_data_processing.R

# Step 2: Descriptive Statistics
output/descriptive_stats_table.rds output/scatterplot_overall_fig1.rds output/scatterplot_gender_fig2.rds output/scatterplot_ethnicity_fig3.rds: data/clean_data.csv code/02_descriptive_stats.R
	Rscript code/02_descriptive_stats.R

# Step 3: Modeling
output/linear_model_results.rds output/key_model_summary.rds: data/clean_data.csv code/03_modeling.R
	Rscript code/03_modeling.R

# Step 4: Render Report
final_report.html: final_report.Rmd code/04_render_report.R data/data_clean.csv output/descriptive_stats_table.rds output/scatterplot_overall_fig1.rds output/scatterplot_gender_fig2.rds output/scatterplot_ethnicity_fig3.rds output/linear_model_results.rds output/key_model_summary.rds
	Rscript code/04_render_report.R

# Install dependencies with renv
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
# Clean up generated files
.PHONY: clean
clean:
	rm -f data/clean_data.csv \
	      output/descriptive_stats_table.rds \
	      output/scatterplot_overall_fig1.rds \
	      output/scatterplot_gender_fig2.rds \
	      output/scatterplot_ethnicity_fig3.rds \
	      output/linear_model_results.rds \
	      output/key_model_summary.rds \
	      final_report.html
	      
# Docker-associated rules (run on our local machine)
PROJECTFILES = final_report.Rmd code/01_data_processing.R code/02_descriptive_stats.R code/03_modeling.R code/04_render_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

#rule to build image
final_project_docker_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t jianiw516/final_project_docker_image .
	touch $@

# Docker-associated rule: Run the report generation
run_report:
	docker run --rm -v "$(shell pwd):/project" jianiw516/final_project_docker_image


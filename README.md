# Data550FinalProject
Pandemic Vaccine Research

## Description
This project analyzes the association between immunogenicity and reactogenicity of pandemic influenza vaccines. The dataset includes mock data created for this analysis, exploring how participant characteristics like gender and ethnicity influence outcomes.

## Repository Structure
The repository is organized as follows:
`data/raw_data.csv`

  - raw mock data created from real patient records

`code/01_data_processing.R`

  - introduces the data
  - clean data
  - saves cleaned data as a `.rds` object in `data/` folder
  
`code/02_descriptive_stats.R`

  - descriptive graphical analysis
  - saves plots as  `.rds` objects in `output/` folder
  - summarizes tables as  `.rds` objects in `output/` folder
  
`code/03_modeling.R`

  - modeling the data, immunogenicity vs. reactogenicity across gender and ethnicity
  - saves plot that graphically displays the model as `.rds` object in the `output/` folder

`code/04_render_report.R`

  - renders `final_report.Rmd`

`final_report.Rmd`

  - makes the demographic table, graphical analysis, and the model plot

`Makefile`

  - contains rules for building the report
  
## Steps to Reproduce
1. Install R Environment  
This project uses the renv package to ensure reproducibility. Install the required R packages by running:  
```
make install 
```
This command restores the project-specific R environment based on the renv.lock file.

2. Build the Report  
To execute the entire analysis and generate the final report, run:  
```
make
```
This command performs the following steps:  
- Cleans and processes the raw data.  
- Conducts descriptive analysis and generates plots and tables.  
- Models the data and saves the outputs.  
- Renders the final report as final_report.html in the output/ folder.

3. Run Docker Image
To ensure full reproducibility using Docker, follow these steps:
Build the Docker Image
First, build the image:
```
docker build -t jianiw516/final_project_docker_image .
```
Pull the Docker Image
```
docker pull jianiw516/final_project_docker_image:latest
```
Run the Docker Image
Run the container and mount the report/ folder:
```
docker run --rm -v $(shell pwd)/report:/project/output jianiw516/final_project_docker_image
```
For Windows users with Git Bash, use:
```
docker run --rm -v /$(shell pwd)/report:/project/output jianiw516/final_project_docker_image
```
When the container finishes running, the report/ directory will contain the compiled final_report.html.
The Docker image for this project is publicly available on [DockerHub](https://hub.docker.com/r/jianiw516/final_project_docker_image).

3. Synchronize Your Package Repository  
To ensure the repository includes all required package dependencies:  
- Capture New Dependencies:  
  Run the following command to update the renv.lock file with any new dependencies: 
  ```
  renv::snapshot()  
  ```

- Restore Dependencies (For Collaborators):  
  If dependencies have changed, restore them by running:  
  ```
  make install
  ```
  
- Commit Changes to GitHub:  
  Ensure the renv.lock file and renv/ folder are pushed to the repository:  
  ```
  git add renv.lock renv/  
  git commit -m "Update package dependencies"  
  git push  
  ```

4. Clean Up Generated Files  
To remove all generated files (e.g., .rds, .png, and the rendered report), use:  
```
make clean
```
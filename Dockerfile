FROM rocker/rstudio:4.4.1

# Install dependencies
RUN apt-get update && apt-get install -y pandoc libcurl4-openssl-dev

# Install renv package globally
RUN R -e "install.packages('renv', repos='https://cran.r-project.org')"

# Create project directories
RUN mkdir -p /project/data /project/code /project/output

WORKDIR /project

# Copy renv files
COPY renv.lock /project/renv.lock
COPY renv/activate.R /project/renv/activate.R
COPY renv/settings.json /project/renv/settings.json

# Copy R Markdown report and Makefile
COPY final_report.Rmd /project/final_report.Rmd
COPY Makefile /project/Makefile

# Copy data and code directories
COPY data/ /project/data/
COPY code/ /project/code/

# Restore R environment
RUN Rscript -e "renv::restore(prompt=FALSE)"

# Run the report using Makefile
CMD make final_report.html && mv final_report.html report/

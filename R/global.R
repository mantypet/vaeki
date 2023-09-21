library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)
library(brms)

# Disclaimer: This page uses data from the OpenPowerlifting project, https://www.openpowerlifting.org.
# You may download a copy of the data at https://data.openpowerlifting.org.

download_opl <- function() {
  url <- "https://openpowerlifting.gitlab.io/opl-csv/files/openpowerlifting-latest.zip"
  options(timeout=180)
  download.file(url, "openpowerlifting-latest.zip")
  unzip(zipfile = here::here("openpowerlifting-latest.zip"), exdir = here::here("data/"))
  unlink(x = here::here("openpowerlifting-latest.zip"))
}

read_opl <- function(csv = here::here("data/openpowerlifting-2023-09-09/openpowerlifting-2023-09-09-6e6c522a.csv")) {
  opl <- fread(file = csv, select = c("Name", "Sex", "Age", "BodyweightKg",
                                      "Date", "Event", "Equipment",
                                      "Best3SquatKg", "Best3BenchKg", "Best3DeadliftKg", "TotalKg",
                                      "Tested", "ParentFederation")) %>%
    rename_with(tolower) %>%
    rename(bw = bodyweightkg,
           squat = best3squatkg,
           bench = best3benchkg,
           deadlift = best3deadliftkg,
           total = totalkg,
           fed = parentfederation)
  opl
}

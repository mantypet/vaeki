library(dplyr)
library(data.table)
library(tidyr)
library(ggplot2)
library(brms)
library(lme4)

# Disclaimer: This page uses data from the OpenPowerlifting project, https://www.openpowerlifting.org.
# You may download a copy of the data at https://data.openpowerlifting.org.

download_opl <- function() {
  url <- "https://openpowerlifting.gitlab.io/opl-csv/files/openpowerlifting-latest.zip"
  if(!dir.exists(here::here("data"))) dir.create(here::here("data"))
  download.file(url, here::here("data"))
  unzip(here::here("data/openpowerlifting-latest.zip"))
  unlink(here::here("data/openpowerlifting-latest.zip"))
}

read_opl <- function(csv = here::here("data/openpowerlifting-latest/openpowerlifting-2023-09-16/openpowerlifting-2023-09-16-a8e1bcb4.csv")) {
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

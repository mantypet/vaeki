library(dplyr)

# Disclaimer: This page uses data from the OpenPowerlifting project, https://www.openpowerlifting.org.
# You may download a copy of the data at https://data.openpowerlifting.org.

download_opl <- function() {
  url <- "https://openpowerlifting.gitlab.io/opl-csv/files/openpowerlifting-latest.zip"
  download.file(url, here::here("data/"))
}
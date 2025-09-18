# Sets up R environment
# Created by Petteri Mäntymaa 09/2025

# SET LIBRARIES
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(lubridate)
  library(purrr)
  library(glue)
  library(rvest)
})

# Force locale
locale_fi <- ifelse(.Platform$OS.type == "windows", "Finnish_Finland.1252", "fi_FI.UTF-8")
foo <- Sys.setlocale(category="LC_COLLATE",locale=locale_fi)

#Force working timezone
Sys.setenv("TZ"="Europe/Helsinki")
# Sets up R environment
# Created by Petteri Mäntymaa 09/2025

# SET LIBRARIES
suppressPackageStartupMessages({
  library(dplyr)
  library(forcats)
  library(ggplot2)
  library(glue)
  library(lubridate)
  library(magrittr)
  library(tibble)
  library(tidyr)
  library(purrr)
  library(rvest)
  library(sf)
  library(stringdist)
  library(stringr)
  library(xlsx)
})

# Force locale
locale_fi <- ifelse(.Platform$OS.type == "windows", "Finnish_Finland.1252", "fi_FI.UTF-8")
foo <- Sys.setlocale(category="LC_COLLATE",locale=locale_fi)

#Force working timezone
Sys.setenv("TZ"="Europe/Helsinki")
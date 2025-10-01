# Sets up R spatial data readers
# Created by Petteri Mäntymaa 09/2025

source(here::here("R/global.R"))

#' Download liftingstones.org stone locations as geoJSON
#'
#'
download_liftingstones_org_geojson <- function() {
  url <- "https://liftingstones.org/stones/stones.geoJSON"
  destfile <- file.path(here::here("local_data/"), glue("{Sys.Date()}-mapbox-liftingstones-org.geoJSON"))
  unlink(destfile)
  download.file(url , destfile, method = "auto", mode = "wb")
}

#' Read liftingstone locations in an exploratory list structure by source
#'
read_stones_as_list <- function() {
  stones.lsorg <- read_sf(dsn = here::here("local_data/2025-10-01-mapbox-liftingstones-org.geoJSON"))
  stones.omos <- read_sf(dsn = here::here("local_data/2025-10-01-google-maps-old-man-of-the-stones.kml"))
  stones.msos <- read_sf(dsn = here::here("local_data/2025-10-01-google-maps-modern-stones-of-strength.kml"))
  
  list("liftingstones_org" = stones.lsorg,
       "old_man_of_the_stones" = stones.omos,
       "modern_stones_of_strength" = stones.msos)
}

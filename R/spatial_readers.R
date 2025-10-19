# Sets up R spatial data readers
# Created by Petteri Mäntymaa 09/2025

source(here::here("R/string_parsers.R"))

#' List features available from given WFS service getCapabilities request
#' Tilastokeskus paikkatietohakemisto, kuntapohjaiset tilastointialueet (getCapabilities)
#'
#'
wfs_list_features <- function(url = "https://geo.stat.fi/geoserver/tilastointialueet/wfs?service=WFS&version=2.0.0&request=GetCapabilities") {
  cap_wfs <- read_xml(url)
  types <- xml_find_all(cap_wfs, ".//wfs:FeatureType/wfs:Name", xml_ns(cap_wfs)) |> xml_text()
  types
}

#' Read WFS feature as sf object
#' 
#' 
wfs_read_feature <- function(feature_name = "tilastointialueet:maakunta4500k_2025", url_base = "https://geo.stat.fi/geoserver/tilastointialueet/wfs") {
  url <- glue("{url_base}?service=WFS&version=2.0.0&request=GetFeature&typeName={feature_name}&outputFormat=application/json")
  sf_obj <- read_sf(dsn = url, quiet = TRUE)
  sf_obj
}


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
read_stones_as_list <- function(include_meta = TRUE) {
  stones.lsorg <- read_sf(dsn = here::here("common_data/2025-10-07-mapbox-liftingstones-org.geoJSON"), quiet = TRUE)
  stones.omos <- read_sf(dsn = here::here("common_data/2025-10-07-google-maps-old-man-of-the-stones.kml"), quiet = TRUE)
  stones.msos <- read_sf(dsn = here::here("common_data/2025-10-07-google-maps-modern-stones-of-strength.kml"), quiet = TRUE)
  
  if(!include_meta) {
    stones.lsorg <- stones.lsorg |>
      mutate(source = "liftingstones_org") |>
      select(source, name, geometry)
    stones.omos <- stones.omos |>
      mutate(source = "old_man_of_the_stones") |>
      select(source, name = Name, geometry)
    stones.msos <- stones.msos |>
      mutate(source = "modern_stones_of_strength") |>
      select(source, name = Name, geometry)
  }
  
  list("liftingstones_org" = stones.lsorg,
       "old_man_of_the_stones" = stones.omos,
       "modern_stones_of_strength" = stones.msos)
}

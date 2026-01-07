# Sets up R entry data readers
# Created by Petteri Mäntymaa 09/2025

source(here::here("R/global.R"))

#' Read Finnish open air and other local museums (Suomen kotiseutu- ja paikallismuseot sekä paikalliset erikoismuseot)
#'
#'

read_kotiseutumuseot <- function() {
  url <- "https://kotiseutuliitto.fi/tietopankki/kotiseutumuseot/suomen-kotiseutu-ja-paikallismuseot/"
  
  kotiseutu_html <- read_html(url)
  
  # County hrefs & names
  county_hrefs <- kotiseutu_html |>
    html_nodes("a") |>
    html_attr("href") |>
    extract(43:60)
  
  county_names <- kotiseutu_html |>
    html_nodes("a") |>
    html_text() |>
    extract(43:60)
  
  county.lookup <- tibble(county_href = county_hrefs,
                          county_name = county_names)
  
  read_county_kotiseutu.list <- function(county_href) {
    read_html(county_href) |>
      html_nodes("p") |>
      extract2(1) |>
      as.character()
  }
  
  county_kotiseutu.list <- county.lookup$county_href |>
    purrr::set_names() |>
    map(~ read_county_kotiseutu.list(.x), .progress = TRUE)
  
  county_kotiseutu.tbl <- county_kotiseutu.list |>
    enframe(name = "county_href", value = "kotiseutu_list") |>
    left_join(county.lookup, by = join_by("county_href")) |>
    select(county_name, county_href, kotiseutu_list)
  
  county_kotiseutu.tbl <- readRDS(here::here("local_data/county_kotiseutu.rds"))
  
  county_kotiseutu_long.tbl <- county_kotiseutu.tbl |>
    unnest(kotiseutu_list) |>
    mutate(kotiseutu_list = stringr::str_replace_all(kotiseutu_list, "<.*?>", "|")) |>
    mutate(kotiseutu_list = stringr::str_remove_all(kotiseutu_list, "\n")) |>
    separate_longer_delim(kotiseutu_list, delim = "|") |>
    filter(kotiseutu_list != "") |>
    rename(museum_name = kotiseutu_list)
  
  county_kotiseutu.tbl
}

#'
#'
#'
read_finnish_stones_sources <- function() {
  sources <- data.table::fread(here::here("common_data/back-ups/2026-01-07-finnish-stones-sources.csv"))
}



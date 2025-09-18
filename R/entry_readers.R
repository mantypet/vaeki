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
  
  county_kotiseutu.tbl # TODO: parse kotiseutu string
}





source(here::here("R/global.R"))

parse_weight_kg <- function(weight) {
  weight |>
    str_extract_all("\\d+(?:\\.\\d+)?\\s*kg") |>
    map(~str_remove_all(.x, "\\s")) |>
    map(~paste(.x, collapse = ",")) |>
    unlist()
}

parse_weight_lb <- function(weight) {
  weight |>
    str_extract_all("\\d+(?:\\.\\d+)?\\s*lb") |>
    map(~str_remove_all(.x, "\\s")) |>
    map(~paste(.x, collapse = ",")) |>
    unlist()
}

weight_as_numeric <- function(weight_string) {
  str_remove_all(weight_string, "kg|lb") |>
    as.numeric()
}

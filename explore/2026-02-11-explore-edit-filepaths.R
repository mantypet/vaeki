source(here::here("R/global.R"))

filenames.tbl <- tibble(filename = list.files(path = here::here("common_data/mattilan-mummu/")))

separate.tbl <- filenames.tbl |>
  separate_wider_regex(
    filename,
    patterns = c(
      letters   = "[a-z]+",
      numbers   = "[0-9]+",
      extension = "\\.txt"
    )
  ) |>
  mutate(date = dmy(numbers)) |>
  mutate(filename_new = glue("{date}-{letters}{extension}"))

filepaths_from <- file.path(here::here("common_data/mattilan-mummu/", filenames.tbl$filename))
filepaths_to <- file.path(here::here("common_data/mattilan-mummu/", separate.tbl$filename_new))

file.rename(from = filepaths_from, to = filepaths_to)

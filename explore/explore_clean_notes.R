source(here::here("R/entry_readers.R"))

sources <- read_finnish_stones_sources()

notes <- sources |>
  select(source_id, notes_raw_fi, notes_clean_fi)

write.csv(notes,
          file = here::here("common_data/notes-clean.csv"),
          fileEncoding = "UTF-8",
          row.names = FALSE)

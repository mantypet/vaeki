source(here::here("R/entry_readers.R"))

# county_kotiseutu_long.tbl <- read_kotiseutumuseot()
county_kotiseutu_long.tbl <- readRDS(here::here("local_data/county_kotiseutu.rds"))

# Classify local museums likely related
county_kotiseutu_long_aux.tbl <- county_kotiseutu_long.tbl |>
  mutate(museum_type = case_when(str_detect(tolower(museum_name), "tupa|kotiseutu|museoalue|talomuseo|ulkomuseo|pitäjä|perinnealue|perinnetila|talonpoika|torppa|hembygd|torgare|häjy|alahärmän museo") ~ "backlog",
                                 TRUE ~ "")) |>
  mutate(museum_address = "",
         museum_coordinates = "") |>
  as.data.frame()

file_path = here::here("common_data/2025-09-20-finnish-local-museums.xlsx")
unlink(file_path)

write.xlsx(x = county_kotiseutu_long_aux.tbl,
           file = file_path,
           sheetName = "museums_list",
           col.names = TRUE,
           row.names = FALSE,
           append = FALSE)

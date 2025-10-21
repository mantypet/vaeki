source(here::here("R/spatial_readers.R"))

finstones <- read_sf(dsn = here::here("common_data/2025-10-19-finnish-stones.kml"), quiet = TRUE) |>
  transmute(stone_name_fi = Name) |>
  st_transform(crs = 3067)

finstones.excel <- finstones |>
  st_drop_geometry() |>
  as.data.frame()

finstones_append <- read.csv(here::here("common_data/2025-10-21-finnish-stones.csv")) |>
  as.data.frame()
 
feature_name <- "tilastointialueet:maakunta4500k_2025"
crs <- 3067
d_maakunta2025 <- wfs_read_feature(feature_name) |>
  st_transform(crs = crs) |>
  transmute(feature_name = feature_name,
            maakunta_code = maakunta,
            maakunta_name_fi = nimi,
            maakunta_name_sv = namn,
            maakunta_name_en = name)

write_sf(d_maakunta2025,
         dsn = here::here("common_data/2025-10-21-d_maakunta.geoJSON"),
         driver = "GeoJSON",
         delete_dsn = TRUE)



finstones.rep <- finstones |>
  st_join(d_maakunta2025, join = st_within)


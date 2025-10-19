source(here::here("R/spatial_readers.R"))

finstones <- read_sf(dsn = here::here("common_data/2025-10-19-finnish-stones.kml"), quiet = TRUE) |>
  transmute(name = Name) |>
  st_transform(crs = 3067)

d_maakunta2025 <- wfs_read_feature(feature_name = "tilastointialueet:maakunta4500k_2025") |>
  st_transform(crs = 3067) |>
  transmute(maakunta_code = maakunta,
            maakunta_name_fi = nimi,
            maakunta_name_sv = namn,
            maakunta_name_en = name)

finstones.rep <- finstones |>
  st_join(d_maakunta2025, join = st_within)

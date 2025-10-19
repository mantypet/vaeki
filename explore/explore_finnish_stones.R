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

# Read common_data/2025-10-19-finnish-stones.kml as xml
library(xml2)

doc <- read_xml(here::here("common_data/2025-10-19-finnish-stones.kml"))

descriptions <- xml_find_all(doc, ".//gx:CascadingStyle")

test <- xml_child(xml_child(xml_child(xml_child(xml_child(doc, 1), 2), 1), 5), 1)

desc_texts <- xml_text(descriptions)

length(desc_texts)
cat(substr(desc_texts[1], 1, 300))
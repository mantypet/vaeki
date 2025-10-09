source(here::here("R/spatial_readers.R"))

# Read stone locations and info
stones.meta.list <- read_stones_as_list(include_meta = TRUE)
stones.meta.tbl <- bind_rows(stones.meta.list, .id = "data_source") |>
  mutate(location_id = row_number(),
         name = coalesce(name, Name)) |>
  st_as_sf()

data_source <- "liftingstones_org"

liftingstones.historic <- stones.meta.tbl |>
  filter(data_source == data_source & category %in% c("historic", "cultural")) |>
  st_as_sf()

historic.rep <- liftingstones.historic |>
  mutate(weight_kg = parse_weight_kg(weight),
         weight_lb = parse_weight_lb(weight),
         name_sep = str_replace_all(name, pattern = " and ", replacement = ",")) |>
  separate_longer_delim(cols = c(name_sep,weight_kg,weight_lb), delim = ",") |>
  mutate(i = 1) |>
  group_by(location_id) |>
  mutate(stone_index = cumsum(i)) |>
  mutate(name_rep = glue("{name_sep} ({stone_index})"),
         weight_kg = weight_as_numeric(weight_kg),
         weight_lb = weight_as_numeric(weight_lb)) |>
  select(data_source, location_id, name_rep, weight_kg, weight_lb, geometry)

# plots
ggplot2

# map plots
world <- ne_countries(scale = "medium", returnclass = "sf")
ggplot() +
  geom_sf(data = world, fill= "antiquewhite") +
  geom_sf(data = liftingstones_org_stones.tbl, aes(color = data_source), size = 1.5) +
  coord_sf(xlim = c(-30, 35), ylim = c(45, 75), expand = FALSE) +
  scale_color_manual(values = c("liftingstones_org" = "lightblue")) +
  theme(panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "aliceblue"))



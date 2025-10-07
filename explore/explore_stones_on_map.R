source(here::here("R/spatial_readers.R"))

stones.list <- read_stones_as_list(include_meta = FALSE)

stones.tbl <- bind_rows(stones.list, .id = "source") |>
  mutate(stone_id = row_number()) |>
  select(stone_id, source, name, geometry) |>
  st_as_sf()

stones.meta.list <- read_stones_as_list(include_meta = TRUE)
stones.meta.tbl <- bind_rows(stones.meta.list, .id = "source") |>
  mutate(stone_id = row_number(),
         name = coalesce(name, Name)) |>
  select(stone_id, source, name, everything()) |>
  st_as_sf()

liftingstones_org_stones.tbl <- stones.meta.tbl |>
  filter(source == "liftingstones_org" & category %in% c("historic", "cultural")) |>
  select(stone_id, source, name, geometry) |>
  st_as_sf()

world <- ne_countries(scale = "medium", returnclass = "sf")
ggplot() +
  geom_sf(data = world, fill= "antiquewhite") +
  geom_sf(data = liftingstones_org_stones.tbl, aes(color = source), size = 1.5) +
  coord_sf(xlim = c(-30, 35), ylim = c(45, 75), expand = FALSE) +
  scale_color_manual(values = c("liftingstones_org" = "lightblue")) +
  theme(panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "aliceblue"))



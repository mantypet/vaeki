source(here::here("R/spatial_readers.R"))

stones.list <- read_stones_as_list(include_meta = FALSE)

# Infer is the same stone
distance_mat <- st_distance(stones.list[[1]], stones.list[[2]])

name_distance_mat <- stringdistmatrix(c(stones.list[[1]]$name), stones.list[[2]]$name)

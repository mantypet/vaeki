source(here::here("R/spatial_readers.R"))

stones.list <- read_stones_as_list(include_meta = FALSE)



# Infer is the same stone
distance_mat <- st_distance(stones.list[[1]], stones.list[[2]])

name_distance_mat <- stringdistmatrix(c(stones.list[[1]]$name), stones.list[[2]]$name)
colnames(name_distance_mat) <- stones.list[[2]]$name
rownames(name_distance_mat) <- stones.list[[1]]$name
name_distance_mat <- as.data.frame(name_distance_mat) |>
  rownames_to_column(var = "stone_name_liftingstones_org") |>
  pivot_longer(cols = -stone_name_liftingstones_org, names_to = "stone_name")
  
  
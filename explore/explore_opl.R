source(here::here("R/global.R"))

opl <- read_opl()

opl.rep <- opl %>%
  filter(age > 0 & bw > 0) %>%
  filter(sex %in% c("F","M"))

opl.dl <- opl.rep %>%
  group_by(name) %>%
  filter(deadlift == max(deadlift)) %>%
  ungroup()


# Representation by equipment (Raw & Wraps)
opl.dl %>%
  count(sex, equipment) %>%
  pivot_wider(names_from = sex, values_from = n) %>%
  mutate(rf = F/(M+F),
         rm = M/(M+F))

# Representation by event (SBD)
opl.dl %>%
  count(sex, event) %>%
  pivot_wider(names_from = sex, values_from = n) %>%
  mutate(rf = F/(M+F),
         rm = M/(M+F))

# Representation by testing
opl.dl %>%
  count(sex, tested) %>%
  mutate(tested = ifelse(tested == "", "No", tested)) %>%
  pivot_wider(names_from = tested, values_from = n) %>%
  mutate(rf = Yes/(Yes+No))

opl.dl.rep <- opl.dl %>%
  filter(equipment %in% c("Raw", "wraps"))

fit0 <- brm(deadlift ~ bw + age, data = opl.dl.rep, family = gaussian())



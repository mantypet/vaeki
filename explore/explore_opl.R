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

# Age & bodyweight distributions
ggplot(opl.dl) +
  geom_density(aes(x = bw, fill = sex), alpha = 0.2)

ggplot(opl.dl) +
  geom_density(aes(x = age, fill = sex), alpha = 0.2)

ggplot(mod_df) +
  geom_density_2d(aes(x = bw, y = deadlift/bw)) +
  facet_grid(rows = vars(sex))

opl.dl.raw.rep <- opl.dl %>%
  filter(equipment %in% c("Raw")) %>%
  filter(!is.na(fed))

mod_df <- opl.dl.raw.rep %>%
  filter(bwclass == "67.5")

fit0a <- glm(deadlift ~ bw + age, data = mod_df, family = gaussian())
fit0b <- glm(deadlift ~ poly(bw,2) + age, data = mod_df, family = gaussian())
fit0bb <- glm(deadlift ~ bw + poly(age,2), data = mod_df, family = gaussian())
fit0bbb <- glm(deadlift ~ poly(age,2), data = mod_df, family = gaussian())
fit0c <- glm(deadlift ~ poly(bw,2) + poly(age,2), data = mod_df, family = gaussian())
summary(fit0a)
summary(fit0b)
summary(fit0c)
BIC(fit0a, fit0b, fit0bb, fit0bbb, fit0c)

fit1a <- glm(deadlift ~ poly(bw,2) + poly(age,2) + sex, data = mod_df, family = gaussian())
fit1b <- glm(deadlift ~ poly(bw,2)*sex + poly(age,2)*sex, data = mod_df, family = gaussian())
fit1aa <- glm(deadlift ~ bw + poly(age,2) + sex, data = mod_df, family = gaussian())
fit1bb <- glm(deadlift ~ bw*sex + poly(age,2)*sex, data = mod_df, family = gaussian())
fit1bbb <- glm(deadlift ~ bw*sex + age*sex, data = mod_df, family = gaussian())
summary(fit1a)
summary(fit1b)
BIC(fit1a, fit1b, fit1aa, fit1bb, fit1bbb)

fit2a <- lmer(deadlift ~ poly(bw,2)*sex + poly(age,2)*sex + (1 | fed), data = mod_df, REML = FALSE)
fit2a_ <- brm(deadlift ~ bw*sex + age*sex + (1 | fed), data = mod_df, family = gaussian())
fit2aa_ <- brm(deadlift ~ bw*sex + age*sex + (1 | fed), data = mod_df, family = gaussian())


summary(fit1b)
summary(fit2a)
summary(fit2a_, WAIC = TRUE)

plot(fit2a_)

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

mod_df <- opl.dl.rep %>% sample_n(1000)

#fit0 <- brm(deadlift ~ bw + age, data = mod_df, family = gaussian())
fit0 <- glm(deadlift ~ bw + age, data = opl.dl.rep, family = gaussian())
fit1 <- glm(deadlift ~ bw + age + sex, data = opl.dl.rep, family = gaussian())
fit2 <- lmer(deadlift ~ bw + age + (1 | sex), data = opl.dl.rep, REML = FALSE)
summary(fit0)
summary(fit1)
summary(fit2)
BIC(fit0, fit1, fit2)

coef(summary(fit2))
hist(resid(fit2))

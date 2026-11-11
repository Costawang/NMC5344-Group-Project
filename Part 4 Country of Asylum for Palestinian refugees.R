library(tidyverse)

palestine_2025 <- read_csv(
  "persons_of_concern_demographics(1).csv",
  show_col_types = FALSE
) %>%
  filter(
    Year == 2025,
    `Country of Origin ISO` == "PSE"
  ) %>%
  transmute(
    country = `Country of Asylum`,
    iso3 = `Country of Asylum ISO`,
    total = Total
  )

gdp_2025 <- read_csv(
  "API_NY.GDP.PCAP.CD_DS2_en_csv_v2_1529.csv",
  skip = 4,
  show_col_types = FALSE
) %>%
  transmute(
    iso3 = `Country Code`,
    gdp_pc = as.numeric(`2025`)
  )

population_2025 <- read_csv(
  "API_SP.POP.TOTL_DS2_en_csv_v2_258623.csv",
  skip = 4,
  show_col_types = FALSE
) %>%
  transmute(
    iso3 = `Country Code`,
    host_population = as.numeric(`2025`)
  )

merged_2025 <- palestine_2025 %>%
  left_join(gdp_2025, by = "iso3") %>%
  left_join(population_2025, by = "iso3")

merged_2025 %>%
  filter(is.na(gdp_pc) | is.na(host_population)) %>%
  select(country, gdp_pc, host_population)

analysis_2025 <- merged_2025 %>%
  drop_na(total, gdp_pc, host_population)

nrow(merged_2025)    # 81
nrow(analysis_2025)  # 77

analysis_2025 %>%
  arrange(desc(total)) %>%
  slice_head(n = 10)

model_2025 <- lm(
  log1p(total) ~ log(gdp_pc) + log(host_population),
  data = analysis_2025
)

summary(model_2025)

#A multiple linear regression was conducted using 2025 data from 77 host countries. UNHCR refugee data were merged with GDP per capita and population data from the World Bank using country codes. Palestinian refugee numbers were the dependent variable, while GDP per capita and host-country population were the independent variables. Refugee numbers were transformed using log(total + 1), and both predictors were natural-log transformed to reduce skewness.
#Both GDP per capita (b = 0.840, p < .001) and population size (b = 0.338, p = .012) were positively associated with refugee numbers, controlling for the other variable. Countries with higher GDP per capita or larger populations therefore tended to host more Palestinian refugees. The model was statistically significant, F(2, 74) = 14.03, p < .001, and explained 27.5% of the variation in log-transformed refugee numbers (adjusted R² = .255).

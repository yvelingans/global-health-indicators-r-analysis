# ============================================================
# Global Health Indicators from World Bank WDI
# Data extraction and preparation script
# Author: Yvelin Gansou
# ============================================================

# Packages
library(WDI)
library(dplyr)

# ------------------------------------------------------------
# 1. Define selected global health indicators
# ------------------------------------------------------------

indicators <- c(
  life_exp          = "SP.DYN.LE00.IN",
  infant_mortality = "SP.DYN.IMRT.IN",
  vaccination_dtp  = "SH.IMM.IDPT",
  water_basic      = "SH.H2O.BASW.ZS",
  physicians       = "SH.MED.PHYS.ZS",
  health_exp_pc    = "SH.XPD.CHEX.PC.CD"
)

# ------------------------------------------------------------
# 2. Download WDI data in two blocks to avoid API issues
# ------------------------------------------------------------

raw_00_10 <- WDI(
  country = "all",
  indicator = indicators,
  start = 2000,
  end = 2010
)

raw_11_21 <- WDI(
  country = "all",
  indicator = indicators,
  start = 2011,
  end = 2021
)

raw <- bind_rows(raw_00_10, raw_11_21)

# ------------------------------------------------------------
# 3. Add country metadata: region and income group
# ------------------------------------------------------------

data("WDI_data")

metadata <- WDI_data$country %>%
  select(iso3c, region, income) %>%
  distinct()

health <- raw %>%
  left_join(metadata, by = "iso3c") %>%
  filter(
    !is.na(iso3c),
    iso3c != "",
    !is.na(region),
    region != "Aggregates"
  )

# ------------------------------------------------------------
# 4. Create time-series dataset
# ------------------------------------------------------------

health_ts <- health %>%
  select(
    country, iso3c, year, region, income,
    life_exp, infant_mortality, vaccination_dtp,
    water_basic, physicians, health_exp_pc
  )

# ------------------------------------------------------------
# 5. Create 2021 cross-sectional dataset
# ------------------------------------------------------------

health_2021 <- health_ts %>%
  filter(year == 2021)

# ------------------------------------------------------------
# 6. Remove physicians variable due to missingness
# ------------------------------------------------------------

health_2021 <- health_2021 %>%
  select(-physicians)

health_ts <- health_ts %>%
  select(-physicians)

# ------------------------------------------------------------
# 7. Keep complete cases for key 2021 indicators
# ------------------------------------------------------------

vars_needed <- c(
  "life_exp",
  "infant_mortality",
  "vaccination_dtp",
  "water_basic",
  "health_exp_pc"
)

health_2021 <- health_2021 %>%
  filter(if_all(all_of(vars_needed), ~ !is.na(.)))

# ------------------------------------------------------------
# 8. Inspect prepared datasets
# ------------------------------------------------------------

str(health_2021)
str(health_ts)

colSums(is.na(health_2021))
colSums(is.na(health_ts))

dim(health_2021)
dim(health_ts)

# ------------------------------------------------------------
# 9. Save prepared datasets
# ------------------------------------------------------------

save(
  health_2021,
  health_ts,
  file = "Health_WDI_Global_Health_Indicators.RData"
)
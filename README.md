# Global Health Indicators Analysis with R

## Overview

This project analyzes and visualizes global health indicators using R and World Bank World Development Indicators (WDI) data.

The analysis focuses on cross-country differences in life expectancy, infant mortality, DTP immunization coverage, access to basic drinking water services, and current health expenditure per capita.

The project demonstrates an end-to-end public health data workflow, including data extraction, data preparation, exploratory analysis, visualization, time-series analysis, and world mapping.

## Objectives

The main objectives are to:

- Extract global health indicators from the World Bank WDI API
- Prepare clean country-level health datasets
- Analyze global patterns in life expectancy
- Compare health indicators across regions and income groups
- Examine associations between life expectancy and selected health determinants
- Visualize temporal trends from 2000 to 2021
- Produce world maps of selected health indicators

## Data Source

The data are extracted using the R package `WDI`, which provides access to World Bank World Development Indicators.

Selected indicators include:

| Indicator | WDI Code |
|---|---|
| Life expectancy at birth | `SP.DYN.LE00.IN` |
| Infant mortality rate | `SP.DYN.IMRT.IN` |
| DTP immunization coverage | `SH.IMM.IDPT` |
| Access to basic drinking water services | `SH.H2O.BASW.ZS` |
| Physicians per 1,000 people | `SH.MED.PHYS.ZS` |
| Current health expenditure per capita | `SH.XPD.CHEX.PC.CD` |

## Project Structure

```text
global-health-indicators-r-analysis/
│
├── README.md
├── 01_download_wdi_health_data.R
├── global_health_indicators_analysis.Rmd
└── .gitignore

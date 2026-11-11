# NMC5344 Group Project - Group 7

An analysis of Palestinian-origin persons of concern in global receiving countries during 2020-2025, with a global distribution overview, demographic and geographical visualisations, a negative-binomial mixed model (Model 1), and multiple linear regression (Model 2).

**Authors:** Wang Xinyang, Li Yunrui, Wu Xia, Sun Yinan, Dong Jing

## Report files

- [Final report (PDF)](NMC5344_Final_Report.pdf)
- [R Markdown source](NMC5344_Final_Report.Rmd), including the analysis code, figures, model results, discussion and references.

The four original group contribution scripts are also available in this repository.

## Reproducing the report

Open the final Rmd in RStudio, install the packages listed in its setup chunk, and select **Knit to PDF**. A working XeLaTeX installation is required.

The analysis uses the supplied UNHCR demographic extract and World Bank 2025 indicator snapshots. Place these separately supplied CSV files in a `data/` folder beside the Rmd:

- `persons_of_concern_demographics.csv`
- `gdp_pc_2025.csv`
- `host_population_2025.csv`

The data files are not included in this repository. The PDF can be read without running R.

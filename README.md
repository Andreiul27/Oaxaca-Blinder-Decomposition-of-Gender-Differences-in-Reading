# Oaxaca-Blinder-Decomposition-of-Gender-Differences-in-Reading
SPSS syntax and R code from my Master's thesis analyzing PISA 2018 reading achievement. 
Computes composite indices (SCIR, READJOYFREQ, PDIR), runs IDB Analyzer correlation/regression analyses with BRR weights, and tests CFA measurement models in R (lavaan)

## Contents

- **`pisa2018_analysis.sps`** — all SPSS syntax, combining:
  - Computation of three composite indices: `SCIR`, `READJOYFREQ`, `PDIR` (recoded/averaged from PISA questionnaire items)
  - Pairwise and PV-based correlations among reading-related variables, by country (via IDB Analyzer `JB_Cor` / `JB_CorP` macros)
  - Mean reading achievement by gender (`JB_PV` macro)
  - Mean difference analysis by gender (`JB_Gen` macro)
  - Pooled regression with gender as a dummy variable, and gender-specific regression models (`JB_RegGP` macro)
  - Collinearity diagnostics (tolerance/VIF) for the regression predictors
  - Inter-item correlation matrix and Cronbach's alpha for the index items
- **`cfa_analysis.R`** — confirmatory factor analysis (lavaan) testing a one-factor (`SCIR`) and two-factor (`SCIR` + `PDIR`) measurement model, with path diagrams (semPlot) and a likelihood-ratio model comparison.

## Data

This repository does **not** include the PISA 2018 dataset. The analysis uses the OECD PISA 2018 public-use student questionnaire and cognitive data file (`PISA_2018.sav`), available from the [OECD PISA data portal](https://www.oecd.org/pisa/data/2018database/). Download the relevant `.sav` file and place it in your project folder before running.

## Requirements

- **IBM SPSS Statistics** with the **IEA IDB Analyzer (v5.0.5)** installed, for the macro-based sections (B.2–B.7). The IDB Analyzer is a free tool from the IEA, downloadable from [iea.nl](https://www.iea.nl/data-tools/tools).
- **R** with the following packages, for the CFA script:

```r
install.packages(c("readxl", "lavaan", "semPlot", "psych", "haven"))
```

## Usage

### SPSS syntax
1. Open `pisa2018_analysis.sps` in SPSS.
2. Replace the `<PROJECT_DIR>` placeholder with the folder containing your PISA `.sav` file, and `<MACRO_DIR>` with your local IDB Analyzer macros folder (default: `C:\Users\<your-username>\AppData\Roaming\IEA\IDBAnalyzerV5\bin\Data\Templates\SPSS_Macros`).
3. Run section B.1 first to compute the composite indices, then run the remaining sections as needed — each IDB Analyzer block is self-contained (select the `JB_*` block and press Ctrl+A then Ctrl+R, per the IDB Analyzer convention).

### R script
1. Open `cfa_analysis.R`.
2. Set `PROJECT_DIR` to your local folder containing `PISA2018 - Copy.sav` (a version of the dataset with the recoded items from B.1 already saved).
3. Run top to bottom. Note the flagged possible typo before the second `semPaths()` call — verify the model object name before running that section.

## Notes

- Encoding varies by section (UTF-8 vs. windows-1252) per the original SPSS export — kept as-is per section.
- All weighting uses the PISA final student weight (`W_FSTUWT`) and BRR replicate weights (`W_FSTURWT`), per standard PISA analytical guidelines.


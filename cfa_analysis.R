# ============================================================
# PISA 2018 — Confirmatory Factor Analysis (CFA)
# Appendix B.8 of thesis
# ============================================================
# BEFORE RUNNING: update PROJECT_DIR below to your local folder
# containing "PISA2018 - Copy.sav".

library(readxl)
library(lavaan)
library(semPlot)
library(psych)
library(haven)

PROJECT_DIR <- "<path-to-your-project-folder>"  # e.g. "C:/Users/<you>/Desktop/PISA THESIS"
setwd(PROJECT_DIR)

PISA2018_Copy <- read_sav(file.path(PROJECT_DIR, "PISA2018 - Copy.sav"))

# --- Single-factor model: SCIR ---
SCIR <- "SCIR =~ ST161Q01HA + ST161Q02HA + ST161Q03HA + ST161Q06R + ST161Q07R + ST161Q08R"

SCIR1 <- cfa(SCIR,
             data = PISA2018_Copy,
             std.lv = TRUE, estimator = "ML")

summary(SCIR1, standardized = TRUE, rsquare = TRUE, fit.measures = TRUE)

# --- Two-factor model: SCIR and PDIR ---
SCIRANDPDIR <- "SCIR =~ ST161Q01HA + ST161Q02HA + ST161Q03HA 
        PDIR =~ ST161Q06R + ST161Q07R + ST161Q08R"

SCIRANDPDIR1 <- cfa(SCIRANDPDIR,
                     data = PISA2018_Copy,
                     std.lv = TRUE, estimator = "ML")

summary(SCIRANDPDIR1, standardized = TRUE, rsquare = TRUE, fit.measures = TRUE)

# --- Path diagrams ---
semPaths(SCIR1,
         whatLabels = "std", intercepts = FALSE, style = "lisrel",
         nCharNodes = 0,
         nCharEdges = 0,
         rotation = 4,
         edge.label.position = 0.5,
         edge.label.cex = 0.8,
         sizeMan = 4.0,
         curveAdjacent = TRUE, title = TRUE, layout = "tree2", curvePivot = TRUE, color = "lightblue")

# NOTE: the object below is referenced as "SCIRANDNPDIR1" in the original script,
# but the model fitted above is named "SCIRANDPDIR1" (no "N"). This looks like a
# typo — verify which object you intend to plot before running.
semPaths(SCIRANDNPDIR1,
         whatLabels = "std", intercepts = FALSE, style = "lisrel",
         nCharNodes = 0,
         nCharEdges = 0,
         rotation = 4,
         edge.label.position = 0.5,
         edge.label.cex = 0.8,
         sizeMan = 4.0,
         curveAdjacent = TRUE, title = TRUE, layout = "tree2", curvePivot = TRUE, color = "lightblue")

# --- Model comparison ---
anova(SCIR1, SCIRANDPDIR1)

# --- Save updated dataset (with recoded/computed indices) back to .sav ---
write_sav(PISA2018_Copy, "PISA_2018.sav")

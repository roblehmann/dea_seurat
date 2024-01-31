# scRNA-seq Differential Expression Analysis & Visualization Snakemake Workflow powered by Seurat
A [Snakemake](https://snakemake.readthedocs.io/en/stable/) workflow for performing differential expression analyses (DEA) of sc/snRNA-seq data powered by the R package [Seurat's](https://satijalab.org/seurat/index.html) functions [FindMarkers](https://satijalab.org/seurat/reference/findmarkers) and [FindAllMarkers](https://satijalab.org/seurat/reference/findallmarkers).

![Workflow Rulegraph](./workflow/dags/rulegraph.svg)

Table of contents
----------------
  * [Authors](#authors)
  * [Software](#software)
  * [Methods](#methods)
  * [Features](#features)
  * [Usage](#usage)
  * [Configuration](#configuration)
  * [Examples](#examples)
  * [Links](#links)

# Authors
- adapted from the dea_seurat by [Stephan Reichl](https://github.com/sreichl)

# Features
The workflow perfroms the following steps.
- Differential Expression Analysis (DEA)
  - using Seurat's [FindMarkers](https://satijalab.org/seurat/reference/findmarkers) or [FindAllMarkers](https://satijalab.org/seurat/reference/findallmarkers) depending on the configuration (CSV)
  - feature list per comparison group and direction (up/down) for downstream analysis (eg enrichment analysis) (TXT)
  - (optional) feature score tables (with two columns: "feature" and "score") per comparison group using {score_formula} for downstream analyses (eg preranked enrichment analysis) (CSV).
- DEA result statistics: number of statistically significant results split by positive (up) and negative (down) change (CSV)
- DEA result filtering by 
  - statistical significance (adjusted p-value)
  - effect-size (log 2 fold change)
  - expression (minimum percentage of expression) in one of the comparison groups
- Log Fold Change (LFC) matrix of filtered features by comparison groups (CSV)
- Visualizations
  - all and filtered DEA result statistics: number of features and direction (stacked Bar plots)
  - Volanco plot per comparison with configured cutoffs for statistical significance and effect-size
  - Clustered Heatmaps of the LFC matrix

# Configuration
Detailed specifications can be found here [./config/README.md](./config/README.md)

# Examples
The folder [test_data](https://github.com/roblehmann/dea_seurat/tree/main/test_data) contains two test data sets for naive and memory T-Cells obtained from the following publication: [Single-cell transcriptomics identifies an effectorness gradient shaping the response of CD4+ T cells to cytokines](https://www.nature.com/articles/s41467-020-15543-y). The (Memory/Naive)_Tcells_counts.rds and (Memory/Naive)_Tcells_metadata.csv files contain the count matrix and cell metadata, respectively. Both need to be combined to create a Seurat input object for the pipeline.

# Software
This project wouldn't be possible without the following software and their dependencies:

| Software       | Reference (DOI)                                   |
| :------------: | :-----------------------------------------------: |
| EnhancedVolcano| https://doi.org/10.18129/B9.bioc.EnhancedVolcano  |
| ggplot2        | https://ggplot2.tidyverse.org/                    |
| patchwork      | https://CRAN.R-project.org/package=patchwork      |
| pheatmap       | https://cran.r-project.org/package=pheatmap       |
| Seurat         | https://doi.org/10.1016/j.cell.2021.04.048        |
| Snakemake      | https://doi.org/10.12688/f1000research.29032.2    |

# Links
- [GitHub Repository](https://github.com/roblehmann/dea_seurat/)
- [Snakemake Workflow Catalog Entry](https://snakemake.github.io/snakemake-workflow-catalog?usage=epigen/dea_seurat)

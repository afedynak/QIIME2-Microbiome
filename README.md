# Microbiome Diversity Analysis with QIIME2 and ANCOMBC

The primary focus of this project is to understand how microbiome diversity varies across genotypes, ages, and disease progression, using various diversity metrics and statistical methods.

## 🧪 Analyses Performed

### 1. **Alpha Diversity** (Shannon Index)
- Calculated the **Shannon diversity index** to measure within-sample diversity for different genotypes and ages.
- Visualized using boxplots to compare diversity across different **genotypes** and **ages**.

### 2. **Beta Diversity** (Bray-Curtis)
- Performed **Bray-Curtis dissimilarity** calculations to compare microbiome composition between samples.
- Visualized using **Principal Coordinates Analysis (PCoA)**, with colors indicating different **genotypes**.

### 3. **PERMANOVA**
- Conducted a **PERMANOVA test** to assess statistical differences in microbiome composition between groups.
- Used **genotype** as a grouping variable to identify significant effects.
- The output includes a test statistic (`pseudo-F`) and a p-value to determine if the groups are significantly different.

### 5. **ANCOMBC (Analysis of Composition of Microbiomes with Bias Correction)**
- **ANCOMBC** was used to identify differentially abundant taxa between groups (genotype, age).
- Multiple comparisons were made, and differential abundance results were visualized through **barplots** and **significance plots**.
- The results help identify which taxa show significant differences based on genotype and age, shedding light on microbiome shifts due to AD progression.

---

## 📊 Data and Outputs

- **Alpha Diversity** (`shannon.qza`): Shannon diversity index for each sample
- **Beta Diversity** (`distance-matrix.qza`, `pcoa.qza`): Bray-Curtis distance matrix and PCoA plots
- **PERMANOVA Results**: Statistical test for significant differences in microbiome composition
- **LME Results**: Linear mixed-effects models evaluating the impact of genotype and age on microbiome diversity
- **ANCOMBC Results**: Differentially abundant taxa identified across different groups and time points

---

## 🛠️ Scripts

### `alpha_beta_diversity.R`
- **Alpha Diversity**: Calculates Shannon index and generates boxplots
- **Beta Diversity**: Generates PCoA plots based on Bray-Curtis dissimilarity
- **Statistical Tests**: Includes PERMANOVA for beta diversity comparisons

### `ancombc_analysis.R`
- Conducts **ANCOMBC** on microbiome data, testing for differential abundance of taxa across genotype and age groups
- Generates **barplots** of results and highlights significant taxa

---

## 📥 Data

To run the analyses, you will need the following data:

- **`metadata.txt`**: Metadata file containing information about the samples, including genotype, age, and individual IDs.
- **`shannon.qza`**: Alpha diversity output (Shannon Index).
- **`distance-matrix.qza`**: Bray-Curtis distance matrix.
- **`pcoa.qza`**: PCoA coordinates for beta diversity visualization.
- **`ancombc.qza`**: ANCOMBC differential abundance results.

---

## 📋 Instructions

1. **Prepare Data**: Ensure that all the necessary files (`.qza`, `.txt`) are in the correct format and available.
2. **Run Scripts**:
   - Execute the R scripts for **alpha diversity** (`alpha_beta_diversity.R`) and **ANCOMBC** (`ancombc_analysis.R`).
3. **Review Outputs**: Review the plots and statistical tests generated in the **results/ folder**.
4. **Interpret Results**: Use the **PERMANOVA**, and **ANCOMBC** outputs to understand the microbiome’s response to different **genotypes** and **ages**.

---

## 📝 Example Outputs

Here’s a sample of the types of figures you’ll generate:
- **Alpha Diversity Boxplot**: Shows variation in Shannon index across different genotypes and ages.
- **Beta Diversity PCoA Plot**: Visualizes clustering of samples based on Bray-Curtis dissimilarity.
- **ANCOMBC Differential Abundance Barplots**: Highlights significantly different taxa between groups.

---

## 🖋️ Authors

All scripts in this repository were created by Amber Fedynak, who led the development of bioinformatics pipelines, data processing, and analysis for integrating genetic variants, longitudinal health metrics, and microbiome data

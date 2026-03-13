#!/bin/bash

# ------------------------------------------------------------
# Author: Amber Fedynak
# Description:
# Longitudinal microbiome analysis using QIIME2 ANCOMBC
# Step 1) Compare all groups against a baseline reference (C57BL6J_2)
# Step 2) Track changes over time within each genotype
# ------------------------------------------------------------

# ---------------------------
# Reference / baseline group
# ---------------------------
baseline_ref="C57BL6J_2"

# ---------------------------
# Genotypes to analyze longitudinally
# ---------------------------
genotypes=("C57BL6J" "5xFAD_carrier" "5xFAD_noncarrier")

# ---------------------------
# Time points
# ---------------------------
time_points=("2" "6" "12")

# ---------------------------
# Taxonomic levels
# ---------------------------
taxonomic_levels=("phylum" "family" "genus" "species")

# ---------------------------
# Step 1: Compare all groups against baseline
# ---------------------------
for tax_level in "${taxonomic_levels[@]}"; do
    for genotype in "${genotypes[@]}"; do
        for time in "${time_points[@]}"; do
            sample="${genotype}_${time}"

            # Skip baseline vs itself
            if [[ "$sample" == "$baseline_ref" ]]; then
                continue
            fi

            echo "Running ANCOMBC: $sample vs $baseline_ref at $tax_level level"

            qiime composition ancombc \
                --i-table collapsed-table_"$tax_level".qza \
                --m-metadata-file jax_iu_pitt_metadata_v3.txt \
                --p-formula "genotype" \
                --p-reference-levels "genotype::$baseline_ref" \
                --o-differentials "ancombc_${tax_level}_${sample}_vs_${baseline_ref}.qza" \
                --verbose

            # Generate barplot
            qiime composition da-barplot \
                --i-data "ancombc_${tax_level}_${sample}_vs_${baseline_ref}.qza" \
                --o-visualization "ancombc_${tax_level}_${sample}_vs_${baseline_ref}.qzv"

            # Barplot with significance threshold
            qiime composition da-barplot \
                --i-data "ancombc_${tax_level}_${sample}_vs_${baseline_ref}.qza" \
                --p-level-delimiter ";" \
                --p-significance-threshold 0.05 \
                --o-visualization "ancombc_${tax_level}_${sample}_sig_vs_${baseline_ref}.qzv"

            # Extract results
            qiime tools extract \
                --input-path "ancombc_${tax_level}_${sample}_vs_${baseline_ref}.qza" \
                --output-path "ancombc_${tax_level}_${sample}_vs_${baseline_ref}_output"
        done
    done
done

# ---------------------------
# Step 2: Track longitudinal changes within each genotype
# Run ANCOMBC with formula: "genotype + time_point"
# ---------------------------
 for tax_level in "${taxonomic_levels[@]}"; do
     qiime composition ancombc \
         --i-table collapsed-table_"$tax_level".qza \
         --m-metadata-file jax_iu_pitt_metadata_v3.txt \
         --p-formula "genotype + time_point" \
         --o-differentials "ancombc_${tax_level}_longitudinal.qza" \
         --verbose
 done


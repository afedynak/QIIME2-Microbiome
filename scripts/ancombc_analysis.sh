# Reference levels array
reference_levels=(
	"C57BL6J"           # Wild-type control
	"5xFAD_carrier"     # Alzheimer's model carriers
	"5xFAD_noncarrier"  # Alzheimer's model non-carriers
	"APOE4_homozygous"  # APOE4 variant mice
	"TREM2R47H_homozygous"  # TREM2 variant mice
)

# Define taxonomic levels in a variable
taxonomic_levels=("phylum" "family" "genus" "species" "class" "order")

# Loop over each reference level and each taxonomic level
for ref_level in "${reference_levels[@]}"; do
    for taxonomic_level in "${taxonomic_levels[@]}"; do
        # Run ANCOMBC for each reference level and taxonomic level
        qiime composition ancombc \
            --i-table collapsed-table_"$taxonomic_level".qza \
            --m-metadata-file jax_iu_pitt_metadata_v3.txt \
            --p-formula "genotype" \
            --p-reference-levels "genotype::$ref_level" \
            --o-differentials "ancombc_${taxonomic_level}_$ref_level.qza" \
            --verbose

        # Create a barplot for the results
        qiime composition da-barplot \
            --i-data "ancombc_${taxonomic_level}_$ref_level.qza" \
            --o-visualization "ancombc_${taxonomic_level}_$ref_level.qzv"

        # Create a barplot with significance threshold
        qiime composition da-barplot \
            --i-data "ancombc_${taxonomic_level}_$ref_level.qza" \
            --p-level-delimiter ";" \
            --p-significance-threshold 0.05 \
            --o-visualization "ancombc_${taxonomic_level}_sig_$ref_level.qzv"

        # Extract the results
        qiime tools extract \
            --input-path "ancombc_${taxonomic_level}_$ref_level.qza" \
            --output-path "ancombc_${taxonomic_level}_${ref_level}_output"

    done
done


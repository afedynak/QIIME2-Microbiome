declare -a metrics=("shannon" "chao1" "pielou_e" "simpson")

for metric in "${metrics[@]}"; do

  # Compute alpha diversity
  qiime diversity alpha \
    --i-table feature-table.qza \
    --p-metric $metric \
    --o-alpha-diversity ${metric}.qza

  # Tabulate raw alpha values
  qiime metadata tabulate \
    --m-input-file ${metric}.qza \
    --o-visualization ${metric}_table.qzv

  # Merge alpha diversity with metadata
  qiime metadata tabulate \
    --m-input-file ${metric}.qza \
    --m-input-file jax_iu_pitt_metadata_v3.txt \
    --o-visualization merged_${metric}_metadata.qzv

  # Export raw alpha diversity file
  qiime tools export \
    --input-path ${metric}.qza \
    --output-path exported_${metric}

done


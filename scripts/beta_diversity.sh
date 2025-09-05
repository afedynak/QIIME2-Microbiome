qiime diversity beta \
  --i-table ../feature-table.qza \
  --p-metric braycurtis \
  --verbose \
  --output-dir export_braycurtis \

qiime diversity pcoa \
  --i-distance-matrix export_braycurtis/distance_matrix.qza \
  --output-dir export_braycurtis_pcoa \

qiime emperor plot \
  --i-pcoa export_braycurtis_pcoa/pcoa.qza \
  --m-metadata-file jax_iu_pitt_metadata_v3.txt \
  --o-visualization export_braycurtis_pcoa/pcoa_emperor.qzv

qiime diversity beta-group-significance \
  --i-distance-matrix export_braycurtis/distance_matrix.qza \
  --m-metadata-file jax_iu_pitt_metadata_v3.txt \
  --p-method permanova \
  --p-permutations 999 \
  --m-metadata-column genotype \
  --o-visualization bray_curtis_permanova_genotype.qzv

qiime diversity beta-group-significance \
  --i-distance-matrix export_braycurtis/distance_matrix.qza \
  --m-metadata-file jax_iu_pitt_metadata_v3.txt \
  --p-method permanova \
  --p-permutations 999 \
  --m-metadata-column genotype_stage \
  --o-visualization bray_curtis_permanova_genotype_stage.qzv


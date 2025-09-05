qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path pe-manifest \
  --output-path paired-end-demux.qza \
  --input-format PairedEndFastqManifestPhred33V2

qiime demux summarize \
  --i-data paired-end-demux.qza \
  --o-visualization paired-end-demux.qzv

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs paired-end-demux.qza \
  --p-trunc-len-f 270 \
  --p-trunc-len-r 270 \
  --p-trunc-q 2 \
  --p-max-ee-f 3 \
  --p-max-ee-r 3 \
  --p-min-overlap 8 \
  --p-chimera-method none \
  --p-n-threads 10 \
  --o-table feature-table.qza \
  --o-representative-sequences rep-seqs.qza \
  --o-denoising-stats denoising-stats.qza \
  --verbose

qiime metadata tabulate \
  --m-input-file denoising-stats.qza \
  --o-visualization denoising-stats-summ.qzv

qiime feature-classifier classify-sklearn \
  --i-classifier silva-138-99-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --p-confidence 0.5 \
  --o-classification taxonomy_silva.qza

qiime metadata tabulate \
  --m-input-file taxonomy_silva.qza \
  --o-visualization taxonomy_silva.qzv  

qiime taxa barplot \
  --i-table feature-table.qza \
  --i-taxonomy taxonomy_silva.qza \
  --o-visualization barplot_silva.qzv


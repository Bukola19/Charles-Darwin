# setup.sh

#to download anaconda via commandline
wget https://repo.continuum.io/archive/Anaconda3-2024.02-1-Linux-x86_64.sh

#to activate conda environment
conda create --name joy_stage2

#to activate conda environment
conda activate joy_stage2

#to install fastqc for quality control
conda install bioconda::fastqc

#to install multiqc for creating summmary of qc reports from multiple samples
conda install -c bioconda multiqc

#to install fastp for trimming reads
conda install bioconda/label/cf201901::fastp

#to install bwa for read mapping
conda install bioconda::bwa

#to install samtools for 
conda install bioconda/label/cf201901::samtools

#to install freebayes for finding snps,indel etc
 conda install bioconda/label/cf201901::freebayes

#to install bcftools for manipulating variant calling iwth vcf and bcf
 conda install bioconda/label/cf201901::bcftools












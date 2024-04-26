setup.sh
#download and install anaconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# to create a working environment
conda create -n variant-calling
# to activate the environment
conda activate variant-calling
# to install fastqc for quality control
conda install fastqc
# to install multiqc for quality control( to aggregate fastqc result)
conda install multiqc
# to install bwa for genome mapping
conda install bwa
# to install samtools (to check the mapping statistics)
conda install samtools
# to install bcftools for manipulation of vcf.gz file
conda install bcftools

# Abner setup.sh

# Install required tools

# Activate environment
conda activate funtools

# Install FastQC
sudo apt-get install fastqc

# Install FastP
sudo apt-get install fastp

# Install BWA
sudo apt-get install fastp

# Install Samtools
sudo apt-get install samtools

# Install BCFtools
sudo apt-get install bcftools

#If there is a problem with libopenblas
sudo apt-get install libopenblas-base
#If the result is: E: Unable to locate package libopenblas-base 
# so run the next command and then install libopenblas-base again:
sudo apt-get update



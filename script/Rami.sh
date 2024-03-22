mkdir Rami
mkdir biocomputing ; cd biocomputing
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
mv wildtype.fna ../Rami
rm wildtype.gbk.1
egrep tatatata ../Rami/wildtype.fna
egrep tatatata ../Rami/wildtype.fna > mutant_seq.txt
echo "CNTN1 gene"
efetch -db nucleotide -id NC_000012.12 -format fasta > CNTN1_GeneSeq.fasta
tail -n +2 CNTN1_GeneSeq.fasta | wc -l
A_count=$(egrep -c "A" CNTN1_GeneSeq.fasta) ; echo $A_count
G_count=$(egrep -c "G" CNTN1_GeneSeq.fasta) ; echo $G_count
C_count=$(egrep -c "C" CNTN1_GeneSeq.fasta) ; echo $C_count
T_count=$(egrep -c "T" CNTN1_GeneSeq.fasta) ; echo $T_count
sudo apt update
sudo apt install bc
variable1=$((C_count+G_Count)) ; total=$((A_count+T_count+variable1)) ; div=$(echo "scale=2; $variable1 / $total" | bc) ; answer=$(echo "scale=2; $div * 100" | bc) ; echo $answer
touch Rami_CNTN_nucleotide.fasta
echo -e "C_count:$C_count\nT_count:$T_count\nA_count:$A_count\nG_count:$G_count" >> Rami_CNTN_nucleotide.fasta
git clone https://github.com/Bukola19/Charles-Darwin
mv Rami_CNTN_nucleotide.fasta Charles-Darwin/output
cd Charles_Darwin/output
git add Rami_CNTN_nucleotide.fasta
git commit -m Rami_CNTN_nucleotide.fasta
git push origin main
touch Rami.sh
#add the commands manually to Rami.sh
git add Rami.sh
git commit -m Rami.sh
git push origin main

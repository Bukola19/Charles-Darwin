mkdir abner
mkdir biocomputing && cd biocomputing
wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
mv *.fna ~/prueba/abner
rm wildtype.gbk.1
grep -o 'tatatata' wildtype.fna | wc -l
grep "tatatata" wildtype.fna > mutant_lines.txt
echo “p53”
esearch -db nucleotide -query "XM_063696027.1" | efetch -format fasta > p53.fasta
grep -c -v "^>" p53.fasta
tail -n +2 p53.fasta | grep -o -i "A" | wc -l
tail -n +2 p53.fasta | grep -o -i "G" | wc -l
tail -n +2 p53.fasta | grep -o -i "C" | wc -l
tail -n +2 p53.fasta | grep -o -i "T" | wc -l
n_gc=$(grep -o "[GC]" p53.fasta | wc -l)
total_length=$(grep -v "^>" p53.fasta | tr -d "\n" | wc -c)
gc_content=$(echo "scale=2; ($n_gc / $total_length) * 100" | bc)
echo "Percentage of GC is: $gc_content%"
touch Abner.fasta
nano Abner.fasta
echo "Number of A: $(grep -o 'A' Abner.fasta | wc -l)" >> Abner.fasta
echo "Number of A: $(grep -o 'A' Abner.fasta | wc -l)" >> Abner.fasta
echo "Number of G: $(grep -o 'G' Abner.fasta | wc -l)" >> Abner.fasta
echo "Number of T: $(grep -o 'T' Abner.fasta | wc -l)" >> Abner.fasta
echo "Number of C: $(grep -o 'C' Abner.fasta | wc -l)" >> Abner.fasta
history > Abner.sh

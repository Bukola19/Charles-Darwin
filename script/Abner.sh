#Question 2
echo mkdir abner

#Question 3
$ mkdir biocomputing && cd biocomputing

#Question 4
$ wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk

#Question 5
$ mv wildtype.fna ~/abner
#Question 6
$ rm wildtype.gbk
#Question 7
$ grep -o 'tatatata' wildtype.fna | wc -l
#Question 8
$ grep "tatatata" wildtype.fna > mutant_lines.txt

#Question 9
$ echo “p53”
#Question 10
$ esearch -db nucleotide -query "XM_063696027.1" | efetch -format fasta > p53.fasta
#Question 11
$ grep -c -v "^>" p53.fasta
#Question 12
$ tail -n +2 p53.fasta | grep -o -i "A" | wc -l
#Question 13
$ tail -n +2 p53.fasta | grep -o -i "G" | wc -l
#Question 14
$ tail -n +2 p53.fasta | grep -o -i "C" | wc -l
#Question 15
$ tail -n +2 p53.fasta | grep -o -i "T" | wc -l
#Question 16
$ n_gc=$(grep -o "[GC]" p53.fasta | wc -l)
$ total_length=$(grep -v "^>" p53.fasta | tr -d "\n" | wc -c)
$ gc_content=$(echo "scale=2; ($n_gc / $total_length) * 100" | bc)
$ echo "Percentage of GC is: $gc_content%"
#Question 17
$ nano Abner.fasta
#Question 18
$ echo "Number of A: $(grep -o 'A' Abner.fasta | wc -l)" >> Abner.fasta
$ echo "Number of G: $(grep -o 'G' Abner.fasta | wc -l)" >> Abner.fasta
$ echo "Number of T: $(grep -o 'T' Abner.fasta | wc -l)" >> Abner.fasta
$ echo "Number of C: $(grep -o 'C' Abner.fasta | wc -l)" >> Abner.fasta


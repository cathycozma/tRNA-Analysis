#!/bin/bash

# Dec 19 2018
# Daniel Giguere

#blast trnas against each database
#set directory to top of project file
# usage: nohup ./blast.sh &

for sample in all_blast_dbs/*.nhr; do

#get sample name
DB=`basename $sample | cut -d "." -f1`

#test
#echo $NAME

# max target seqs set to 10 000 to ensure all reads are identified
blastn -query all20_tRNAquery.fasta -db all_blast_dbs/$DB -perc_identity 95 -outfmt "7 std btop sseq qlen" -max_target_seqs 10000 -num_threads 40 > blast_output/$DB.blast

perl ./bin/BLAST_analysis.pl blast_output/$DB.blast $DB

done

# move to output folder
mv BLAST_analysis_*.txt blast_analysis_output/
mv tRNA_sequence_*.fasta blast_analysis_output/
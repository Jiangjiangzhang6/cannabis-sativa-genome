#!/bin/bash
if [ $# -eq 0 ] || [ $# -eq 1 ];
then echo "usage:
bash LTR_find.sh spcies genome.fa"
exit 1 
fi
species=$1
genome=$2
gt=/public/home/zhangjiangjiang/gt/bin/gt
$gt suffixerator -db ${genome} -indexname ${species} -tis -suf -lcp -ssp -sds -dna -des
$gt ltrharvest -index ${species} -similar 85 -vic 10 -seed 20 -seqids yes -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 \
 -motif TGCA -motifmis 1 > ${species}.harvest.scn

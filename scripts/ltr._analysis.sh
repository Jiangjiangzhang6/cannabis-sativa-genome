#!/usr/bin/bash

LTR_FINDER_parallel=/public/home/zhangjiangjiang/software/LTR_FINDER_parallel-1.1/LTR_FINDER_parallel

genome=hap1.fa

perl $LTR_FINDER_parallel -seq $genome  -harvest_out -threads 10 

bash LTR_find.sh hemp $genome  ###Ltr_harvest software to identify the scn

~/software/LTR_retriever-master/LTR_retriever  -genome $genome -inharvest hemp.harvest.scn -infinder ${genome}.finder.combine.scn  -threads 60 ##ltr_retriever merge the scn to identify the LTR 
###extract the intact LTR
awk '$3~"LTR_retrotransposon"' hap1.fa.mod.pass.list.gff3 | grep "Method=structural" >intact.LTR.GFF3

awk -F';' '{print $1}' intact.LTR.GFF3 |sed 's/ID=//' | awk '$7!="?"' | awk '{print $1"\t"$4-1"\t"$5"\t"$9"\t.\t"$7}' > intact.LTR.bed6

awk -F';' '{print $1}' intact.LTR.GFF3 |sed 's/ID=//' | awk '$7=="?"' | awk '{print $1"\t"$4-1"\t"$5"\t"$9"\t.\t+"}' >> intact.LTR.bed6

bedtools getfasta -fi finola.fa -bed intact.LTR.bed6  -fo - -name -s | awk -F'::' '{print  }' |fold -w 60  >intact.LTR.fa
### annotation the intact LTR_RT
TEsorter intact.LTR.fa

cat  intact.LTR.fa.rexdb.dom.tsv |grep -P "\-RT\t" | cut -f 1 | seqtk subseq intact.LTR.fa.rexdb.dom.faa  - >RT.raw.fa

awk -F':' '{print $1}' RT.raw.fa |sed 's/\Class_I\/LTR//' | sed 's/>/>Aly-/' > RT.fa

mafft --auto RT.fa >RT.aln
###construction the phylogenetic tree
iqtree --runs 5 -fast  -s RT.aln  -nt  AUTO  -pre Ty1.iqtree1

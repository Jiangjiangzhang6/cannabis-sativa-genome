#!/usr/bin/bash
LTR_FINDER_parallel=/public/home/zhangjiangjiang/software/LTR_FINDER_parallel-1.1/LTR_FINDER_parallel
genome=hap1.fa
perl $LTR_FINDER_parallel -seq $genome  -harvest_out -threads 10 
bash LTR_find.sh hemp $genome  ###Ltr_harvest software to identify the scn
~/software/LTR_retriever-master/LTR_retriever  -genome $genome -inharvest hemp.harvest.scn -infinder ${genome}.finder.combine.scn  -threads 60 ##ltr_retriever merge the scn to identify the LTR 

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



##统计ltr完整个数个全部的个数
##完整的全部个数
awk '$3 ~ /LTR_retrotransposon/ {print $3}' hap1.fa.mod.pass.list.gff3|sort |wc -l 
##完整的分类的个数
awk '$3 ~ /LTR_retrotransposon/ {print $3}' hap1.fa.mod.pass.list.gff3|sort |uniq -c 
##全部的个数
grep -v  "#" hap1.fa.mod.out.gff3  |cut -f 3| sort |wc -l 
##全部的分类个数
grep -v  "#" hap1.fa.mod.out.gff3  |cut -f 3| sort |uniq -c 
grep ">" hap1.fa|head -11 > id.list
perl duiying.pl id.list finola.fa.mod.out.LAI | sed  "s/^/finola_/"  | awk -vOFS="\t" '{print $1,$2,$3,$NF,NR}' > hap1.lai.reslut
#统计总长
#copia_raw
awk '$3 == "Copia_LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.out.gff3
#gypsy_raw
awk '$3 == "Gypsy_LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.out.gff3
#unknown_raw
awk '$3 == "LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.out.gff3
#all
awk '{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.out.gff3
##intact
#copia_intact
awk '$3 == "Copia_LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' fhap1.fa.mod.pass.list.gff3 
#gypsy_intact
awk '$3 == "Gypsy_LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.pass.list.gff3
#all_unknown
awk '$3 == "LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.pass.list.gff3
#all_intact
awk '$3 ~ "LTR_retrotransposon"{sum += (($5-$4) < 0) ? -($5-$4) : ($5-$4)} END {print sum}' hap1.fa.mod.pass.list.gff3
sed -e "s/^ \+//" -e "s/ \+/\t/g" hap1.fa.mod.out |awk -v OFS="\t" 'NR>3{print "hap1",substr($11,5),$2,"finola_"substr($11,5)}' > div.hap1.result
sed -e "s/^ \+//" -e "s/ \+/\t/g" hap1.fa.mod.out |awk -v OFS="\t" 'NR>3{print "hap1",substr($11,5),$2,"finola_all"}' >> div.finola.result


###统计数目
less -S intact.LTR.fa.rexdb.dom.tsv | grep -P "\-RT\t"  | cut -f 1| awk -F"/" '{print $NF}'|cut -f 1 -d ":" |sort |uniq -c |sed "s/^ \+//" |sed "s/ /\t/"| sort -nr | awk '{print $2"\tnum\t"$1}' >intact_statistic.ltr.list

#统计id 和分类
cut -f 1 -d ":" intact.LTR.fa.rexdb.dom.gff3 |awk -F"/" '{print $0"\t"$NF}'|awk '{print $1"\t"$NF}'|sort  -u > intact.list
##统计id和pos
awk '$3 ~ "LTR_retrotransposon"'  finola.fa.mod.pass.list.gff3 >intact.gff3
cut -f4,5,9  intact.gff3|cut -f 1 -d ";" |sed "s/ID=//" |awk -v OFS="\t" '{print $3,$1,$2}' >intact.ltr.pos.list
###统计总长度
perl  duiying.pl  | awk '{diff[$4] += ($3 > $2 ? $3 - $2 : $2 - $3)} END {for (key in diff) print key"\ttotal_length_total\t"diff[key]}' - >> intact_statistic.ltr.list
###统计平均值
perl  duiying.pl  | awk '{diff[$4] += ($3 > $2 ? $3 - $2 : $2 - $3);count[$4]++;} END {for (key in diff) print key"\tavergae\t"diff[key]/count[$4]}' - >> intact_statistic.ltr.list
##改变第一列
sed -i 's/^\([^[:space:]]*\)/\1_finola/' intact_statistic.ltr.list 
mv intact_statistic.ltr.list finola_intact_statistic.ltr.list

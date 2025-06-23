#!/usr/bin/bash 
#SBATCH -p big,low,amd,smp01,smp02
#SBATCH -n 10
#SBATCH -N 1


### the raw repeat annotaion
BuildDatabase  -name "hap1" hap1.fa
RepeatModeler -database hap1 -engine rmblast -threads 10 -LTRStruct
RepeatModeler -database hap1 -engine rmblast -threads 10 -recoverDir RM_* -LTRStruct
cp RM_*/consensi.fa.classified ./
source activate EDTA2
RepeatMasker -pa 10 -e ncbi -lib consensi.fa.classified hap1.fa  -gff -xsmall
### the fine repeat annotaion
mkdir 01.deepte.anno; cd 01.deepte.anno
perl extract_catergoy.pl ### extract the unknown and annotation element from the library
###annotation the unknown element
python /public/home/zhangjiangjiang/software/DeepTE-master/DeepTE.py \
    -d working_dir \
    -i un.fa \
    -m_dir ~/jjzhang/yan/genome/hemp/03.changsha_genome/01.hap1/04.repeatmasker/03.anno_further1_deepte/Plants_model -sp P
perl 2.pl | perl 4.pl - > opt_DeepTE.fasta2 ### handle the deepte annotation
cat opt_DeepTE.fasta2 no_un.fa |seqkit seq -w 100 > deepte_an.fa ### merge the unknown element annotation by deepte and the raw annotaion file library
RepeatMasker -pa 20 -e ncbi -lib deepte_an.fa fa1  -gff -xsmall ### genome repeat annotation again. and the comparable the two results

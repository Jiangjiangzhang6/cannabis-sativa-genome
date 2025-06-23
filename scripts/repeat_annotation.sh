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
perl extract_catergoy.pl ###
perl 2.pl | perl 4.pl - > opt_DeepTE.fasta2

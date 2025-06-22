#!/bin/bash       
#SBATCH -p low,amd,big,smp01,smp02 
#SBATCH -J csb
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=3
#SBATCH -o %j.out
#SBATCH -e %j.err
# /public/home/zhaoli/software/anaconda3/envs/tgs/bin/tgsgapcloserbin/tgsseqsplit --input_scaff ragoo.fasta --prefix hap1.fasta_order
pwd=/public/home/zhangjiangjiang/jjzhang/yan/genome/hemp/changsha/01.hap1
juicer=/public/home/zhangjiangjiang/software/juicer-1.6/SLURM/scripts/juicer.sh
run_asm=/public/home/zhangjiangjiang/software/3d-dna-master/run-asm-pipeline.sh
fa=ragoo.hap1.contig
samtools faidx $fa
bwa index $fa
awk '{print $1 "\t" $2}' ${fa}.fai > ${fa}.len
generate_site_position=~/software/juicer-1.6/misc/generate_site_positions.py
python2 ${generate_site_position}  MboI  hemp $fa
$juicer -l low -g hemp -q big -s MboI   -d ${pwd} -p ${pwd}/${fa}.len -y ${pwd}/hemp_MboI.txt -z  ${pwd}/${fa} -D /public/home/zhangjiangjiang/software/juicer-1.6/SLURM/ -t 3

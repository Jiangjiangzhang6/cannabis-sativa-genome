##iso_seq annotaion
ccs ../m64033_211026_084454.subreads.bam ccs1.bam  --min-passes 1  --noPolish
ccs ../m64083_211123_111800.subreads.bam ccs2.bam  --min-passes 1 --noPolish
lima ccs1.bam barcode.fasta   ccs1_f1.bam --isoseq -j 20
lima ccs2.bam barcode.fasta   ccs2_f1.bam --isoseq -j 20
isoseq3 refine --require-polya --min-polya-length 20 -j 20 ccs1_f1.primer_5p--primer_3p.bam primer.fasta  ccs1_f1.bam --num-threads 5
isoseq3 refine --require-polya --min-polya-length 20 -j 20 ccs2_f1.primer_5p--primer_3p.bam primer.fasta  ccs2_f1.bam --num-threads 5
isoseq3 cluster ccs1_f1.primer_5p--primer_3p.bam  cluster_ccs1_f1.bam --verbose
isoseq3 cluster ccs2_f1.primer_5p--primer_3p.bam  cluster_ccs2_f1.bam --verboseq
isoseq3 polish -j 16 cluster_ccs1_f1.bam ../m64033_211026_084454.subreads.bam 1polished.bam
isoseq3 polish -j 16 cluster_ccs2_f1.bam ../m64083_211123_111800.subreads.bam 2polished.bam
cat cluster_ccs1_f1.hq.fasta cluster_ccs2_f1.hq.fasta  > hemp_iso_seq.fasta
##repeat annotation
BuildDatabase -engine rmblast  -name "repeat_hap1" ../hap1.last_w200.final.fasta
##构建library
RepeatModeler -database repeat_hap1 -engine rmblast -pa 5 -LTRStruct
RepeatModeler -database repeat_hap1 -engine rmblast -pa 1 -recoverDir RM_* -LTRStruct
cp RM_*/consensi.fa.classified ./
RepeatMasker -pa 5 -e ncbi -lib consensi.fa.classified -gff hap1
RepeatMasker -pa 5 -e ncbi -lib consensi.fa.classified ../../hap1.last_w200.final.fasta
##PASA annotaion 
PASApipeline-v2.3.3/scripts/pasa_asmbls_to_training_set.dbi \
    --pasa_transcripts_fasta <prefix>.assemblies.fasta.transdecoder.genome.gff3\
    --pasa_transcripts_gff3 <prefix>.pasa_assemblies.gff3
##RNA-annotaion
hap1=../../hap1.last.w200.final.fasta
thread=3
hisat2-build $ref hap1
for ii in $(ls -l ../../public-rnaseq/ | awk '{print $9}' | cut -d'_' -f1 | uniq |grep "SRR" ); do
hisat2 --max-intronlen 10000 -x hap1 -p 3 -1 ../../public-rnaseq/${ii}_1.fastq -2 ../../public-rnaseq/${ii}_1.fastq -S ${ii}.sam
samtools view -bSF4 ${ii}.sam | samtools sort --threads $thread -o ${ii}.sorted.bam
stringtie -o ${ii}.gtf ${ii}.sorted.bam -p 3
done
stringtie --merge  -o hap1_stringtie_merge.gtf hap1_string.gtf.list
perl /public/home/software/opt/bio/software/PASA/2.3.3-SQLite/misc_utilities/gtf_to_gff3_format.pl hap1_stringtie_merge.gtf ../../../index/hap1.last_w200.final.fasta > hap1_stringtie_merge.gff3
python3 /public/home/zhaoli/software/biocode-master/gff/report_gff_intron_and_intergenic_stats.py -i hap1_stringtie_merge.gff3 -f ../../../index/hap1.last_w200.final.fasta

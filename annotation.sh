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
###augustus annotaion
#gmes_petap.pl  --ET hints.gff --et_score 10 --cores 5 --sequence ../../../index/hap1.last_w200.final.fasta.preSunJul240646092022.RMoutput/hap1.last_w200.final.fasta.masked
#将gff3格式转化为genbank格式
gff2gbSmallDNA.pl ../hap1_candicates.gff3 ../../../../index/hap1.last_w200.final.fasta.preSunJul240646092022.RMoutput/hap1.last_w200.final.fasta.masked 1000 hap1.genes.raw.gb
##创立去除错误基因类型的物种类型
new_species.pl --species=for_hds_bad_genes_removing --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/
##生成log文件
etraining --species=for_hds_bad_genes_removing --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/  --stopCodonExcludedFromCDS=false hap1.genes.raw.gb 2>train.err
##把错类类型的基因提取
cat train.err |perl -pe 's/.in sequence (\S+):./$1/'>badgenes.lst
##把错误类型的基因进行过滤
filterGenes.pl badgenes.lst hap1.genes.raw.gb > hap1.genes.gb
##将过滤后的基因分成训练集和测试机，即training 和testing两部分
randomSplit.pl hap1.genes.gb 300
###创立初始化的HMM参数文件
new_species.pl --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/
##尝试第一次训练
etraining --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/ hap1.genes.gb.train >train.out
##进行精确检验
augustus --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/  hap1.genes.gb.test |tee firsttest.out
##使用optimize_augustus.pl进行循环training寻找最优参数
optimize_augustus.pl --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/ --cpus=8 --rounds=5 hap1.genes.gb.train
##尝试第二次训练
etraining --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/ hap1.genes.gb.train
##第二次进行精确检验
augustus --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/  hap1.genes.gb.test|tee secondtest.out
##进行CRF training，首先对原来的species进行备份
cp /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_intron_probs.pbl /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_intron_probs.pbl.withoutCRF
cp /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_exon_probs.pbl /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_exon_probs.pbl.withoutCRF
cp /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_ingenic_probs.pbl /public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/species/hap1/hap1_ingenic_probs.pbl.withoutCRF
##进行CRF检验，和训练
etraining --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/ --CRF=1 hap1.genes.gb.train
augustus  --species=hap1 --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/annotation/hap1/rna-seq/augustus/augustus_config/config/ hap1.genes.gb.test |tee secondtest.out.withCRF
##利用bam文件得到hints文件
bam2hints --in=../out.bam --out=hints.intron.gff --maxgenelen=50000 --intronsonly
##比较CRF和 secondtest.out的结果，选择一个结果进行最终Augustus预测
augustus --species=xxxx --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/index/RNA/hap1/try_augustus/augustus_config/config --extrinsicCfgFile=/public/home/zhaoli/dama/index/RNA/hap1/try_augustus/augustus_config/config/extrinsic/extrinsic.E.cfg --hintsfile=hints.intron.gff --alternatives-from-evidence=true --allow_hinted_splicesites=atac --gff3=on ../../../hap1.last_w200.final.fasta.preSunJul240646092022.RMoutput/hap1.last_w200.final.fasta.masked >hap1-augustus.gff3
##可以提取aa长度大于100氨基酸的序列进行后续分析，也可不进行此步分析
scripts/pasa_asmbls_to_training_set.extract_reference_orfs.pl PASA/out/training/pasa.step1.gff3 100>best_candicates.gff3
##最终得到最后的gff3
###geneMark annotation
gmes_petap.pl  --ET hints.gff --et_score 10 --cores 5 --sequence ../../../index/hap1.last_w200.final.fasta.preSunJul240646092022.RMoutput/hap1.last_w200.final.fasta.masked
###barker annotaion
braker.pl --cores 10 --gff3 --species=TRY --AUGUSTUS_CONFIG_PATH=/public/home/zhaoli/dama/index/RNA/hap1/try_augustus/augustus_config/config --genome=../../../../index/hap1.last_w200.final.fasta.preSunJul240646092022.RMoutput/hap1.last_w200.final.fasta.masked --hints=../hints.gff --GENEMARK_PATH=/public/home/zhaoli/software/gmes_linux_64_4/
###miniprot and gth protein annotation








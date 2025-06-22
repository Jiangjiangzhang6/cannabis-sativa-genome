hifiasm -o dama.asm -t32 -l0 ~/dama/canu/ccs.fq.gz 2> dama.asm.loga
## The awk script '$1 == "S" {print ">"$2"\n"$3}' input.gfa > output.contig is used to convert hap1 and hap2 from GFA to contig.
ragoo.py  ./hap1.fa ./cs10.fa  ### cs10 is the genome of CBDAX
perl -w ragoo.pl  ragoo.fasta | seqkit seq -w 100  >  hap1.raoo.contig.fa 
bash hic.sh ##Run Juicer to generate the Hi-C map
##Adjust Hi-C signal heatmap using JuicerBox to generate hap1.raoo.contig.1.review.assembly.
script=/public/home/zhangjiangjiang/software/3d-dna-master/run-asm-pipeline-post-review.sh
bash $script -r  hap1.raoo.contig.1.review.assembly  ../hap1.raoo.contig.fa ../aligned/merged_nodups.txt
###Generate graph data from CLR data.
canu  -correct gridOptions="19.05.7" -p s7_canu_clr -d canu_clr_correct useGrid=true gridOptions=--partition="smp01" genomeSize=840M  -pacbio  clr.fq.gz
canu  -trim  gridOptions="19.05.7" -p s7_canu_clr1 -d canu_clr_trim useGrid=true gridOptions=--partition="smp01" genomeSize=840M  -pacbio ./canu_clr_correct/clr.correctedReads.fasta.gz
flye --pacbio-raw ./canu_clr_trim/clr_canu_clr1.trimedReads.fasta.gz -o ../01.flye/out_pacbio --threads 40

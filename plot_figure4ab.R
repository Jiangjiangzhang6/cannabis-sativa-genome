#!/usr/bin/R
###figure 4a
a<- read.table("lai_all1.txt",header = T,sep = "\t")
#a$id2 <- factor(a$id2,levels = c("hap1_gypsy","hap1_copia","hap1_unknown","hap1_all","hap2_gypsy","hap2_copia","hap2_unknown","hap2_all","fj_hemp_gypsy","fj_hemp_copia","fj_hemp_unknown","fj_hemp_all","cs10_gypsy","cs10_copia","cs10_unknown","cs10_all","jl_wild_gypsy","jl_wild_copia","jl_wild_unknown","jl_wild_all"))
a$yb <- factor(a$yb,levels = c("intact","all"))
#a$id2 <- factor(a$id2,levels = c("hap1_gypsy","hap1_copia","hap1_unknown","hap1_all","hap2_gypsy","hap2_copia","hap2_unknown","hap2_all","fj_hemp_gypsy","fj_hemp_copia","fj_hemp_unknown","fj_hemp_all","cs10_gypsy","cs10_copia","cs10_unknown","cs10_all","jl_wild_gypsy","jl_wild_copia","jl_wild_unknown","jl_wild_all","pk_gypsy","pk_copia","pk_unknown","pk_all","finola_gypsy","finola_copia","finola_unknown","finola_all","cannbio_gypsy","cannbio_copia","cannbio_unknown","cannbio_all"))
a$id2 <- factor(a$id2,levels = c("pk_gypsy","pk_copia","pk_unknown","pk_all","finola_gypsy","finola_copia","finola_unknown","finola_all","cannbio_gypsy","cannbio_copia","cannbio_unknown","cannbio_all","cs10_gypsy","cs10_copia","cs10_unknown","cs10_all","jl_wild_gypsy","jl_wild_copia","jl_wild_unknown","jl_wild_all","fj_hemp_gypsy","fj_hemp_copia","fj_hemp_unknown","fj_hemp_all","hap2_gypsy","hap2_copia","hap2_unknown","hap2_all","hap1_gypsy","hap1_copia","hap1_unknown","hap1_all"))
 
  
#  "hap1_gypsy","hap1_copia","hap1_unknown","hap1_all","hap2_gypsy","hap2_copia","hap2_unknown","hap2_all","fj_hemp_gypsy","fj_hemp_copia","fj_hemp_unknown","fj_hemp_all","cs10_gypsy","cs10_copia","cs10_unknown","cs10_all","jl_wild_gypsy","jl_wild_copia","jl_wild_unknown","jl_wild_all","pk_gypsy","pk_copia","pk_unknown","pk_all","finola_gypsy","finola_copia","finola_unknown","finola_all","cannbio_gypsy","cannbio_copia","cannbio_unknown","cannbio_all"))


p1 <- ggplot(a,aes(x=id2,y=num2/1000000,fill=yb)) + geom_bar(stat = 'identity',width = 0.85,colour='black') + theme_bw() + theme( axis.text.x=element_text(angle=45,hjust = 1)) + scale_fill_brewer(palette = "Set1")+geom_text(aes(label = a$num1/1000000)) +coord_flip()
p1
#ggsave("lai_ltr_rt_length1.pdf",p1,width = 20,height = 20,units = "cm")

###figure 4b
library(ggplot2)
a <- read.table("hemp_intact_num.txt",header = T,sep = "\t")
a1 <- subset(a,a$yb == "intact")
a1$id2 <- factor(a1$id2,levels = c("cannbio_gypsy","cannbio_copia","cannbio_unknown","cannbio_all","finola_gypsy","finola_copia","finola_unknown","finola_all","pk_gypsy","pk_copia","pk_unknown","pk_all","jl_gypsy","jl_copia","jl_unknown","jl_all","cs_gypsy","cs_copia","cs_unknown","cs_all","fj_gypsy","fj_copia","fj_unknown","fj_all","hap2_gypsy","hap2_copia","hap2_unknown","hap2_all","hap1_gypsy","hap1_copia","hap1_unknown","hap1_all"))
x <- ggplot(a1,aes(x=id2,y=num,fill=s)) + geom_bar(stat = 'identity',width = 0.85,colour='black', size = 0.1) +geom_text(aes(label = num))+theme_bw() + scale_fill_brewer(palette = "Set3") + coord_flip() + labs(y= "The number of intact LTR_RT",x="") +theme(legend.position = "none") #+theme(axis.title = element_blank())
x
#ggsave("second.intact.number.cannbis1.pdf",x,width = 16,height = 16,units = "cm")

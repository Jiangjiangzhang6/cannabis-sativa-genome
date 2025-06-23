#!/usr/bin/R
library(ggplot2)
library(tidyverse)
b<-read.table("cannabis.intact_length.result",header = F,sep = "\t")
names(b) <- c("id","num","total_length","avergae","type")
pivot_longer(b,c(2,3,4)) ->a
names(a) <- c("id","type","cat","value")
a1 <- subset(a,cat == "num")
a2 <- subset(a,cat == "total_length")
a3 <- subset(a,cat == "avergae")
#a1$id <- factor(a1$id,levels = c("Tekay.list1","Tekay.list2","Retand.list1","Retand.list2","Ale.list1","Ale.list2","Angela.list1","Angela.list2","SIRE.list1","SIRE.list2","Ikeros.list1","Ikeros.list2","Tork.list1","Tork.list2","Athila.list1","Athila.list2","Reina.list1","Reina.list2","Bianca.list1","Bianca.list2","Galadriel.list1","Galadriel.list2","TAR.list1","TAR.list2","CRM.list1","CRM.list2","Ivana.list1","Ivana.list2","Ogre.list1","Ogre.list2","Alesia.list1","Alesia.list2"))
library(scales)
##构建函数
squash_axis <- function(from, to, factor) { 
    # Args:
    #   from: left end of the axis
    #   to: right end of the axis
    #   factor: the compression factor of the range [from, to]
    
    trans <- function(x) {    
        # get indices for the relevant regions
        isq <- x > from & x < to
        ito <- x >= to
        
        # apply transformation
        x[isq] <- from + (x[isq] - from)/factor
        x[ito] <- from + (to - from)/factor + (x[ito] - to)
        
        return(x)
    }
    
    inv <- function(x) {
        # get indices for the relevant regions
        isq <- x > from & x < from + (to - from)/factor
        ito <- x >= from + (to - from)/factor
        
        # apply transformation
        x[isq] <- from + (x[isq] - from) * factor
        x[ito] <- to + (x[ito] - (from + (to - from)/factor))
        
        return(x)
    }
    
    # return the transformation
    return(trans_new("squash_axis", trans, inv))
}

a1$id <- factor(a1$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay_cannbio","Tekay_finola","Tekay_pk","Tekay.listcs",
"Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand_cannbio","Retand_finola","Retand_pk","Retand.listcs",
"Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale_cannbio","Ale_finola","Ale_pk","Ale.listcs",
"Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela_cannbio","Angela_finola","Angela_pk","Angela.listcs",
"SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE_cannbio","SIRE_finola","SIRE_pk","SIRE.listcs",
"Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros_cannbio","Ikeros_finola","Ikeros_pk","Ikeros.listcs",
"Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio",
"Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila_cannbio","Athila_finola","Athila_pk","Athila.listcs",
"Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina_cannbio","Reina_finola","Reina_pk","Reina.listcs",
"Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca_cannbio","Bianca_finola","Bianca_pk","Bianca.listcs",
"Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel_cannbio","Galadriel_finola","Galadriel_pk","Galadriel.listcs",
"TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR_cannbio","TAR_finola","TAR_pk","TAR.listcs",
"CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM_cannbio","CRM_finola","CRM_pk","CRM.listcs",
"Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana_cannbio","Ivana_finola","Ivana_pk","Ivana.listcs",
"Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre_cannbio","Ogre_finola","Ogre_pk","Ogre.listcs",
"Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia_cannbio","Alesia_finola","Alesia_pk","Alesia.listcs"))
#a1$id <- factor(a1$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay.listcs","Tekay_pk","Tekay_finola","Tekay_cannbio","Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand.listcs","Retand_pk","Retand_finola","Retand_cannbio","Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale.listcs","Ale_pk","Ale_finola","Ale_cannbio","Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela.listcs","Angela_pk","Angela_finola","Angela_cannbio","SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE.listcs","SIRE_pk","SIRE_finola","SIRE_cannbio","Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros.listcs","Ikeros_pk","Ikeros_finola","Ikeros_cannbio","Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio","Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila.listcs","Athila_pk","Athila_finola","Athila_cannbio","Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina.listcs","Reina_pk","Reina_finola","Reina_cannbio","Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca.listcs","Bianca_pk","Bianca_finola","Bianca_cannbio","Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel.listcs","Galadriel_pk","Galadriel_finola","Galadriel_cannbio","TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR.listcs","TAR_pk","TAR_finola","TAR_cannbio","CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM.listcs","CRM_pk","CRM_finola","CRM_cannbio","Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana.listcs","Ivana_pk","Ivana_finola","Ivana_cannbio","Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre.listcs","Ogre_pk","Ogre_finola","Ogre_cannbio","Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia.listcs","Alesia_pk","Alesia_finola","Alesia_cannbio"))


p1 <- ggplot(a1,aes(id,value,fill=id)) +geom_bar(stat = "identity",color="black",position = position_dodge())+ scale_fill_manual(values = c("#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC" ,"#FDDAEC","#FDDAEC","#FDDAEC" ,"red","red","red"))+ theme_bw() + theme( axis.text.x=element_blank(),legend.position =  "none")  +xlab(NULL)+ylab("Intact LTR_RT number") +  coord_trans(y = squash_axis(800, 3200, 10)) +scale_y_continuous(breaks = c(0,250,800,1200,2000,300))



a2$id <- factor(a2$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay_cannbio","Tekay_finola","Tekay_pk","Tekay.listcs",
"Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand_cannbio","Retand_finola","Retand_pk","Retand.listcs",
"Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale_cannbio","Ale_finola","Ale_pk","Ale.listcs",
"Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela_cannbio","Angela_finola","Angela_pk","Angela.listcs",
"SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE_cannbio","SIRE_finola","SIRE_pk","SIRE.listcs",
"Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros_cannbio","Ikeros_finola","Ikeros_pk","Ikeros.listcs",
"Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio",
"Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila_cannbio","Athila_finola","Athila_pk","Athila.listcs",
"Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina_cannbio","Reina_finola","Reina_pk","Reina.listcs",
"Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca_cannbio","Bianca_finola","Bianca_pk","Bianca.listcs",
"Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel_cannbio","Galadriel_finola","Galadriel_pk","Galadriel.listcs",
"TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR_cannbio","TAR_finola","TAR_pk","TAR.listcs",
"CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM_cannbio","CRM_finola","CRM_pk","CRM.listcs",
"Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana_cannbio","Ivana_finola","Ivana_pk","Ivana.listcs",
"Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre_cannbio","Ogre_finola","Ogre_pk","Ogre.listcs",
"Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia_cannbio","Alesia_finola","Alesia_pk","Alesia.listcs"))
#a2$id <- factor(a2$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay.listcs","Tekay_pk","Tekay_finola","Tekay_cannbio","Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand.listcs","Retand_pk","Retand_finola","Retand_cannbio","Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale.listcs","Ale_pk","Ale_finola","Ale_cannbio","Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela.listcs","Angela_pk","Angela_finola","Angela_cannbio","SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE.listcs","SIRE_pk","SIRE_finola","SIRE_cannbio","Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros.listcs","Ikeros_pk","Ikeros_finola","Ikeros_cannbio","Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio","Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila.listcs","Athila_pk","Athila_finola","Athila_cannbio","Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina.listcs","Reina_pk","Reina_finola","Reina_cannbio","Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca.listcs","Bianca_pk","Bianca_finola","Bianca_cannbio","Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel.listcs","Galadriel_pk","Galadriel_finola","Galadriel_cannbio","TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR.listcs","TAR_pk","TAR_finola","TAR_cannbio","CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM.listcs","CRM_pk","CRM_finola","CRM_cannbio","Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana.listcs","Ivana_pk","Ivana_finola","Ivana_cannbio","Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre.listcs","Ogre_pk","Ogre_finola","Ogre_cannbio","Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia.listcs","Alesia_pk","Alesia_finola","Alesia_cannbio"))

p2 <- ggplot(a2,aes(id,value/1000000,fill=id)) +geom_bar(stat = "identity",color="black",position = position_dodge())+ scale_fill_manual(values = c("#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC" ,"#FDDAEC","#FDDAEC","#FDDAEC" ,"red","red","red"))+ theme_bw() + theme( axis.text.x=element_blank(),legend.position =  "none")  +xlab(NULL)+ylab("Intact LTR_RT length(MB)") +  coord_trans(y = squash_axis(2, 30, 5)) +scale_y_continuous(breaks = c(0,2,10,20,30))

a3$id <- factor(a3$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay_cannbio","Tekay_finola","Tekay_pk","Tekay.listcs",
"Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand_cannbio","Retand_finola","Retand_pk","Retand.listcs",
"Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale_cannbio","Ale_finola","Ale_pk","Ale.listcs",
"Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela_cannbio","Angela_finola","Angela_pk","Angela.listcs",
"SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE_cannbio","SIRE_finola","SIRE_pk","SIRE.listcs",
"Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros_cannbio","Ikeros_finola","Ikeros_pk","Ikeros.listcs",
"Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio",
"Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila_cannbio","Athila_finola","Athila_pk","Athila.listcs",
"Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina_cannbio","Reina_finola","Reina_pk","Reina.listcs",
"Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca_cannbio","Bianca_finola","Bianca_pk","Bianca.listcs",
"Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel_cannbio","Galadriel_finola","Galadriel_pk","Galadriel.listcs",
"TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR_cannbio","TAR_finola","TAR_pk","TAR.listcs",
"CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM_cannbio","CRM_finola","CRM_pk","CRM.listcs",
"Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana_cannbio","Ivana_finola","Ivana_pk","Ivana.listcs",
"Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre_cannbio","Ogre_finola","Ogre_pk","Ogre.listcs",
"Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia_cannbio","Alesia_finola","Alesia_pk","Alesia.listcs"))
#a3$id <- factor(a3$id,levels = c("Tekay.list1","Tekay.list2","Tekay.listfj","Tekay.listjl","Tekay.listcs","Tekay_pk","Tekay_finola","Tekay_cannbio","Retand.list1","Retand.list2","Retand.listfj","Retand.listjl","Retand.listcs","Retand_pk","Retand_finola","Retand_cannbio","Ale.list1","Ale.list2","Ale.listfj","Ale.listjl","Ale.listcs","Ale_pk","Ale_finola","Ale_cannbio","Angela.list1","Angela.list2","Angela.listfj","Angela.listjl","Angela.listcs","Angela_pk","Angela_finola","Angela_cannbio","SIRE.list1","SIRE.list2","SIRE.listfj","SIRE.listjl","SIRE.listcs","SIRE_pk","SIRE_finola","SIRE_cannbio","Ikeros.list1","Ikeros.list2","Ikeros.listfj","Ikeros.listjl","Ikeros.listcs","Ikeros_pk","Ikeros_finola","Ikeros_cannbio","Tork.list1","Tork.list2","Tork.listfj","Tork.listjl","Tork.listcs","Tork_pk","Tork_finola","Tork_cannbio","Athila.list1","Athila.list2","Athila.listfj","Athila.listjl","Athila.listcs","Athila_pk","Athila_finola","Athila_cannbio","Reina.list1","Reina.list2","Reina.listfj","Reina.listjl","Reina.listcs","Reina_pk","Reina_finola","Reina_cannbio","Bianca.list1","Bianca.list2","Bianca.listfj","Bianca.listjl","Bianca.listcs","Bianca_pk","Bianca_finola","Bianca_cannbio","Galadriel.list1","Galadriel.list2","Galadriel.listfj","Galadriel.listjl","Galadriel.listcs","Galadriel_pk","Galadriel_finola","Galadriel_cannbio","TAR.list1","TAR.list2","TAR.listfj","TAR.listjl","TAR.listcs","TAR_pk","TAR_finola","TAR_cannbio","CRM.list1","CRM.list2","CRM.listfj","CRM.listjl","CRM.listcs","CRM_pk","CRM_finola","CRM_cannbio","Ivana.list1","Ivana.list2","Ivana.listfj","Ivana.listjl","Ivana.listcs","Ivana_pk","Ivana_finola","Ivana_cannbio","Ogre.list1","Ogre.list2","Ogre.listfj","Ogre.listjl","Ogre.listcs","Ogre_pk","Ogre_finola","Ogre_cannbio","Alesia.list1","Alesia.list2","Alesia.listfj","Alesia.listjl","Alesia.listcs","Alesia_pk","Alesia_finola","Alesia_cannbio"))

#p3 <- ggplot(a3,aes(id,value/1000,fill=id)) +geom_bar(stat = "identity",color="black",position = position_dodge())+ scale_fill_manual(values = c("#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC" ,"#FDDAEC","#FDDAEC","#FDDAEC" ,"red","red","red"))+ theme_bw() + theme( axis.text.x=element_text(angle=90),legend.position =  "none")  +xlab(NULL)+ylab(NULL) + xlab(NULL)+ylab(NULL) + coord_trans(y = squash_axis(0, 5, 2)) +scale_y_continuous(breaks = c(0,5,10,15))
p3 <- ggplot(a3,aes(id,value/1000,fill=id)) +geom_bar(stat = "identity",color="black",position = position_dodge())+ scale_fill_manual(values = c("#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#E5D8BD","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#FDCDAC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#CCCCCC","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#F4CAE4","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#E6F5C9","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#B3E2CD","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#FFF2AE","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#CCEBC5","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#DECBE4","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#FED9A6","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#F1E2CC","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#B3CDE3","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FBB4AE","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FFFFCC","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC","#FDDAEC" ,"#FDDAEC","#FDDAEC","#FDDAEC" ,"#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","#CBD5E8","red","red","red"))+ theme_bw() + theme( axis.text.x=element_text(angle=90),legend.position =  "none")  +xlab(NULL)+ylab("intact LTR_RT mean length(1000bp)")  + coord_trans(y = squash_axis(0, 5, 2)) +scale_y_continuous(breaks = c(0,5,10,15))
library(patchwork)
p1 / p2 / p3 

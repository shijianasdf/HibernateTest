# rdata  like: geneList_of_gene_Homo sapiens.rData 
geneList_enrichment<-function(genelist,data_path="/pub5/xiaoyun/BioData/KDT/GPA_Human/",threshold=0.05,byPvalueORfdr="pvalue",symbolOrId="symbol"){   
#基因富集分析：
#' @param genelist 一个字符串，gene列表（id or symbol）
#' @param data_path 一个字符串，存放数据的目录
#' @param threshold 一个数值，阈值
#' @param byPvalueORfdr 一个字符串，pvalue或fdr
#' @param symbolOrId 一个字符串，symbol或gene ID 

  load(paste(data_path,"geneList_enrich.Rdata",sep=""))     
  pvalue<-c()
  gpa_info<-c()
  overlap_gene<-c()
  overlap_num<-c()
  background_num<-c()
  diff_gene_num<-c()
  
  geneListLength<-length(genelist)   
  #load rdata must contein geneList_Enrich
   for(i in 1:length(geneList_Enrich)){
     if(symbolOrId=='symbol'){
       overlap<-intersect(genelist,geneList_Enrich[[i]]$sig.geneSymbol)
       diff_gene_num_tmp<-geneList_Enrich[[i]]$sig.geneSymbol
     }else{
       overlap<-intersect(genelist,geneList_Enrich[[i]]$sig.geneID)
       diff_gene_num_tmp<-geneList_Enrich[[i]]$sig.geneID
     }     
	 #计算超几何p值
     pvalue<-c(pvalue,phyper(length(overlap)-1,geneListLength,geneList_Enrich[[i]]$background_gene_number-geneListLength,length(diff_gene_num_tmp),lower.tail=F))    
     gpa_info<-c(gpa_info,paste(geneList_Enrich[[i]]$gpa_info[c(1,2,8,9,11)],collapse=":"))
     overlap_gene<-c(overlap_gene,paste(overlap,collapse=":"))
     overlap_num<-c(overlap_num,length(overlap))
     diff_gene_num<-c(diff_gene_num,length(diff_gene_num_tmp))
     background_num<-c(background_num,geneList_Enrich[[i]]$background_gene_number)
     
   }    
   pvalue=cbind(gpa_info,diff_gene_num,overlap_gene,overlap_num,background_num,round(pvalue,4),round(p.adjust(pvalue,method="fdr"),4));
   
   if(byPvalueORfdr=="fdr"){
   		return(pvalue[which(as.numeric(pvalue[,7])<=threshold),]) 	
   }else{
   		return(pvalue[which(as.numeric(pvalue[,6])<=threshold),]) 
   }    
}
 



similar_foldchange_gpa<-function (gene_profile_path,min_overlap_geneNum=10,data_path="/pub5/xiaoyun/BigData/KDT/GPA_Human/",threshold=0.05,byPvalueORfdr="pvalue",fileType="gene_foldchange_id"){
  
  load(paste(data_path,"geneList_enrich.Rdata",sep=""))     
  back_data<-c()
  gpa_info<-c()
  pvalue<-c()
  corvalue<-c()
  overlap_num<-c()
  
  if(length(grep("gene_foldchange_id",fileType))==1){
    profile<-read.table(file=gene_profile_path,sep=" ",header=T,fill=T, stringsAsFactors=FALSE, comment.char="",row.names=1)
    gene_ids<-as.character(row.names(profile))
      
    for(i in 1:length(geneList_Enrich)){
      overlap<-intersect(gene_ids,as.character(row.names(geneList_Enrich[[i]]$foldchange_p_id)))
      
      if(length(overlap)<=min_overlap_geneNum){
        next
      }
      overlap_num<-c(overlap_num,length(overlap))
      cor_t<-cor.test(as.numeric(profile[overlap,]),as.numeric(geneList_Enrich[[i]]$foldchange_p_id[overlap,]))
      pvalue<-c(pvalue,as.numeric(cor_t$p.value))
      corvalue<-c(corvalue,cor_t$estimate)  
      gpa_info<-c(gpa_info,paste(geneList_Enrich[[i]]$gpa_info[c(1,2,8,9,11)],collapse=":"))          
    } 
    if(length(overlap_num)==0){return("less")}
    back_data=cbind(gpa_info,overlap_num,round(as.numeric(corvalue),4),round(as.numeric(pvalue),4),round(p.adjust(as.numeric(pvalue),method="fdr"),4))
    
    
    
  }else if(length(grep("gene_foldchange_symbol",fileType))==1){
    profile<-read.table(file=gene_profile_path,sep=" ",header=T,fill=T, stringsAsFactors=FALSE, comment.char="",row.names=1)
    gene_names<-as.character(row.names(profile))
   
    for(i in 1:length(geneList_Enrich)){

      overlap<-intersect(gene_names,as.character(geneList_Enrich[[i]]$foldchange_symbol))
      case_a<-geneList_Enrich[[i]]$foldchange_p_id[which(as.character(geneList_Enrich[[i]]$foldchange_symbol) %in% overlap),]
      case_b<-profile[gene_names %in% overlap,]
      
      if(length(overlap)<=min_overlap_geneNum){
        next
      }
      overlap_num<-c(overlap_num,length(overlap))
      cor_t<-cor.test(case_a,case_b)
      pvalue<-c(pvalue,as.numeric(cor_t$p.value))
      corvalue<-c(corvalue,cor_t$estimate)  
      gpa_info<-c(gpa_info,paste(geneList_Enrich[[i]]$gpa_info[c(1,2,8,9,11)],collapse=":"))          
    }  
    if(length(overlap_num)==0){return("less")}
    back_data=cbind(gpa_info,overlap_num,round(as.numeric(corvalue),4),round(as.numeric(pvalue),4),round(p.adjust(as.numeric(pvalue),method="fdr"),4))
         
  }else if(length(grep("GPL",fileType))==1){
    ##处理GEO matrix 
    
    
    
    
  }else{
 
  }
 
  if(length(dim(back_data))==1){return("less")}
  if(byPvalueORfdr=="fdr"){
    back_data<-back_data[which(as.numeric(back_data[,5])<=threshold),,drop=F]   
  }else if(byPvalueORfdr=="pvalue"){
    back_data<-back_data[which(as.numeric(back_data[,4])<=threshold),,drop=F] 
  }else{
    back_data<-back_data[which(abs(as.numeric(back_data[,3]))>=threshold),,drop=F]
  }    
  if(length(dim(back_data))==1){return("less")}
  back_data<-back_data[order(abs(as.numeric(back_data[,3])),decreasing=T),,drop=F]
  
  col_v<-as.numeric(back_data[,3])
  colorfun <- colorRamp(c("#00CC00","white","#cc0000"), space="Lab")#green to red
  if(dim(back_data)[1]==1){
    col<-rgb(colorfun(if(col_v>0){1}else{0}),maxColorValue=255)
  }else{
    col<-rgb(colorfun((col_v-min(col_v))/(max(col_v)-min(col_v))),maxColorValue=255)
  }
  
  back_data<-cbind(back_data,col)
  return(back_data)    
}

compareToolgene<-function(gpa_id_a,gpa_id_b,basePath="/pub5/xiaoyun/BigData/KDT/"){   
#' 比较两个GPAid信息
#' @param gpa_id_a 一个字符串：对应gpa_id_a
#' @param gpa_id_b 一个字符串：对应gpa_id_b
#’ @param basePath：一个字符串，存放数据的绝对路径
  gpa_a<-getPathFromGPAID(basePath,gpa_id_a)
  gpa_b<-getPathFromGPAID(basePath,gpa_id_b)
  
  return_data<-c()
  
  if(length(gpa_a)>0 && length(gpa_b)>0){
     overlap_names=as.character(intersect(rownames(gpa_a),rownames(gpa_b)))   
     onlya<-as.character(setdiff(rownames(gpa_a),rownames(gpa_b)))
     onlyb<-as.character(setdiff(rownames(gpa_b),rownames(gpa_a)))
     
     ##读取id进行symbol转换
     Symbol2IDRelations <- read.table(paste(basePath,"/additionalData_For_Transcriptome_Analysis/Symbol2IDRelations",sep=""), header=F,row.names=1,sep="\t",stringsAsFactors=F)     
     
     stats<-c(dim(gpa_a)[1]-length(overlap_names),dim(gpa_b)[1]-length(overlap_names),length(overlap_names),0)
     overlap_data<-cbind(gene_id=overlap_names,gene_symbol=Symbol2IDRelations[overlap_names,],gpa_ap=round(gpa_a[overlap_names,"p.value"],5),gpa_bp=round(gpa_b[overlap_names,"p.value"],5))  
     onlya_data<-cbind(gene_id=onlya,gene_symbol=Symbol2IDRelations[onlya,],gpa_ap=round(gpa_a[onlya,"p.value"],5),gpa_bp=round(gpa_a[onlya,"p.value"],5))
     onlyb_data<-cbind(gene_id=onlyb,gene_symbol=Symbol2IDRelations[onlyb,],gpa_ap=round(gpa_b[onlyb,"p.value"],5),gpb_bp=round(gpa_b[onlyb,"p.value"],5))
     
     return_data<-rbind(stats,overlap_data,onlya_data,onlyb_data)
  }else{
    return("john")  
  }  
    
  return(return_data) 
}
#加载Rdata函数
getPathFromGPAID<-function(basePath,gpaID){
#' 加载Rdata函数
#' @param basePath:一个字符串，web数据存放的绝对路径；
#' @param gpaID：一个字符串，对应GPA ID，用于加载对应数据

 if(length(grep("^GPAHSA0",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_Human/",gpaID,"/results.RData",sep="")  
  }else if(length(grep("^GPAHSA1",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_Human_miRNA/",gpaID,"/results.RData",sep="")  
  }else if(length(grep("^GPAHSA2",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_Human_lncRNA/",gpaID,"/results.RData",sep="")  
  }else if(length(grep("^GPAMMU0",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_MUS/",gpaID,"/results.RData",sep="")  
  }else if(length(grep("^GPAMMU1",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_Mus_miRNA/",gpaID,"/results.RData",sep="")  
  }else if(length(grep("^GPAMMU2",gpaID,perl=T))==1){
    path=paste(basePath,"/GPA_Mus_lncRNA/",gpaID,"/results.RData",sep="")  
  }else{
    cat("error, id is not correct\n");
  }
  
  if(! file.exists(path)){
    return(NULL)
  }else{
    load(path)      
    return(results$sig.diff.results)   
  }
}
prepare_reverseSearch_genes(basePath="/pub5/xiaoyun/BigData/KDT/",additional_source_path="/pub5/xiaoyun/BigData/KDT/additionalData_For_Transcriptome_Analysis/"){
  
  human<-c("GPA_Human/","GPA_Human_lncRNA/","GPA_Human_miRNA/")
  mouse<-c("GPA_MUS/","GPA_Mus_miRNA/","GPA_Mus_lncRNA/")
  
 
  id2symbol<-read.table(paste(additional_source_path,"/Symbol2IDRelations",sep=""),head=F,sep="\t",row.names=1,as.is=T)   
  human_fc_pvalue <-fc_pvalue_matrix(basePath,human)
  
  
  human_res<-getFC_Pvalue(human_fc_pvalue,id2symbol)
  human_res<-human_res[order(human_res[,1]),]
  save(human_res,file=paste(basePath,"/human_res.rData",sep=""))
    
  mouse_fc_pvalue<-fc_pvalue_matrix(basePath,mouse)
  mouse_res<-getFC_Pvalue(mouse_fc_pvalue,id2symbol)
  mouse_res<-mouse_res[order(mouse_res[,1]),]
  save(mouse_res,file=paste(basePath,"/mouse_res.rData",sep="")) 
}


getFC_Pvalue<-function(human_fc_pvalue,id2symbol){
  gpa_ids<-colnames(human_fc_pvalue[[1]])  
  gene_ids<-as.character(rownames(human_fc_pvalue[[1]]))
  gene_names<-as.character(id2symbol[gene_ids,])

  
  return_info<-c()
  for(i in 1:length(gpa_ids)){
    cat(gpa_ids[i],"\n")
    tmp<-getPathFromGPAID(basePath,gpa_ids[i])  
    fc<-as.character(round(human_fc_pvalue[[1]][,i],6))
    pvalue<-as.character(round(human_fc_pvalue[[2]][,i],6))
    return_tmp<-c()
    
    
    for(j in 1:length(gene_names)){
      yy<-fc[j]      
      if(!is.na(yy)){      
        return_tmp=rbind(return_tmp,c(gene_names[j],tmp,yy,pvalue[j]))     
      }       
    } 
    ##拆开rbind，快速增加拼接速度
    return_info=rbind(return_info,return_tmp)  
  } 
  return(return_info)
}




fc_pvalue_matrix<-function(basePath,organism=c("GPA_Human/","GPA_Human_lncRNA/","GPA_Human_miRNA/")){
  #把参数给出的文件夹内所有GPA对应的基因合并成一个大文件
  
  #1.找出所有当前物种的GPA路径
  gpa_path<-c();
  for(i in 1:length(organism)){
    
    path<-paste(basePath,organism[i],sep="/");   
    temp=paste(path,dir(path,pattern="^GPA[A-Z]{3}\\d+{6}$"),sep="") ;#当前路径下面的所有GPA
    gpa_path <-c(gpa_path,temp);   
  }
  
  #返回所有的GPA中是否具有result.RData的GPA
  t1 <- sapply(gpa_path,function(x){
    result.dir <- file.path(x,"results.RData");
    file.exists(result.dir);
  })  
  gpa_path <- gpa_path[which(t1==TRUE)]  #具有result.RData的GPA id
  
  #2.构建所有GPA的fc的list
  fc_list <- list(); #构建所有GPA的所有的基因的fc
  for(i in 1:length(gpa_path))
  {
    load(paste(gpa_path[i],"/results.RData",sep=""));
    t1 <- results$sig.diff.results;
    t2 <-t1[,"FC"];
    names(t2) <- as.character(rownames(t1))
    fc_list[[i]] <- t2;
    t3 <-unlist(strsplit(gpa_path[i],"/"));
    names(fc_list)[i] <- t3[length(t3)];     
  }
  
  #3.构建所有GPA的fc的map  
  gene_id <- unique(unlist(sapply(fc_list,function(x){names(x)})))  #获取所有的表达的基因
  fc_matrix <- matrix(NA,nrow=length(gene_id),ncol=length(fc_list)) #所有GPA的
  rownames(fc_matrix) <- gene_id;
  colnames(fc_matrix) <- names(fc_list);
  for(i in 1:length(fc_list))
  {
    temp <-fc_list[[i]];
    fc_matrix[names(temp),i] <- temp;
  }
  #4.构建所有GPA的p.value的map  
  pvalue_list <- list(); #构建所有GPA的所有的基因的t.test的p value
  for(i in 1:length(gpa_path))
  {
    load(paste(gpa_path[i],"/results.RData",sep=""));
    t1 <- results$sig.diff.results;
    t2 <-t1[,"p.value"];
    names(t2) <- as.character(rownames(t1))
    pvalue_list[[i]] <- t2;
    t3 <-unlist(strsplit(gpa_path[i],"/"));
    names(pvalue_list)[i] <- t3[length(t3)];     
  }
  
  gene_id <- unique(unlist(sapply(fc_list,function(x){names(x)})))  #获取所有的表达的基因
  pvalue_matrix <- matrix(NA,nrow=length(gene_id),ncol=length(fc_list)) #所有GPA的
  rownames(pvalue_matrix) <- gene_id;
  colnames(pvalue_matrix) <- names(pvalue_list);
  for(i in 1:length(pvalue_list))
  {
    temp <-pvalue_list[[i]];
    pvalue_matrix[names(temp),i] <- temp;
  }
  
  gpa_fc_pvalue <-list();
  gpa_fc_pvalue[[1]] <-fc_matrix;
  gpa_fc_pvalue[[2]] <- pvalue_matrix;
  names(gpa_fc_pvalue) <-c("fc_matrix","pvalue_matrix");
  return(gpa_fc_pvalue); 
}




getPathFromGPAID<-function(basePath,gpaID){
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
    next
    return(NULL)
  }else{
    load(path)      
    return(as.character(results$gpa_info[c("gpa_id","gene_symbol","organism","platforms","celltype_or_cellline","genetic_perturbation_manner")]))   
  }
}





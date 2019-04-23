get_Gene_hist<-function(gpaPath="/pub5/xiaoyun/BioData/KDT/GPA_Human/",gpaName="GPAHSA000001",rDataName="log2.t.matrix.RData",genelist=c("TP53"),symbol=T){  
  
  ##注意修改加载路径
  load(paste(gpaPath,gpaName,"/",rDataName,sep=""))  
  #这一段判断物种,目前只支持人和小鼠,以后需要扩展
  organism=""
  if(grep("^GPAHSA",gpaName)==1){
    organism="human"
  }else if(grep("^GPAMMU",gpaName)==1){
    organism="mouse"
  }else{
    cat("Have no such orgnsim in id convert at get_gene_hist")
    return(c("no result"))
  }
  
  gene_id=genelist
  if(symbol){  
    RS.assign(c,genelist)  
    RS.assign(c,organism)
    gene_id<-unlist(RS.eval(c,IP("IDConverts.ser", genelist, from="geneName", to="geneID",organism=organism)));    
  }
  #取与基因表达谱对应的基因交集 
  
  find=intersect(as.character(gene_id), rownames(log2.matrix.list$log2matrix))
  
  if(length(find)==0){
    return(c("no result"))
  }
  #获取表型标签
  
  
  
  phnotype_label=as.character(log2.matrix.list$t.pdata[colnames(log2.matrix.list$log2matrix),1])
  out_label=paste("'",paste(phnotype_label,collapse="','"),"'",sep="")
  
  if(length(find)==1){
    out_data=paste("{name:'",find,"',data:[",paste(log2.matrix.list$log2matrix[as.character(find),],collapse=","),"]}",sep="")    
  }else{
    tmp<-log2.matrix.list$log2matrix[as.character(find),]
    out_data=paste("{name:'",find[1],"',data:[",paste(tmp[as.character(find[1]),],collapse=","),"]}",sep="")
    for(i in 2:length(find)){
      out_data=paste(out_data,paste("{name:'",find[i],"',data:[",paste(tmp[as.character(find[i]),],collapse=","),"]}",sep=""),sep=",")
    }   
  }    
  return(c(paste(find,collapse=","),out_label,out_data))
}
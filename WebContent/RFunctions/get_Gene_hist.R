get_Gene_hist<-function(gpaPath="/pub5/xiaoyun/BioData/KDT/GPA_Human/",gpaName="GPAHSA000001",rDataName="log2.t.matrix.RData",genelist=c("TP53"),symbol=T){  
#' 实时提取bar图和散点图
#' @param gpaPath 一个字符串，数据存放地址;
#' @param gpaName 一个字符串，GPA的ID
#' @param rDataName 数据存储，一个list列表，log2matrix，t.pdata，geneSymbol_relation；log2matrix：gene GSM* foldChange值,其行名为geneID，对应于geneSymbol_relation，t.pdata：信息统计；geneSymbol_relation：相关的genesymbol；


  getformat<-function(valist){
#' 提取JavaScript能够使用的返回结果；
#' @papram valist 一个字符向量并有命名；8.0541（RNAi） 9.949937（RNAi） 
    valist<-round(valist,4);#保留4位小数;
    return(paste("[",paste(valist,collapse=","),"]",sep=""))
	#返回结果"[8.0541,9.9499]"
  }
  
  getformat_err<-function(valist,errlist){
#' 提取JavaScript能够使用的返回结果；
#' @papram valist 一个字符向量并有命名；8.0541（RNAi） 9.949937（RNAi）
#' @papram errlist 一个字符向量并有命名；错误区间单侧值

 
    v1<-round(valist-errlist,4)
    v2<-round(valist+errlist,4)   
    pp<-c()
    for(i in 1:length(v1)){
	#将对应的genen的对应值放在一起；
      pp<-c(pp,paste("[",v1[i],",",v2[i],"]",sep=""))
    }  
    return(paste("[",paste(pp,collapse=","),"]",sep=""))     
  }
#加载Rdata
  dir_path=paste(gpaPath,gpaName,"/",rDataName,sep="")
  
  ##注意修改加载路径
  #判断文件是否存在
  if(file.exists(dir_path)){
    load(dir_path) 
  }else{
    return(c("no result"))
  }
   
  #目前只支持人和小鼠,以后需要扩展

  
  gene_id=genelist
  if(symbol){  
  #按照genesymbol进行后续计算
  #进行symbol to symbol的转换
  #使用%in%：有一个功能，就是若gene_id中的元素不在log2.matrix.list$geneSymbol_relation中，则不会返回值，同时gene_id不是非冗余的，那么对于重复的元素，只返回在gene_id第一次出现的结果
    position<-which(log2.matrix.list$geneSymbol_relation %in% gene_id) 
    if(length(position)==0){
      return(c("no result"))
    }
	#保证只提取一行时，是一个矩阵（保留矩阵结构）?"[]"
    re<-log2.matrix.list$log2matrix[position,,drop=F]	#数据信息；
    find=log2.matrix.list$geneSymbol_relation[position]	#返回genesymbol信息
  }else{
   #按照genesID进行后续计算
    position<-which(rownames(log2.matrix.list$log2matrix) %in% gene_id)
    if(length(position)==0){
      return(c("no result"))
    } 
    re<-log2.matrix.list$log2matrix[position,,drop=F]
    find=rownames(re)	#对应的ID信息
  }

    foldchange<-c()
   #获取表型标签
  
    label<-log2.matrix.list$t.pdata[colnames(re),1]
	# GSM254301 GSM254302 GSM254297 GSM254298 
   # "RNAi"    "RNAi" "Control" "Control" 
    
    mean_all<-c()
    standerr_all<-c()
    for(g in 1:length(find)){
	#计算Control RNAi的均值
       mean_all<-rbind(mean_all,tapply(re[g,],as.factor(label),mean))       
       standerr_all<-rbind(standerr_all,tapply(re[g,],as.factor(label),function(x){if(length(x)==1){0}else{1.96*sd(x)/sqrt(length(x))}}))      
    }
    #判断是否只有control样本(是否是一定会有control样本):ignore.case:如果FALSE，模式匹配是大小写敏感的，如果TRUE，情况在匹配过程中忽略。
    control_index<-grep('control',colnames(mean_all),ignore.case=T)
    label<-colnames(mean_all)
    
    if(control_index==1){
      case_index=2  
    }else{
      case_index=1
    }    
    
    foldchange=mean_all[,case_index]-mean_all[,control_index]
    #生成JavaScript所需的字符串
    data_t1<-paste("{name:'",label[case_index],"',color: '#4572A7',type: 'column',yAxis: 1,data:",getformat(mean_all[,label[case_index]]),"}",sep="")
    data_t2<-paste("{name:'",label[case_index]," error',type: 'errorbar',yAxis: 1,data:",getformat_err(mean_all[,label[case_index]],standerr_all[,label[case_index]]),"}",sep="")
    data_t3<-paste("{name:'",label[control_index],"',color: '#999',type: 'column',yAxis: 1,data:",getformat(mean_all[,label[control_index]]),"}",sep="")
    data_t4<-paste("{name:'",label[control_index]," error',type: 'errorbar',yAxis: 1,data:",getformat_err(mean_all[,label[control_index]],standerr_all[,label[case_index]]),"}",sep="")    
    

  
    data_t5<-paste("{type: 'scatter',name: 'foldChange',data:",getformat(foldchange),",visible: false,marker: {radius:6,},tooltip: {headerFormat: '<b>{series.name}</b><br>',pointFormat: '{point.y}'}}",sep="")
    data_field<-paste(data_t1,data_t2,data_t3,data_t4,data_t5,sep=",")
    return(c(paste("['",paste(find,collapse="','"),"']",sep=""),data_field))
	#结果例子：
	#[1] "['TP53']"                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	#[2] "{name:'RNAi',color: '#4572A7',type: 'column',yAxis: 1,data:[9.9499]},{name:'RNAi error',type: 'errorbar',yAxis: 1,data:[[9.8757,10.0242]]},{name:'Control',color: '#999',type: 'column',yAxis: 1,data:[10.0362]},{name:'Control error',type: 'errorbar',yAxis: 1,data:[[9.962,10.1105]]},{type: 'scatter',name: 'foldChange',data:[-0.0863],visible: false,marker: {radius:6,},tooltip: {headerFormat: '<b>{series.name}</b><br>',pointFormat: '{point.y}'}}"
	#结果例子：
	#[1] "['RB1','TP53']"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	#[2] "{name:'RNAi',color: '#4572A7',type: 'column',yAxis: 1,data:[8.0541,9.9499]},{name:'RNAi error',type: 'errorbar',yAxis: 1,data:[[7.9904,8.1179],[9.8757,10.0242]]},{name:'Control',color: '#999',type: 'column',yAxis: 1,data:[8.1707,10.0362]},{name:'Control error',type: 'errorbar',yAxis: 1,data:[[8.107,8.2345],[9.962,10.1105]]},{type: 'scatter',name: 'foldChange',data:[-0.1166,-0.0863],visible: false,marker: {radius:6,},tooltip: {headerFormat: '<b>{series.name}</b><br>',pointFormat: '{point.y}'}}"

	
}
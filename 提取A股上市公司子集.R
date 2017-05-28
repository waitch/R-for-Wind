require(WindR)
w.start()

###w_tdays_data<-w.tdays("2017-04-08","2017-05-08")

#dd<-w.wss('300598.SZ,603337.SH','sec_name,address,city,province,ipo_date,phone,email,website')
#code_list <- w_wss_data$Data

##保存数据，按照R格式保存原始数据，避免因为格式问题带来的错误
save(code_list,file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\全部上市公司代码.Rdata")  

##读取数据
load("C:\\Users\\Rim Shen\\Desktop\\新股招股书\\全部上市公司代码.Rdata")


##调整日期格式
code_list$ipo_day <- w.asDateTime(code_list$IPO_DATE,asdate=T)



####选择条件子集####
##选择所有2017年上市的公司
set2017 <- subset(code_list,code_list$ipo_day>'2016-12-31')
###选取的子集的行号会沿用父集的行号，不利于进行排序，所以最好重新命名行名字
row.names(set2017)<-c(1:dim(set2017)[1])
set2017 <- set2017[order(set2017[,10],decreasing = T),]

##保存数据
save(set2017,file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\新股2017.Rdata")  
load(file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\新股2017.Rdata")


##选出所有在成都的上市公司
chengdu_base <- subset(code_list,code_list$CITY =="成都市")
sichuan_base <- subset(code_list,code_list$PROVINCE =="四川省")

##保存下这份名录，定期更新就行
write.csv(code_list,file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\全部上市公司代码.txt",row.names=F,quote=F)
write.csv(chengdu_base,file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\成都市上市公司.csv",row.names=F,quote=F)
write.csv(sichuan_base,file="C:\\Users\\Rim Shen\\Desktop\\新股招股书\\四川省上市公司.csv",row.names=F,quote=F)




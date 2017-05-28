require(WindR)
w.start()

##以下是研究当前市场定价行为
###1、确定股票列表
name_list <- '002867.SZ,603232.SH'
deadline <- 'tradeDate=20170509'

###2、提取数据
data_download<- w.wss(name_list,'sec_name,ipo_date,ipo_price,ipo_amount,ipo_totcapafterissue,close,,pre_close,pe_lyr,debttoassets','unit=1',deadline,'priceAdj=U','cycle=D','rptDate=20161231')
data <- data_download$Data
###3、整合数据
####3.1、计算当前总市值
data$total_markt_cap <- data$CLOSE*data$IPO_TOTCAPAFTERISSUE/10^8
####3.2、计算当前流通市值
data$in_market_cap <- data$CLOSE*data$IPO_AMOUNT/10^8

####3.3 目前相比IPO价格的涨幅
data$yield <- data$CLOSE/data$IPO_PRICE*100

####3.4 将日期数据转为规范格式. WIND的日期数据似乎是从1899-12-30开始的

data$ipo_day <- w.asDateTime(data$IPO_DATE,asdate=T)

####3.5 目前是否已经打开涨停板

#####简单起见，目前统计20个交易日后的股价，以此计算新股上市后涨幅
######先做个简单版本的。截止5月8日，看4月10日之前的股票迄今的涨跌幅

#先选取2017年以来上市的新股,这部分就是data

data410 <- subset(data,data$ipo_day<'2017-4-11') 

##
summary(data410$total_markt_cap)
summary(data410$PE_LYR)
summary(data410$yield)
namespace java com.jfshare.finagle.thrift.express
include "result.thrift"


/*物流跟踪的记录*/
struct TraceItem{
    1:string time,
	2:string context,
	3:string ftime
}

/*物流跟踪记录*/
struct ExpressTrace{
        1:string state,
    	2:string nu,
    	3:string status,
    	4:list<TraceItem> traceItems,
    	5:string orderId
}

struct ExpressInfo {
	1:i32 id,
	2:string name,              
	3:string queryUrl,        
	4:i32 status,         
	5:string comment,
	6:string createTime,
	7:i32 createUserId,
	8:string lastUpdateTime,
	9:i32 lastUpdateUserId,
	10:string kuaidiKey,
	11:string nameRule,
	12:string expressNoRule,
	13:i32 grabState,
	14:optional i32 typeState,
	15:optional string dnfTel,
	16:optional i32 userType,    /*使用方，0:默认全部，1：卖家，2：买家*/
	17:optional i32 serialNum,
}

struct ExpressInfoResult{
	1:result.Result result,
	2:optional list<ExpressInfo> expressInfoList
}

struct ExpressResult{
	1:result.Result result,
	2:optional ExpressInfo expressInfo,
	3:optional ExpressTrace expressTrace
}

/*物流查询条件*/
struct  ExpressQueryConditions{
        1:string name, 
	2:string nameRule,
	/*每页条数*/
	3:i32 pageSize,
	/*第几页*/
	4:i32 curPage,
	/*排序条件*/
	5:string orderByClause,
	/*id=0时表示全部*/
	6:i32 id,
	/*抓取状态，全部=-1 否=0 是=1*/
	7:i32 grabState,
	/*状态，全部=-1 启用=1 停用=2*/
	8:optional i32 status,
	/*物流类型，全部=-1 快递=0 货运=1*/
	9:optional i32 typeState,
	/*使用方，全部=-1 卖家=1 买家=2*/
	10:optional i32 userType
}

/*分页物流查询结果*/
struct ExpressInfoPaginate{
	1:result.Result result,
	/*总数量*/
	2:optional i32 total,        
	/*总页数*/
	3:optional i32 pageCount,
	4:optional list<ExpressInfo> expressInfoList
}

/*物流跟踪订阅请求*/
struct SubscribeReq{
    1:string company,
	2:string number,
	3:string fromAddr,
	4:string toAddr,
	5:string orderId,
	6:i32 comId,
	7:optional string mobiletelephone,
	8:optional string seller,
	9:optional string commodity
}

/*物流跟踪订阅响应*/
struct SubscribeRes{
    1:string status,
    2:string nu,
    3:string ischeck,
    4:string com,
    5:string traceJSON,
    6:string state
}

struct ExpressParams{
    1:string orderId,
    /*1:查快递信息，2：查物流跟踪信息，3：包含1、2*/
    2:i32 queryType,
    3:string com,
    4:string num,
	5:i32 comId
}

service ExpressServ {
    result.StringResult addExpress(1:ExpressInfo info)
    result.Result updateExpress(1:ExpressInfo info)
    result.Result deleteExpress(1:i32 id)
    /*查询所有物流，提供下拉列表使用*/
	ExpressInfoResult query()
	ExpressInfo queryById(1:i32 id)
	/*按卖家查询*/
	ExpressInfoResult queryBySeller(1:i32 sellerId)
	/*综合查询*/
	ExpressInfoPaginate queryByConditions(1:ExpressQueryConditions conditions)
    /*批量查询物流*/
	ExpressInfoResult queryBatch(1:list<i32> idList) 
	/*查询货运物流*/
    ExpressInfoResult queryFreight()
	/*查询所有物流，原query()接口*/
	ExpressInfoResult queryEx()

	/*启用停用*/
	result.Result updateStatus(1:i32 id, 2:i32 status)

	/*订阅物流跟踪请求*/
	result.Result subscribeExpressPost(1:SubscribeReq req)

	/*更新物流跟踪记录*/
	result.Result subscribeExpressRecord(1:SubscribeRes res)

	/*查询物流信息及跟踪记录*/
    ExpressResult expressQuery(1:ExpressParams params)
}
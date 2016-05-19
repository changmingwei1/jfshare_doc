namespace java com.jfshare.finagle.thrift.score

include "result.thrift"
include "pagination.thrift"

/* 积分 */
struct Score {

	/* 用户ID */
	1:i32 userId,
	/* 积分数量 */
	2:i32 amount,
}

struct ScoreTrade {
    /* 交易编号 */
    1:string tradeId,
    /* 用户ID */
    2:i32 userId,
    /* 交易时间 */
    3:string tradeTime,
    /* 积分收入、支出标识  1：收入  2：支出 */
    4:i32 inOrOut,
    /** 交易类型
      *  1:电积分兑换聚分享积分    2:聚分享积分兑换电信积分
      *  3:线下消费抵扣           4:线上消费抵扣
      *  5:聚分享商城购物累积积分  6:聚分享商城活动赠送积分
      */
    5:i32 type,
    /* 交易数量 */
    6:i32 amount,
    /** 交易方
      * 1:中国电信     2:老树咖啡
      * 3:聚分享商城   4:聚分享手机商城
      */
    7:i32 trader
}

struct ScoreTradeQueryParam {
	/* 用户ID */
    1:i32 userId,
    /* 开始时间 */
    2:string startTime,
    /* 结束时间 */
    3:string endTime,
    /* 积分收入、支出标识 0: 全部 1：收入  2：支出 */
    4:i32 inOrOut,
    /** 交易类型  0：全部
      *  1:电积分兑换聚分享积分    2:聚分享积分兑换电信积分
      *  3:线下消费抵扣           4:线上消费抵扣
      *  5:聚分享商城购物累积积分  6:聚分享商城活动赠送积分
      */
    5:i32 type,
}

/* 获取用户积分数量 */
struct ScoreResult {
    1:result.Result result,
    2:Score sroce
}

/* 查询用户积分交易记录 */
struct ScoreTradeResult {
    1:result.Result result,
    2:list<ScoreTrade> scoreTrades,
    /* 分页信息 */
    3:pagination.Pagination pageination
}
/* 查询积分结构20160510 */
struct ScoreUser {
    /* 用户ID */
    1:i32 userId,
    /* 手机号 */
    2:string mobile,
    /* 创建时间 */
    3:string createTime,
    /* 积分值 0: 全部 1：0积分  2：0以上积分 */
    4:i32 amount,
}

/* 查询积分参数20160510 */
struct ScoreUserQueryParam {
    /* 用户ID */
    1:i32 userId,
    /* 手机号 */
    2:string mobile,
    /* 开始时间 */
    3:string startTime,
    /* 结束时间 */
    4:string endTime,
    /* 积分值  0:全部   1:0积分  2:0以上积分 */
    5:i32 amount,
}

/* 查询积分返回结果20160510 */
struct ScoreUserResult {
    1:result.Result result,
    2:list<ScoreUser> scoreUsers,
    /* 分页信息 */
    3:pagination.Pagination pageination
}

/* 兑出积分查询结构20160512_1 */
struct CachAmount {
    /* 总积分 */
    1:i32 totalAmount,
    /* 今日兑出积分 */
    2:i32 CachAmount,
}

/* 兑出积分查询参数20160512_1 */
struct CachAmountQueryParam {
    /* 用户ID */
    1:i32 userId, 
}

/* 兑出积分查询返回结果20160512_1 */
struct CachAmountResult {
    1:result.Result result,
    2:CachAmount cachAmount,
}

/* 兑出积分调用接口结构20160512_2 */
struct ReponseCach {
     /* 应用编码 */
    1:string AppCode,
    /* 请求时间 */
    2:string ResponseDate,
    /* 业务编号 */
    3:string Sign,
    /* 响应代码*/
    4:string ErrCode,
    /* 响应描述 */
    5:string ErrMsg,
}

/* 兑出积分调用接口参数20160512_2 */
struct CachAmountCallParam {
    /* 用户ID */
    1:i32 userId,
    /* 兑出积分额 */
    2:i32 CachAmount,
    /* 手机号 */
    3:string mobile, 
}
/* 兑出积分调用接口返回结果20160512_2 */
struct ResponseCachResult {
    1:result.Result result,
    2:ReponseCach reponseCach,
}

/* 兑入积分调用接口结构20160516_1 */
struct ResponseScore {
    /* 应用编码 */
    1:string AppCode,
    /* 请求时间 */
    2:string ResponseDate,
    /* 业务编号 */
    3:string Sign,
    /* 响应代码*/
    4:string ErrCode,
    /* 响应描述 */
    5:string ErrMsg,
}
/* 兑入积分调用接口参数20160516_1 */
struct ScoreRequestParam {
    /* 应用编码 */
    1:string AppCode,
    /* 请求时间 */
    2:string RequestDate,
    /* 数据签名 */
    3:string Sign,
    /* 业务编号 */
    4:string SpID,
    /* 外部订单号 */
    5:string OutOrderID,
    /* 设备号 */
    6:string DeviceNo,
    /* 设备类型 */
    7:string DeviceType,
    /* 省编号 */
    8:string ProvinceID,
    /* 客户编号 */
    9:string CustID,
    /* 积分额 */
    10:string Num,
    /* 备注 */
    11:string Remark,
    
    12:string ActiveID,
    /* 过期时间 */
    13:string ExpTime,   
}
/* 兑出积分兑入接口返回结果20160516_1 */
struct ResponseScoreResult {
    1:result.Result result,
    2:ResponseScore responseScore,
}

service ScoreServ {
    /* 收入积分 */
    result.StringResult income(1:ScoreTrade scoreTrade);
    /* 支出积分 */
    result.StringResult expenditure(1:ScoreTrade scoreTrade);
    /* 查询积分 */
    ScoreResult getScore(1:i32 userId);
    /* 查询积分交易记录*/
    ScoreTradeResult queryScoreTrade(1:ScoreTradeQueryParam param, 2:pagination.Pagination pagination);
    /* 查询积分记录20160510 */
    ScoreUserResult queryScoreUser(1:ScoreUserQueryParam param, 2:pagination.Pagination pagination);
    /* 兑出积分查询20160512_1 */
    CachAmountResult queryCachAmount(1:CachAmountQueryParam param); 
    /* 兑出积分调用接口20160512_2 */
    ResponseCachResult cachAmountCall(1:CachAmountCallParam param);   
    /* 兑入积分调用接口20160516_1 */
    ResponseScoreResult enterAmountCall(1:ScoreRequestParam param);
}
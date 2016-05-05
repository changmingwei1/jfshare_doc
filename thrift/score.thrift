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
    /* 交易时间 */
    2:string tradeTime,
    /* 积分收入、支出标识 0: 全部 1：收入  2：支出 */
    3:i32 inOrOut,
    /** 交易类型  0：全部
      *  1:电积分兑换聚分享积分    2:聚分享积分兑换电信积分
      *  3:线下消费抵扣           4:线上消费抵扣
      *  5:聚分享商城购物累积积分  6:聚分享商城活动赠送积分
      */
    4:i32 type,
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


service ScoreServ {
    /* 收入积分 */
    result.StringResult income(1:ScoreTrade scoreTrade);
    /* 支出积分 */
    result.StringResult expenditure(1:ScoreTrade scoreTrade);

    /* 查询积分 */
    ScoreResult getScore(1:i32 userId);
    /* 查询积分交易记录*/
    ScoreTradeResult queryScoreTrade(1:ScoreTradeQueryParam param, 2:pagination.Pagination pagination);

    /* 积分兑换的定义 */
}
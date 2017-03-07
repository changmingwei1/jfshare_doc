namespace java com.jfshare.finagle.thrift.aftersale

include "result.thrift"
include "pagination.thrift"
/* 售后 */
struct AfterSale {
	/* 用户ID */
	1:i32 userId,
	/* 卖家ID */
	2:i32 sellerId,
	/* 订单ID */
	3:string orderId,
	/* 商品ID */
	4:string productId,
	/* 申请类型 */
	5:i32 type,
	/* 申请原因 */
	6:string reason,
	/* 售后状态 根据实际情况定义  如 1：新建（待审核）   2：审核通过  3：审核不通过  99：已完成 */
	7:i32 state,
	/* 商品sku编码 */
	8:string skuNum,
	/* 用户申请退货的备注信息 */
	9:string userComment,
	/* 用户申请退货时间 */
	10:string applyTime,
	/* 审核退货申请的备注信息 */
	11:string approveComment,
	/* 审核处理时间*/
	12:string approveTime
	/* 用户下单时间  yyyy-MM-dd HH:mm:ss*/
	13:string orderTime,  
}
/* 售后查询参数 */
struct AfterSaleQueryParam {
    /* 用户ID */
    1:i32 userId,
    /* 卖家ID */
    2:i32 sellerId,
    /* 订单ID */
    3:string orderId,
    /* 商品ID */
    
    4:string productId,
    /* 申请类型 */
    5:i32 type,
    /* 售后状态 */
    6:i32 state,
    /* 商品SKU编码 */
    7:string skuNum,
    8:optional list<string> orderIdList,
}

/* 售后订单个数查询参数 */
struct AfterSaleQueryCountParam {
    /* 卖家ID */
    1:i32 sellerId,
    /* 售后状态 根据实际情况定义  如 1：新建（待审核）   2：审核通过  3：审核不通过  99：已完成 */
    2:i32 state,
}

/* 查询售后 */
struct AfterSaleResult {
    1:result.Result result,
    2:list<AfterSale> afterSaleList
}

/* 查询申请售后订单数量 */
struct AfterSaleCountResult {
    1:result.Result result,
    2:i32 count,
}

struct AfterSaleOrder{
    1:i32 userId,
    2:string orderId,
    3:i32 sellerId
}

struct AfterSaleOrderResult{
    1:result.Result result,
    2:list<AfterSaleOrder> afterSaleOrders,
    3:list<AfterSale> afterSaleList,
    4:pagination.Pagination pagination
}
/* 查询售后订单参数*/
struct AfterSaleOrderParam{
	1:i32 userId,/* 用户ID*/
    2:string orderId,/* 订单ID*/
    3:i32 sellerId,/*卖家ID*/
    4:string startTime,/* 时间格式yyyyMMddHHmmss*/
    5:string endTime,/*时间格式 yyyyMMddHHmmss*/
    6:string payTimeStart,/* 时间格式yyyyMMddHHmmss*/
    7:string payTimeEnd,/*时间格式 yyyyMMddHHmmss*/
	8:i32 fromSource /*订单来源 聚分享pc=1,聚分享Android=2，聚分享ios=3，聚分享H5=4，百分尊享PC=5，百分尊享H5=6*/
}

/*退货成功退积分参数*/
struct ReturnScoreParam{
	1:string productId,/*商品ID*/
    2:string orderId,/* 订单ID*/
    3:i32 scoreAmount,/*操作积分额*/
    4:string passWord,/*操作密码*/
}

/*退积分明细表*/
struct ScoreBackProduct{
	1:i32 id,/*主键*/
    2:string productId,/*商品ID*/
    3:i32 userId,/*订单使用积分额*/
    4:string orderId,/*订单ID*/
    5:i32 amount,/*商品单价积分*/
    6:string createTime,/*订单邮费*/
}

/*查询退积分明细返回结果*/
struct MaxReturnScoreResult{
	1:i32 productFinishScore,/*商品已退积分*/
    2:i32 orderFinishScore,/* 订单已退积分*/
    3:i32 orderExchangeScore,/*订单使用积分额*/
    4:string productPrice,/*商品单价积分*/
    5:string orderPostage,/*订单邮费*/
    6:list<ScoreBackProduct> sbpList, /*商品退积分集合*/
    7:result.Result result,
}


service AfterSaleServ {
    /* 申请售后 */
    result.StringResult request(1:AfterSale afterSale);
    /* 售后通过 */
    result.StringResult auditPass(1:AfterSale afterSale);

    /* 查询售后 */
    AfterSaleResult queryAfterSale(1:AfterSaleQueryParam param);
    
    /* 查询申请售后订单数量 */
    AfterSaleCountResult queryAfterSaleCount(1:AfterSaleQueryCountParam  param);

    /* 查询售后订单*/
    AfterSaleOrderResult queryAfterSaleOrder(1:AfterSaleOrderParam param, 2:pagination.Pagination pagination);
    
    /* 退货成功查询可退最大积分额*/
    MaxReturnScoreResult queryMaxReturnScore(1:ReturnScoreParam param);
    
    /*退货成功退还积分*/
    result.StringResult ReturnScore(1:ReturnScoreParam param);
		
}
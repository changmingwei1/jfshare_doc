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
    7:string skuNum
}

/* 获取用户积分数量 */
struct AfterSaleResult {
    1:result.Result result,
    2:list<AfterSale> afterSaleList
}

struct AfterSaleOrder{
    1:i32 userId,
    2:string orderId,
    3:i32 sellerId
}

struct AfterSaleOrderResult{
    1:result.Result result,
    2:list<AfterSaleOrder> afterSaleOrders,
    3:pagination.Pagination pagination
}
/* 查询售后订单参数*/
struct AfterSaleOrderParam{
	1:i32 userId,/* 用户ID*/
    2:string orderId,/* 订单ID*/
    3:i32 sellerId,/*卖家ID*/
    4:string startTime,/* 时间格式yyyyMMddHHmmss*/
    5:string endTime,/*时间格式 yyyyMMddHHmmss*/
}

service AfterSaleServ {
    /* 申请售后 */
    result.StringResult request(1:AfterSale afterSale);
    /* 售后通过 */
    result.StringResult auditPass(1:AfterSale afterSale);

    /* 查询售后 */
    AfterSaleResult queryAfterSale(1:AfterSaleQueryParam param);

    /* 查询售后订单*/
    AfterSaleOrderResult queryAfterSaleOrder(1:AfterSaleOrderParam param, 2:pagination.Pagination pagination);
}
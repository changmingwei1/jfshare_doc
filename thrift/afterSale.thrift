namespace java com.jfshare.finagle.thrift.afterSale

include "result.thrift"

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
	7:i32 state
	/* 商品sku编码 */
	8:string skuNum
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
    6:i32 state
}

/* 获取用户积分数量 */
struct AfterSaleResult {
    1:result.Result result,
    2:list<AfterSale> afterSaleList
}


service AfterSaleServ {
    /* 申请售后 */
    result.StringResult request(1:AfterSale afterSale);
    /* 售后通过 */
    result.StringResult pass(2:AfterSale afterSale);

    /* 查询售后 */
    AfterSaleResult queryAfterSale(1:AfterSaleQueryParam param);
}
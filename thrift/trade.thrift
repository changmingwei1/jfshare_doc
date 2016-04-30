namespace java com.jfshare.finagle.thrift.trade

include "result.thrift"
include "order.thrift"
include "pay.thrift"

/*按卖家划分的信息*/
struct BuySellerDetail {
	1:i32 sellerId, /*卖家id*/
	2:string sellerName, /*卖家名称*/
	3:string buyerComment, /*买家备注*/
	4:list<order.OrderInfo> productList,  /*商品信息*/
}

/*购买信息*/
struct BuyInfo {
	/*买家ID*/
	1:i32 userId,           
	
	/*买家名称*/
	2:string userName,
	
	/*买家实际支付总额*/
	3:string amount, 
	
	/*支付相关信息*/
	4:pay.PayChannel payChannel,   
	
	/*买家收货地址信息*/
	5:order.DeliverInfo deliverInfo,   

        /*按卖家集合的商品信息*/
	6:list<BuySellerDetail> sellerDetailList,

	/*订单来源 pc=1,mobile=2*/
        7:i32 fromSource,
 
        /*商品渠道key*/
	8:string wi,

	/*兑换现金的积分*/
	9:optional i32 exchangeScore,
		
	/*兑换多少现金*/
	10:optional string exchangeCash,
	
	/*[必填]交易类别码  Z0001:积分兑换类 Z0002:虚拟商品-话费充值 Z0003:实体宝贝交易 Z0004:货到付款 Z0005:积分现金购 Z0006:天天红包 Z0008:微信春节卡券项目
		      Z9001:一元抢 Z9002:限时抢 Z9003:拍下立减 
		      Z8001:虚拟商品-卡密 Z8002:虚拟商品-密码（兑换码）
	*/
	11:optional string tradeCode,

        /*购买入口 0:未知 1:立即购买 2:购物车*/
	12:optional i32  fromBatch,
}

/*订单确认结果*/
struct OrderConfirmResult {
	1:result.Result result,
	2:optional list<string> orderIdList, /*订单id列表*/
	3:optional string extend, /*返回订单价格和时间*/
}


/* 交易服务 */
service TradeServ {

	 /* 订单确认 */
    OrderConfirmResult orderConfirm(1:BuyInfo buyInfo);

    /* 买家商品历史购买量 */
	result.StringResult buyCount(1:i32 userId, 2:string productId, 3:string storehouseId);
}
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

/*支付订单信息*/
struct PayOrderInfo {
	/*买家ID*/
	1:i32 userId,           
	
	/*买家名称*/
	2:string userName,
	
	/*卖家ID*/
	3:i32 sellerId,
	
	/*卖家Name*/
	4:string sellerName,
	
	/*支付订单金额，单位元*/
	5:string amount,
	
	/*[必填]交易类别码  Z0010:扫码支付*/
	6:string tradeCode
}

/*订单确认结果*/
struct OrderConfirmResult {
	1:result.Result result,
	/*订单id列表*/
	2:optional list<string> orderIdList, 
	 /*返回订单价格和时间*/
	3:optional string extend
	
}

/***********************积分抵现相关数据结构**************************/
struct ExchangeProduct {
	/* 商品名称 */
	1:string productId, 
	/* sku编码 */
	2:string skuNum,
	/* 金额（扣除其他优惠， 不含运费） */
	3:string price
}


struct ExchangeRule {
	/* 兑换比例, 最多可兑换总金额的百分比 */
	1:string percent,

    /* 例如： 100积分兑换1元  score=100, cash=1 */
	/* 多少积分 */
	2:string score,
	
	/* 兑换多少现金 */
	3:string cash,
	
	/* 例如：可兑换金额不超过2元 maxExchangeCash=2 */
	/* 若当前时间不在兑换活动期间 maxExchangeCash=0 */
	/* 可兑换现金限制 */
	4:optional string maxExchangeCash
}

struct ExchangeParam {
	/* 用户ID */
	1:i32 userId,                   
	
	/* 商品列表 */
	2:list<ExchangeProduct> productList,             
	
	/* 订单价格（扣除其他优惠， 不含运费）*/ 
	3:string amount,                    
	
	/* 使用多少积分来抵现金 */
	4:string score,

	/* 交易类型码 */
	5:optional string tradeCode
}

struct ExchangeDetail{
	1:string productId, 
	
	2:string skuNum,
	
	3:string price, 
	
	4:i32 count,
	
	/*积分*/
	5:string score,     
	
	/*兑换的现金*/
	6:string amount,    
	
	/*规则（兑换比例）*/
	7:ExchangeRule rule       
}

struct ExchangeResult {
    1:result.Result result,

	/*总积分*/
	2:string totalScore,

	/*可兑换的积分*/
	3:string exchangeScore,
          
	/*抵了多少现金*/
	4:string amount,          
	
	/*具体到某一个商品上积分可抵现金的信息*/
	5:list<ExchangeDetail>  exchangeDetailList

}

struct ExchangeRuleResult {
	1:result.Result result,

	/*规则*/
	2:ExchangeRule exchangeRule
}


/* 交易服务 */
service TradeServ {

	 /* 订单确认 */
    OrderConfirmResult orderConfirm(1:BuyInfo buyInfo);

    /*线下订单确认*/
    OrderConfirmResult orderConfirmOffline(1:BuyInfo buyInfo);

    /* 买家商品历史购买量 */
	result.StringResult buyCount(1:i32 userId, 2:string productId);
	
	/*获取兑换规则*/
	ExchangeRuleResult getExchangeRule();
	
	/*计算可抵现的积分*/
	ExchangeResult getExchangeScore(1:ExchangeParam param);       
    
	/*计算可抵多少现金*/
	ExchangeResult score2cash(1:ExchangeParam param);
	
	/* 线下扫码支付订单生成 */
   OrderConfirmResult payOrderCreate(1:PayOrderInfo payOrderInfo);
	
}
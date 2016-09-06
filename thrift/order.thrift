namespace java com.jfshare.finagle.thrift.order

include "result.thrift"
include "pay.thrift"

/* 订单关闭原因*/
enum OrderCancelReason {
	/*我不想买了*/
	drop_it=1,
	
	/*信息填写错误*/
	msg_error=2,
	
	/*重新拍*/
	rebuy=3,
	
	/*卖家缺货*/
	out_of_stock=4,
	
	/*同城见面交易*/	
	face_to_face_deal=5,
	
	/*其他原因*/
	other=6,
	/*支付方式不符合*/
	pay_type=7,
	
	/*账户余额不足*/
	balance=8,

	/*担心质量没有保障*/
	quality=9,

	/*联系不到商家无法沟通*/
	lost_in=10
}

enum OrderStateType {
	/*支付超时*/
	pay_timeout_cancel=101,
	
	/*买家取消*/
	buyer_cancel=102,
	
	/*售后取消*/
	refund_close=103,
	
	/*维权取消*/
	complain_close=104,
	
	/*黄牛订单，取消*/
	scalper_close=105
}

/*支付信息*/
struct PayInfo {

	1:string payChannel,        

	/*支付交易号*/
	2:string payId,      

	/*付款时间*/
	3:string payTime,     

	/*支付帐号*/
	4:string payAccount,         

	/*支付状态   0未支付， -1失败， 1成功，  2014-2-24*/
	5:i32    payState
}

/*收货相关*/
struct DeliverInfo {
	1:i32 userId,    /*买家ID*/            
	2:string orderId,    /*订单ID*/    
	3:string buyerComment,    /*买家备注*/
	4:string sellerComment, 	/*卖家备注*/
	
	5:string receiverName,    /*收货人姓名*/
	6:string receiverMobile,    /*收货人手机号*/
	7:string receiverTele,  /*收货人电话*/    
	8:i32 addressId,     /*收货地址ID*/            
	9:i32 provinceId,   /*省ID*/       
	10:i32 cityId,    /*市ID  */              
	11:i32 countyId,      /*区县ID*/           
	12:string provinceName,    /*省名称*/          
	13:string cityName,       /*市名称*/        
	14:string countyName,      /*区县名称*/    
	15:string receiverAddress,   /*详细收货地址*/
	16:optional string postCode,    /*邮编*/

        17:optional string expressId,    /*快递id*/
	18:optional string expressName,   /*快递名称*/
	19:optional string expressQueryUrl, /*快递官网*/
	20:optional string expressNo,  /*快递单号*/    
	21:optional string expressDnfTel,/*快递电话*/
	22:optional i32 expressTypeState,   /*物流类型，0：默认快递，1：是货运公司*/
}

/*订单的产品信息*/
struct OrderInfo {      
        1:string orderId,   
	
	/*商品ID */
	2:string productId,		

	/*商品名称 */
	3:string productName,

	/*商品副标题 */
	4:string viceName,
	
	/*关联类目ID */
	5:string subjectId,	
	
	/*所属品牌ID */
	6:string brandId,	

	/*商品快照ID*/
	7:string productSnapshootId,	

	/*sku编码 pId-vId:pId-vId */
	8:string skuNum,            

	/*sku描述*/
	9:string skuDesc,		      

	/*商品单价 (成交价格)*/
	10:string curPrice,		

	/*原价*/
	11:string orgPrice,	

	/*sku图片URL  sku无图片取商品主图url*/
	12:string imagesUrl,	

	/*库位*/
	13:string shelf,	
	
	/*商品编码*/
	14:string sellerClassNum, 

	/*商品数量*/
	15:i32 count,		        	

	/*最后修改时间*/
	16:string lastUpdateTime,     

	/*修改人id*/
	17:i32 lastUpdateUserId,         

	/*创建时间*/
	18:string createTime,            

	/*创建人id*/
	19:i32 createUserId,                     

	/*商品类型*/
	20:string type,
	
	/*商品渠道*/
	21:string wi,

	/*兑换现金的积分*/
	22:optional i32 exchangeScore,

	/*兑换多少现金*/
	23:optional string exchangeCash,
	
	/*仓库id*/
	24:optional i32 storehouseId,
	
	/*运费模板*/
	25:optional i32 postageTemplateId,
	/*运费*/
	26:optional string postage,
	/* 参考售价 */
 	27:optional string refPrice,
 	/* 第三方积分抵现比率 如:10，1分抵10分钱*/
    28:optional string thirdExchangeRate,
	/*运费扩展信息  JSON*/
	29:optional string postageExt,
	30:optional string weight
 	
}

/*订单*/
struct Order {
        1:string orderId,   
	2:string tradeCode,        
	3:i32 userId,           
	4:string userName,  
	5:string createTime,
	6:string cancelTime,  
	7:PayInfo payInfo,    

	8:i32 sellerId,   
	9:string sellerName,      
	10:string closingPrice,    
	11:string thirdId,       
	12:DeliverInfo deliverInfo,    
	13:i32 orderState,                      
	14:optional string sellerComment,      
	15:optional string buyerComment,      
	16:optional string lastUpdateTime,   
	17:optional i32 lastUpdateUserId,    	
	18:optional i32 createUserId, 
	19:optional string deliverTime,        
	20:optional string successTime,      
	21:optional i32 settlementState,
	22:string postage,
	23:optional OrderStateType orderStateType,
	24:optional OrderCancelReason orderStateTypeDesc,
        25:optional string settlementTime,
	26:optional i32 orderTag,
        27:string wi,
        28:i32 fromSource,
        29:string tradePayId,
        30:optional i32 orderDeleteState,
	31:optional i32 exchangeScore,
	32:optional string exchangeCash,
        33:optional string orderBatch,  /*订单批次 组成 0:未知 1:立即购买 2:购物车-同批选定订单号-同批订单数*/
	34:optional i32 activeState,

	35:list<OrderInfo> productList,
	36:optional i32 thirdScore,
	/*运费扩展信息  JSON*/
	37:optional string postageExt,
       38:optional i32 orderType,
	   39:optional string thirdPrice
}

/*订单查询条件*/
struct  OrderQueryConditions{

	/*商家ID*/
	1: i32 sellerId,          

	/*商品名称*/
	2: string productName,     

	/*订单ID*/
	3: string orderId,        

	/*订单状态*/
	4: i32 orderState,     

	/*用户名称*/
	5: string userName,        

	/*手机号码*/
	6: string mobile,       

	/*订单类型*/
	7: i32 orderType,         

	/*省份*/
	8: i32 provinceId,  

	/*市*/
	9: i32 cityId,         

	/*县*/
	10: i32 countyId,     

	/*创建时间*/
	11: string startTime,  

	/*创建时间*/
	12: string endTime,  

	/*每页的条数*/
	13: i32 count,         

	/*第几页*/
	14: i32 curPage,
	
	/*运单号*/
	15: optional string expressNo,   
	
	/*快递公司id*/
	16: optional i32 expressId,   
	
	/*买家昵称*/
	17: optional string nickName,

	/*商品ID*/
	18: string productId,

	/*买家id*/
	19: i32 userId,
	
	/*排序字段
	0：订单创建时间降序，默认
	1：订单创建时间升序
	2：订单支付时间降序
	3：订单支付时间升序
	4：订单发货时间降序
	5：订单发货时间升序
	6：发货截止时间降序
	7：发货截止时间升序
	8：订单成交时间降序
	9：订单成交时间升序
	10：订单最后修改时间降序
	11：订单最后修改时间升序
	*/
	20:optional i32 sortRule,
	
	/*支付开始时间*/
	21:optional string payTimeStart,

	/*支付结束时间*/
	22:optional string payTimeEnd,

	/*发货开始时间*/
	23:optional string deliverTimeStart,

	/*发货结束时间*/
	24:optional string deliverTimeEnd,

	/*订单成交开始时间*/
	25:optional string successTimeStart,

	/*订单成交结束时间*/
	26:optional string successTimeEnd,

	/*订单最后修改开始时间*/
	27:optional string lastUpdateTimeStart,

	/*订单最后修改结束时间*/
	28:optional string lastUpdateTimeEnd,

	/*是否超卖订单，0：正常，1：超卖*/
	29:optional i32 orderTag,

	/*待发货的状态判断，1：待发货即将超时（小于12小时），2：待发货已超时*/
	30:optional i32 deliverLimitTimeState,

	/*是否有买家留言 0:全部，1:有买家留言*/
	31:optional i32 isHaveBuyerComment,

	/*是否有卖家备注 0:全部，1:有卖家备注*/
	32:optional i32 isHaveSellerComment,

    /*导出来源：0 普通导出，1发货导出*/
	33:optional i32 downType,
	/*订单列表*/
	34:optional list<string> orderIds
}

struct OrderCount {
	/*订单状态*/
	1:i32 orderState,     

	/*数量*/
	2:i32 count            
}

/*订单简介分页*/
struct  OrderProfilePage{
	/*总数量*/
	1:i32 total,          

	/*页数*/
	2:i32 pageCount,    

	/*每页数量*/
	3:i32 count,          

	/*第几页*/
	4:i32 curPage,             

	5:optional list<Order> orderProfileList,

	/*各种状态订单的数量*/
	6:list<OrderCount> orderCountList   
}


struct OrderProfileResult {
	1:result.Result result,
	2:optional OrderProfilePage orderProfilePage
}

struct OrderStateResult {
	1:result.Result result,
	/*各种状态订单的数量*/
	2:list<OrderCount> orderCountList  
}

/*第三方通知接口 信息*/
struct ThirdPartNotifyInfo {
	/*我方的订单Id 有可能没有依赖第三方接口*/
	1:string orderId,	

	/*提交的时候第三方返回的Id 对方的Id 有的接口会使用我们业务系统提供的订单Id ，那么有可能 orderId == thirdId*/
	2:string thirdId,

	/*第三方操作的时间  对方可能会返回他们操作的时间  可能*/
	3:string handletime,

	/*处理状态   0成功 9表示取消 ，可以理解为非0即是表示失败， 下面会有失败的原因*/
	4:i32 state,		

	/*状态描述*/
	5:string desc,	

	/*通知订单的类型	比如 物流 话费充值等。暂时只定义 一个 ：  HF：表示花费充值操作返回的通知  ZF：支付*/
	6:string orderType,	

	/*表示提交给第三方时 的用户id ,充值等 应该是公司的用户名id 其他的暂时未定义*/
	7:string customerId,
	
	/*支付方式*/
	8:string payTool,
	
	9:string zheOrderId,
	/*商城的订单id list*/

	10:string amount,
	
	/*支付平台处理结果返回的时间*/
	11:optional string processtime,

        /*商城收到支付通知的时间*/
	12:optional string recvtime
}

/*----超卖订单查询条件--------------------------------------------------------------------*/
struct  OverSoldQueryConditions{
	
	/*订单ID*/
	1: string orderId,         	
	
	/*卖家昵称*/
	2: string sellerNick, 
	
	/*处理状态， 0为未处理，  1为已经处理*/
	3: i32 handleState,

        /*0 发货， 1 退款*/
	4: i32 handleType,
	

	/*当前页码*/
	5: i32 page,     
	
	/*当前页显示数量*/
	6: i32 perPage
	          			
}

struct OrderDetailResult {
	1:result.Result result,
	2:optional Order order
}

/*支付参数*/
struct PayParam {
	1:i32 userId,   /*买家ID*/
	2:list<string> orderIdList, 
	3:pay.PayChannel payChannel,  /*支付方式*/
	/*兑换现金的积分*/
	4:optional i32 exchangeScore,

	/*兑换多少现金*/
	5:optional string exchangeCash
}

/*支付进度*/
struct PayState {
    1:string payId,
    2:string tokenId,

    3:i32 retCode, /*处理状态 2:成功 3:失败*/
    4:i32 cancelTime, /*取消时间*/
}

struct PayStateResult {
    1:result.Result result,
    2:optional PayState payState,
}

struct DeliverVirParam {
    1:i32 sellerId,
    2:string orderId
}

struct BatchDeliverFailInfo {
	1:i32 index,
	2:string orderId,
	3:string desc,
	4:Order order
}

struct BatchDeliverResult {
	1:result.Result result,
	2:optional list<BatchDeliverFailInfo> failInfo
}

struct BatchDeliverParam {
	1:i32 deliverType,
	2:list<Order> orderList,
	3:string fileName,
	4:string fileKey
}

struct orderSellerQueryParam{
1:string mobile, 	/*买家手机号*/
2:i32 sellerId, 	/*卖家ID*/
3:sring orderId,	/*订单ID*/
4:string startTime, /*开始时间*/
5:string endTime	/*结束时间*/
}

/*订单服务*/
/*
  userType: 1（买家）、2（卖家）、3 (系统)
*/
service OrderServ{ 
	/*创建订单,返回订单id列表(买家)*/
	result.Result createOrder(1:list<Order> orderList)
	
	/*修改收货地址(买卖双方)*/
	result.Result updateDeliverInfo(1:i32 userType, 2:i32 userId, 3:DeliverInfo deliverInfo) 

	/*发货(卖家)*/
	result.Result deliver(1:i32 sellerId, 2:DeliverInfo deliverInfo)     

	/*虚拟商品发货*/
	result.Result deliverVir(1:DeliverVirParam param)
	
	/*卖家修改订单物流、运单号、物流名称*/
	result.Result updateExpressInfo(1:i32 sellerId, 2:string orderId, 3:string expressId, 4:string expressNo, 5:string expressName)
	
	/*确认收货(买家、系统)*/
	result.Result confirmReceipt(1:i32 userType, 2:i32 userId, 3:string orderId)   
	
	/*取消订单(买家、系统)*/
	result.Result cancelOrder(1:i32 userType, 2:i32 userId, 3:string orderId, 4:i32 reason)     
	

	/*查询订单列表(买卖双方)*/
	OrderProfileResult orderProfileQuery(1:i32 userType, 2:i32 userId, 3:OrderQueryConditions conditions)  
	 
	/* 订单详情(买卖双方)*/
	OrderDetailResult queryOrderDetail(1:i32 userType, 2:i32 userId, 3:string orderId)
	
	/*查询订单各状态数量(买卖双方)*/
	OrderStateResult orderStateQuery(1:i32 userType, 2:i32 userId, 3:OrderQueryConditions conditions)  
   
	/*
	 *  超卖订单
	 *  订单表字段 order_tag 为1  为超卖订单
	 *  订单状态为“等待发货”，表示订单没有处理
	 *  订单状态不为“等待发货”， 表示订单已经被处理过
	 OverSoldOrderProfileResult overSoldOrder(1:OverSoldQueryConditions conditions)  
	 */

	/*发起申请支付(买家)*/
	result.StringResult payApply(1:PayParam param);

	/*接收支付完成*/
	result.StringResult payFinish(1:string payRes);

	/*支付进度查询*/
	PayStateResult payState(1:PayState payState);

       /*批量导出订单(卖家中心)*/
	result.StringResult batchExportOrder(1:i32 sellerId, 2:OrderQueryConditions conditions);
	
	/*批量导出订单(管理中心)*/
	result.StringResult batchExportOrderFull(1:	OrderQueryConditions conditions);
	
	/*批量导出订单(卖家中心)*/
	result.StringResult getExportOrderResult(1:string queryKey);

       /*批量发货*/
	BatchDeliverResult batchDeliverOrder(1:i32 sellerId, 2:BatchDeliverParam param); 
	
	/*查询订单列表(管理中心)*/
	OrderProfileResult orderProfileQueryFull(1:OrderQueryConditions conditions);
	

	/* 线下订单详情(买卖双方)*/
	OrderDetailResult queryOrderDetailOffline(1:i32 userType, 2:i32 userId, 3:string orderId);

        /*查询线下订单列表(买卖双方)*/
	OrderProfileResult orderProfileQueryOffline(1:i32 userType, 2:i32 userId, 3:OrderQueryConditions conditions); 
	
	/*查询线下卖家订单列表(卖家中心)*/
	OrderProfileResult orderSellerQueryOffline(1：orderSellerQueryParam); 

}




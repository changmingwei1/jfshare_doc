
namespace java com.jfshare.finagle.thrift.thirdpay

include "result.thrift"
include "pagination.thrift"

struct ThirdPayApplyResult{
	1:result.Result result,
	2:string action,		/*登陆页面URL*/
	3:string encryptyParam, /*加密参数*/
	4:string ErrCode,  /*响应码  0000-成功，9999失败*/
	5:string ErrMsg,   /*响应消息*/
}

/*第三方支付登陆返回结果*/
struct ThirdPayLoginResult{
	1:result.Result result, /*返回结果*/
    2:i32 userId, /*用户ID*/
    3:string token, /*TOKEN*/
    4:string ppInfo, /*ppInfo*/
    5:string mobile, /*手机号*/
    6:string orderPrice /*订单价格*/
}

/*第三方支付登陆请求参数*/
struct ThirdPayLoginParam{
    1:string encryptyParam, /*加密缓存参数*/
    2:string clientType, /*客户端标识   Android:1 Ios:2  H5:3 Web:4  */
    3:string mobile, /*手机号*/
    4:string browser, /*浏览器标识*/
}

/*第三方积分抵扣请求参数*/
struct ThirdPayParam{
    1:string encryptyParam, /*加密缓存参数*/
    2:string score, /*抵扣积分*/
    3:string mobile, /*手机号*/
    4:string userId, /*用户ID*/
    
}

/*第三方积分抵扣返回结果*/
struct ThirdPayResult{
	1:result.Result result, /*返回结果*/
    2:i32 score, /*抵扣积分*/
    3:string orderId, /*订单ID*/
    4:string urlFront /*前端回调地址*/

}
/*第三方申请退款*/
struct ThirdPayRefundResult{
	1:result.Result result,
	2:string refundScore,		/*退款金额*/
	3:string orderId, /*订单号*/
	4:string ErrCode,  /*响应码  0000-成功，9999失败*/
	5:string ErrMsg,   /*响应消息*/
}

/*支付记录查询请求参数*/
struct QueryThirdPayApplyLogParam{
	1:string startTime,/*开始时间*/
	2:string endTime,/*结束时间*/
	3:string timeType, /*时间类型  1:支付时间  2：退款时间  3:请求时间*/
	4:string status, /*支付状态*/
	5:string orderId,/*商家订单号*/
	6:string thirdPayId,/*支付流水号*/
	7:string payAccount,/*支付账号*/
	8:string sellerId,/*商家ID*/
}

/*支付记录对象*/
struct ThirdPayApplyLog{
	1:i32 id,            /*主键  */                                                                                                                                       
	2:string appCode,   /*商家编码    */                                                                                                                               
	3:string spid,      /*接入业务 */                                                                                                                                  
	4:string seller_id, /*商家ID*/                                                                                                                                       
	5:string requestNo, /*请求流水*/                                                                                                                                   
	6:string order_id, /* 商家订单*/                                                                                                                                   
	7:string payContent, /*支付信息*/                                                                                                                                   
	8:string provinceNo, /* 设备省份*/                                                                                                                                   
	9:string deviceNo , /*买家设备号*/                                                                                                                                
	10:string deviceType, /*买家设备类型（电信手机：7 ， 电信固话：9，电信宽带：11，非电信设备：18，如业务无设备号，可不传入）*/
	11:string orderPrice,/*订单金额*/                                                                                                                                   
	12:string requestTime,/*请求时间 */                                                                                                                                  
	13:string accessChannel,/*接入渠道（pc端：WEB  移动端：WAP）*/                                                                                                 
	14:string urlFront,/*前端通知 */                                                                                                                                  
	15:string urlBack,/*后端通知*/                                                                                                                                   
	16:string payScore,/*消费积分金额*/                                                                                                                             
	17:string payAccount,/*支付账户*/                                                                                                                                   
	18:string user_id,/*支付账户ID*/                                                                                                                                 
	19:string payTime,/*支付时间*/                                                                                                                                   
	20:string refundTime,/*退款时间*/                                                                                                                                   
	21:string status ,/*支付状态 （-1：关闭  0：初始  1：支付失败  2：支付成功  3:返销成功  4：返销失败）*/                                         
	22:string thirdPay_id ,/*支付单号 */  	
}

/*支付记录查询返回结果*/
struct QueryThirdPayApplyLogResult{
	1:result.Result result,
    2:list<ThirdPayApplyLog> LogList,
    /* 分页信息 */
    3:pagination.Pagination pagination
}

/*导出请求参数*/
struct ExprotParam{
	1:string startTime,/*开始时间*/
	2:string endTime,/*结束时间*/
	3:string timeType, /*时间类型  1:支付时间  2：退款时间*/
	4:string status, /*支付状态*/
	5:string orderId,/*商家订单号*/
	6:string thirdPayId,/*支付流水号*/
	7:string payAccount,/*支付账号*/
	8:string sellerId,/*商家ID*/
}

/*导出返回结果*/
struct ExprotResult{
	1:string path,
	2:result.Result result,
}

/*管理中心申请退款请求参数*/
struct ManagerRefundParam {
	1:string orderId;
	2:string pwd;
}

/*管理中心申请退款*/
struct ManagerRefundResult{
	1:result.Result result,
	2:string refundScore,		/*退款金额*/
	3:string orderId, /*订单号*/
}


/*第三方订单信息返回结果*/
struct GetPayOrderInfoResult{
	1:result.Result result,
	2:string appcode,		/*商家编号*/
	3:string spid, /*接入业务*/
	4:string requestNo,		/*请求流水*/
	5:string payScore, /*抵扣积分*/
	6:string status,		/*支付状态*/
	7:string responseTime, /*返回时间*/
	8:string MsgCode,  /*响应码  0000-成功，9999失败*/
	9:string MsgContent,   /*响应消息*/
}

/*第三方支付服务*/
service ThirdPayServ {
     /*第三方申请支付请求*/
	ThirdPayApplyResult thirdPayApply(1:string requestXml);
	
	/*第三方支付登陆请求*/
	ThirdPayLoginResult thirdPayLogin(1:ThirdPayLoginParam param);
	
	/*第三方积分抵扣*/
	ThirdPayResult thirdPay(1:ThirdPayParam param);
	
	/*第三方申请退款*/
	ThirdPayRefundResult thirdPayRefund(1:string requestXml);
	
	/*查看支付记录*/
	QueryThirdPayApplyLogResult queryThirdPayApplyLog(1:QueryThirdPayApplyLogParam param, 2:pagination.Pagination pagination);
	
	/*导出支付记录*/
   	ExprotResult exprotThirdPayLog(1:ExprotParam param);
   	
   	/*管理中心申请退款*/
	ManagerRefundResult managerRefund(1:ManagerRefundParam param);
	
	/*第三方订单信息查询*/
	GetPayOrderInfoResult getPayOrderInfo(1:string requestXml);
	
	
	/*15天自动关闭支付订单*/
	result.Result confirmReceipt(1:string status, 2:string id);  
}
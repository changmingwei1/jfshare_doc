namespace java com.jfshare.finagle.thrift.pay

include "result.thrift"


stuct ThirdPayApplyResult{
	1:string action,		/*登陆页面URL*/
	2:string encryptyParam, /*加密参数*/
}
/*第三方支付服务*/
service PayServ {
     /*第三方申请支付请求*/
	result.ThirdPayApplyResult thirdPayApply(1:string requestXml);

}
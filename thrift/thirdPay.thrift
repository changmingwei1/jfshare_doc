namespace java com.jfshare.finagle.thrift.thirdpay

include "result.thrift"


struct ThirdPayApplyResult{
	1:string action,		/*登陆页面URL*/
	2:string encryptyParam, /*加密参数*/
}
/*第三方支付服务*/
service ThirdPayServ {
     /*第三方申请支付请求*/
	ThirdPayApplyResult thirdPayApply(1:string requestXml);

}
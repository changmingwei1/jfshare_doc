namespace java com.jfshare.finagle.thrift.thirdpay

include "result.thrift"

struct ThirdPayApplyResult{
	1:result.Result result,
	2:string action,		/*登陆页面URL*/
	3:string encryptyParam, /*加密参数*/
	4:string ErrCode,  /*响应码  0000-成功，9999失败*/
	5:string ErrMsg,   /*响应消息*/
}

/*第三方支付登陆返回结果*/
struct H5ThirdLoginResult{
	1:result.Result result, /*返回结果*/
    2:i32 userId, /*用户ID*/
    3:string token, /*TOKEN*/
    4:string ppInfo, /*ppInfo*/
    5:string mobile /*手机号*/
}
/*第三方支付登陆请求参数*/
struct thirdPayLoginParam{
    1:string encryptyParam, /*加密缓存参数*/
    2:string clientType, /*客户端标识   Android:1 Ios:2  H5:3 Web:4  */
    3:string mobile, /*手机号*/
    4:string browser, /*浏览器标识*/
}


/*第三方支付服务*/
service ThirdPayServ {
     /*第三方申请支付请求*/
	ThirdPayApplyResult thirdPayApply(1:string requestXml);
	
	/*第三方支付登陆请求*/
	ThirdPayLoginResult thirdPayLogin(1:thirdPayLoginParam param);

}
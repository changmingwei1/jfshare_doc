namespace java com.jfshare.finagle.thrift.pay

include "result.thrift"

/*支付方式*/
struct PayChannel {
	1:i32 payChannel,  /*支付渠道*/
	2:string payIp,  /*支付方IP地址*/
	3:string returnUrl,   /*支付完跳转url*/
	4:string custId,   /*第三方客户id*/
	5:string custType, /*第三方客户类型*/
	6:optional string procustID, /*第三方省份ID*/
}

/*支付请求参数*/
struct PayReq {
    1:string tokenId, /*支付令牌*/
    2:string orderNo,  /*请求方流水号*/
    3:string extraParam, /*请求方业务参数*/
    4:string title, /*支付标题*/
    5:i32 price, /*支付金额*/
    6:i32 score, /*支付积分*/
    7:i32 payChannel, /*支付渠道*/
    8:string payIp,   /*支付方IP地址*/
    9:string returnUrl,  /*支付完跳转url*/
    10:string remark, /*备注*/
    11:string custId, /*第三方客户id*/
    12:string custType, /*第三方客户类型*/
    13:optional string procustID, /*第三方省份ID*/
	14:optional i32 score2cashAmount, /*积分抵现部分金额*/
	15:optional i32 userId, /*聚分享用户ID*/
	16:optional string clientType /*客户端类型*/
}

/*支付返回参数*/
struct PayRes {
    1:i32 payChannel,  /*支付渠道*/
    2:string resUrl, /*支付返回结果*/
}

/*支付结果查询参数*/
struct payRetQueryParams {
	1:optional string payId
}

/*支付处理结果*/
struct PayRet {
    1:string payId,  /*本平台交易流水号*/
    2:string tokenId, /*支付令牌*/
    3:string orderNo, /*请求方流水号*/
    4:string extraParam, /*请求方业务参数*/
    5:i32 price, /*支付金额*/
    6:i32 score, /*支付积分*/
    7:i32 payChannel, /*支付渠道*/
    8:i32 retCode, /*处理状态 2:成功 3:失败*/
    9:string errMsg, /*错误描述*/
    10:i32 thirdPrice, /*第三方支付金额*/
    11:i32 thirdScore, /*第三方支付积分*/
    12:string thirdTime,  /*第三方支付通知时间*/
    13:string processTime, /*本平台处理完成时间*/
    14:string payAccount, /*支付账号*/
    15:i32 bizCode, /*支付类型: 1:付款 2:退款*/
    16:string sign, /*签名*/
}

/*支付服务*/
service PayServ {
        /*生成支付请求*/
	result.StringResult payUrl(1:PayReq payReq);

     /*接收第三方支付结果*/
	result.StringResult payNotify(1:PayRes payRes);
	
	/*接收招商一网通签名结果*/
	result.StringResult payNotifySign(1:PayRes payRes);
	
	/*支付结果查询*/
	result.StringResult queryPayResult(1:payRetQueryParams params);
}
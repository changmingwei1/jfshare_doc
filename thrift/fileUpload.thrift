namespace java com.jfshare.finagle.thrift.fileUpload

include "result.thrift"
include "pagination.thrift"

struct FileParam{

//	 server     1:string ProductName,//:			//供应商平台商品名称
//   server     2:string ProductNo ,//:				//供应商平台商品编号
//   server    7:string RealValue,//:            //卡券采购单价，单位分

         1:i32 productType; //产品类型 针对 是那种卡密产品  分为 1:2:3:4
         2:string DataType,//				//1：卡号卡密组合 2：仅有卡号 3：仅有卡密
         3:string ExpDate_Flag,//		//是否有有效期：0：有  1：没有
         4:i64    CardNumber,//:			//本文件中的点券数量
         5:string StartDate,//:				//生成本文件时间，格式YYYYMMDD
         6:string excelKeyUrl, // 上传的excel文件
         7:bool notEncryptFlag,// excel里面的数据是未加密的标志位   --默认是加密状态--
         8:bool isTestFlag,// 是否是 测试---测试情况下 这里传递的 sellerId不是准确的!!
         9:string sellerName	//商家名称,由第三方传递过来


//        server      6:string FaceValue,//:		 		//卡券面值，单位分
//   server生成      8:string orderId,// 供应商平台的订单号；若供应商平台无订单号，按照文件生成日期（YYYYMMDD）+四位序号（0001开始）的方式填写
//     server生成    9:string sellerId // 	供应商在翼支付公司的商户编号。

}

struct AuditParam{
	1:string id,	
	2:i32 type 		/*审核标识  1:成功 ; 2:失败*/
}

struct QueryConditions{
	1:string sellerName,	/*商家名称*/
	2:string productName,	/*商品名称,支持模糊查询*/
	3:i32 status	/*审核状态  0:全部 ; 1:通过 ; 2:不通过 ; 3:待审核*/
}

struct ThirdPartyCard{
	1:string id,	
	2:string orderId,	/*订单id*/
	3:string sellerName,/*供应商*/
	4:string productName,/*商品名称*/
	5:string productNo,/*商品编码*/
	6:i32 faceValue,/*卡券面值*/
	7:i32 cardNumber,/*数量*/
	8:string applyTime,/*申请审核的时间*/
	9:string approveTime,/*审核时间*/
	10:i32 status,/*审核状态*/
	11:string expData/*有效期*/
}

struct ThirdPartyCardResultList{
	1:result.Result result,
	2:list<ThirdPartyCard> thirdPartyCards,
	3:pagination.Pagination pagination
}

struct Recharge{

  	 1:i32 id,//供应商平台商品名称
  	 
     2:string orderId,//订单号
     
     3:i32 userId,//用户Id
     
     4:i32 chargeType,//充值类型:1话费 2流量
     
     5:i32 chargeChannel,//充值渠道:1瑞通特达
     
     6:i32 state1,//充值状态
     
     7:i32 state2,//充值状态（暂时未用）
     
     8:string chargeReqdate,//充值时间
     
     9:string chargeNotifydate, //回调时间
     
     10:string chargeMoney,//充值金额
     
     11:string businessCode, //业务类型:QGCZ:全国充值
     
     12:string chargeAddr, //充值号码
     
     13:string thirdOrderNo, //第三方订单号
     
     14:string blance, //充值后的代理商余额（单位:元）
     
     15:string applyTime, //交易时间
     
     16:string chargeNumblance, //充值后客户号码余额（单位:元）
     
     17:string createTime, //创建时间
     
     18:string updateTime, //更新时间
     
     19:string reqOutNo //请求第三方传给递的流水号


}

struct RechargeListResult{
	1:result.Result result,
	2:list<Recharge> recharges
}

struct NotifyRecharge{
	1:string agtPhone,
	2:string reqStreamId,
	3:string state,
	4:string sign
}

service FileForCardServ {
	
	/*接收key值,再传递给天翼*/
	result.StringResult fileToTY(1:FileParam param);
	
	/*审核:通过则传给天翼; 不通过不传*/
	result.Result auditPass(1:AuditParam param);
	
	/*查询第三方数据列表*/
	ThirdPartyCardResultList queryCardsList(1:QueryConditions conditions, 2:pagination.Pagination pagination);
	
	/*添加充值记录*/
	result.Result addRecharge(1:Recharge recharge);
	
	/*更新充值记录*/
	result.Result updateRecharge(1:Recharge recharge);
	
	/*第三方回调*/
	result.Result rechargeNotify(1:NotifyRecharge notifyRecharge);
	
	/*查询充值数据*/
	RechargeListResult rechargeList(1:list<i32> states,2:string reqOutNo);
	
	
}
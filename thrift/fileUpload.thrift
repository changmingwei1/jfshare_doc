namespace java com.jfshare.finagle.thrift.fileUpload

include "result.thrift"
include "pagination.thrift"

struct FileParam{
	 /**产品类型 针对 是那种卡密产品  分为 1:2:3:4**/
         1:i32 productType,
         2:string DataType,/**1：卡号卡密组合 2：仅有卡号 3：仅有卡密**/
         3:string ExpDate_Flag,/***否有有效期：0：有  1：没有**/
         4:i64    CardNumber,/**本文件中的点券数量**/
         5:string StartDate,/**生成本文件时间，格式YYYYMMDD**/
         6:string excelKeyUrl, /**上传的excel文件**/
         7:bool notEncryptFlag,
         8:bool isTestFlag,
         9:string sellerName
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

  	 1:i32 id,/**供应商平台商品名称**/
  	 
     2:string orderId,/**订单号**/
     
     3:i32 userId,/**用户Id**/
     
     4:i32 chargeType,/**充值类型:1话费 2流量 3Q币**/
     
     5:i32 chargeChannel,/**充值渠道:1瑞通特达 2通商宝**/
     
     6:i32 state1,/**充值状态**/
     
     7:i32 state2,/**充值状态（暂时未用）**/
     
     8:string chargeReqdate,/**充值时间**/
     
     9:string chargeNotifydate, /**回调时间**/
     
     10:string chargeMoney,/**充值金额**/
     
     11:string businessCode, /**业务类型:QGCZ:全国充值  QBCZ:Q币充值**/
     
     12:string chargeAddr, /**充值号码**/
     
     13:string thirdOrderNo,/**第三方订单号**/
     
     14:string blance, /**充值后的代理商余额（单位:元）**/
     
     15:string applyTime, /**交易时间**/
     
     16:string chargeNumblance, /**充值后客户号码余额（单位:元）**/
     
     17:string createTime, /**创建时间**/
     
     18:string updateTime, /**更新时间**/
     
     19:string reqOutNo, /**请求第三方传给递的流水号**/
     
     20:string company, /**合作商户：中国移动、中国联通、中国电信**/
     
     21:string flowno,/**流量编号对应的值**/
     /**拓展字段1**/
     22:string ext1, 
     /**拓展字段2**/
     23:string ext2,
      /**拓展字段3**/
     24:string ext3
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
/**游戏查询的参数,第三方id和游戏首字符,和游戏名字，如果都是空，默认查询首字符分类*/
struct ThirdGameParam{
	1:optional string thirdGameId,
	2:optional string firstpy,
	3:optional string name
}
struct ThirdGame{
	1:optional string thirdGameId,
	2:optional string corp,
	3:optional string code,
	4:optional string startbuy,
	5:optional string endbuy,
	6:optional string contbuy,
	7:optional i32 spacenum,
	8:optional string buyunit,
	9:optional string gameunit,
	10:optional string name,
	11:optional string needparam,
	12:optional string mprice,
	13:optional string point
}

struct ThirdGameRechargeParam{
	 1:string thirdGameId,
	 2:string account,
	 3:string gameAreaId,
	 4:string gameAreaName,
	 5:string gameServerId,
	 6:string gameServerName,
	 7:string buyNum,
	 8:string totalAmount,
	 9:string price,
	 10:string roleId,
	 11:string roleName
}

/**首字符大写的游戏分类*/
struct PYGameList{
	1:string py,
	2:list<ThirdGame> listGame
}

struct ThirdGameListResult{
	1:result.Result result,
	2:optional ThirdGame ThirdGame,
	3:optional list<PYGameList> pyThirdGameList,
	4:optional list<ThirdGame> thirdGameList
}

struct GameSeaver{
	1:string gameSeaverName,
	2:string gameSeaverId
}

struct GameArea{
	1:string gameAreaName,
	2:string gameAreaId,
	3:list<GameSeaver> gameSeaverList
}

struct GameAreaListResult{
	1:result.Result result,
	2:list<GameArea> gameAreaList
}

struct GameRoleResult{
	1:result.Result result,
	2:string roleName,
	3:string roleId
}

struct ThirdGameCallBackParam{
	1:string retcode,
	2:string username,
	3:string gameapi,
	4:string sporderid
	5:string money
	6:string sign
}

struct ThirdGameOrderParam{
	1:string orderId
} 
struct ThirdGameOrder{
	1:string orderId,
	2:string account,
	3:string state
}
struct ThirdGameOrderListResult{
	1:result.Result result,
	2:optional list<ThirdGameOrder> thirdGameOrder
}

struct MobileDic{
	1:string province,
	2:string operator
}

struct Flow{
	1:string flowCode,
	2:string flowPrice,
	3:string flowName,
	4:string operator,
	5:string type
	6:string province
	}
struct FlowResult{
	1:result.Result result,
	2:Flow flow
}

struct MobileDicResult{
	1:result.Result result,
	2:MobileDic mobileDic,
	3:list<Flow> flowList,
	4:list<Flow> localList
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
	RechargeListResult rechargeList(1:list<i32> states,2:Recharge recharge);
	/*******************************游戏充值和Q币充值***************************************************/
	/**根据游戏id和游戏名字首查询游戏**/
	ThirdGameListResult queryGameList(1:ThirdGameParam param);
	/*查詢服務器列表*/
	GameAreaListResult queryGameAreaList(1:string thirdGameId);

	/**查询用户角色**/
	GameRoleResult queryGameRole(1:string account,2:string gamearea,3:string gameserver,4:string thirdGameId);

	/****验证充值时候的游戏参数******/
	result.Result validateRechargeGame(1:ThirdGameRechargeParam params);
	
	/***********根据订单id查询游戏充值结果***********/
	ThirdGameOrderListResult queryOrderList(1:ThirdGameOrderParam params);

	/********游戏充值回调方法***************/
	result.Result callBackGame(ThirdGameCallBackParam params);

	/*************************流量充值************************************/
	/******流量充值，查询手机号归属地*****/
	MobileDicResult queryMobileDic(1:string mobile);
	
	/**************流量回调地址***************/
	result.Result callBackFlow(1:string orderNo,2:string cstmOrderNo,3:string status,4:string msg);
	/*********查询流量配置信息***************/
	FlowResult queryFolwInfo(1:Flow flow);
}
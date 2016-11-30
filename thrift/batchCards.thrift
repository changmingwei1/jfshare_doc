namespace java com.jfshare.finagle.thrift.card

include "result.thrift"
include "pagination.thrift"

/*批次活动表*/
struct BatchActivity {
        1:i32 id,
        2:string name,
        3:string pieceValue,
        4:i32 totalCount,
        5:string rechargeType,
        6:string createTime,
        7:string startTime,
        8:string endTime,
        9:string curStatus,
        10:string password,
        11:string multiRechargeEnable,
		12:i32 UsedCount,
		13:i32 SendCount,
		14:string channel,

}

/* 积分卡表*/
struct BatchCardRecord {
    1:i32 id,
    2:i32 activityId,
    3:string cardName,
    4:string cardPsd,
    5:string sendStatus,
    6:string rechargeStatus,
    7:string rechargeAccount,
    8:string rechargeTime;

}

/* 充值记录表*/
struct BatchRechargeCardRecord {
    1:i32 id;
    2:i32 activityId;
    3:string cardName,
    4:i32 pieceValue,
    5:string rechargeType,
    6:i32 userId,
    7:string rechargeTime;

}
/*  ------------------------------------------------------------------------------ */

/*  批次活动查询参数*/
struct ActivityQueryParam {
       1:optional string name,
       2:optional string minPieceValue,
       3:optional string maxPieceValue,
       4:optional string minStartTime,
       5:optional string maxStartTime,
       6:optional string minEndTime,
       7:optional string maxEndTime,
       8:optional string curStatus;

}
/**  单件产品的结果集*/
struct ActivityResult {
      1:result.Result result,
      2:optional BatchActivity activity
}

/**  多件产品的结果集*/
struct ActivityBatchResult {
	1:result.Result result,
	2:list<BatchActivity> activityList,
	3:pagination.Pagination pagination
}




/*  单个批次活动的卡片的查询参数
*   针对单个活动
* */
struct CardQueryParam {
          1:optional string cardName,
          2:optional string cardPsd,
          3:optional string sendStatus,
          4:optional string rechargeStatus,
          5:optional string rechargeAccount;


}
/**  单充值卡的结果集*/
struct CardResult {
      1:result.Result result,
      2:optional BatchCardRecord card
}

/**  多件充值卡的结果集*/
struct CardBatchResult {
	1:result.Result result,
	2:list<BatchCardRecord> cardList
	3:pagination.Pagination pagination
}

/*  单个批次活动充值记录的查询参数
*   针对单个活动
* */
struct CardRechargeCardParam {
            1:optional i32 cardId,
            2:optional i32 pieceValue,
            3:optional string rechargeType,
            4:optional i32 userId,
            5:optional string rechargeTime;

}
/**  单件充值卡记录*/
struct CardRecordResult {
      1:result.Result result,
      2:optional BatchRechargeCardRecord rechargeCardRecord
}

/**  多个充值卡的结果集*/
struct CardRecordBatchResult {
	1:result.Result result,
	2:list<BatchRechargeCardRecord> rechargeCardRecordList
	3:pagination.Pagination pagination
}

/**   导出 excel */
struct ExcelExportResult {
      1:result.Result result,
      2:string path;
}

/**   作废当前有用的批次活动 */
struct InvalidOneActivityResult {
      1:result.Result result,
      2:string path;
}





/* 创建单个批次活动的实体  */
struct ActivityBean {
        1:string name,
        2:string pieceValue,
        3:i32 totalCount,
        /** 充值方式：0手动 1自动 */
        4:string rechargeType,
        5:string startTime,
        6:string endTime,
        /** 状态：0可用 1作废 2过期 */
        7:string curStatus,
        8:string password,
        9:string multiRechargeEnable,
        10:optional string channel   /*添加渠道字段*/

}

/*web充值积分参数*/
struct RechargeParam{
	1:string cardName,	/*卡号*/
	2:string cardPsd,	/*卡密*/
	3:i32 userId		/*用户id*/
}

/**   定向充值结果 */
struct DirectRechargeResult {
      1:result.Result result,
      2:i32 sucessNum; /*成功条数*/
      3:i32 failedNum;/*失败条数*/
}
/**  定向充值参数 */
struct ToRechargeParams {
      1:string validataStr; /*定向充值密码*/
      2:string filePath; /*文件路径*/
      3:string activityId; /*活动Id*/
}


/*红包活动表*/
struct Activity {
           1:i32      id,
           2:string   activitySerial,
           3:string   type,
           4:string   name,
           5:i32      maxScore,
           6:string   createTime,
           7:string   startTime,
           8:string   endTime,
           9:i32      status,
           10:i32     isShowRule,
           11:i32     isShowRecord,
           12:string  brief,
           13:i32     singleGetType,
           14:string  singleGetValue,
           15:i32     perLimitTime,
           16:i32     perDayTime,
           17:i32     partakeType,
           18:string  registStartTime,
           19:string  registEndTime,
           20:i32     isH5,
           21:i32     operatorUserId,
           22:string  configure,
	   23:optional i32 sendScore,
	   24:optional i32 count,
	   25:optional string realEndTime

}


/**  红包结果集*/
struct ActivityListResult {
	1:result.Result result,
	2:list<Activity> activityList,
	3:pagination.Pagination pagination
}
/**  红包单个 实体*/
struct ActivityRedPaperResult {
	1:result.Result result,
	2:optional Activity entity,
}


/* 红包记录表*/
struct ReceiveRecoard {
       1:i32    id,
       2:string    activityId,
       3:string activityName,
       4:i32    score,
       5:i32    userId,
       6:string userPhone,
       7:string hitTime,
}
/* 红包记录表 查询条件*/
struct QueryParam4Record {
       1:i32    id,
       2:string    userPhone,
       3:string startTime,
       4:string endTime,
}

/**  红包结果集*/
struct ReceiveRecoardListResult {
	1:result.Result result,
	2:list<ReceiveRecoard> activityList,
	3:pagination.Pagination pagination
}
/**  红包活动列表查询条件*/
struct RedPaperActivityQueryParam {
       1:optional string name,
       2:optional string minStartTime,
       3:optional string maxStartTime,
       4:optional string minEndTime,
       5:optional string maxEndTime,
       6:optional string curStatus
}

/**  红包发放记录查询条件*/
struct RedPaperSendQueryParam {
       1:optional string mobile,
       2:optional string sendMinStartTime,
       3:optional string snedMaxStartTime
}
/**   导出 excel */
struct Result4Excel {
      1:result.Result result,
      2:string path;
}
/**   生成H5链接参数 */
struct GenerateParam {
      1:string activityId;
}



/**积分卡统计查询条件*/
struct ActivityStatisticParam {
       1:optional string channel,
       2:optional string startTime,
       3:optional string endTime,
}




/**积分卡导出条件*/
struct ExprotParam {
       1:optional string channel,
       2:optional string startTime,
       3:optional string endTime,
}


/*积分卡统计对象*/
struct ActivityStatistic {
        1:string createTime,/*时间*/
        2:string pieceValue,/*面值 */
        3:i32 sumTotalCount,/*总张数 */
		4:string channel,/*渠道*/
		5:i32 sumAmount,/*面值积分额*/
		
}

/** 积分卡统计返回结果*/
struct ActivityStatisticResult{
	1:result.Result result,
	2:list<ActivityStatistic> activityStatisticList,
	3:pagination.Pagination pagination,
	4:i32 sumScore
}

/*导出返回结果*/
struct ExprotResult{
	1:string path,
	2:result.Result result,
}

/* 积分卡 功能*/
service ScoreCardServ {

		    /**  创建批次活动 */
		    ActivityResult  createOneActivity(1:ActivityBean entity);
		
			/*查询 批次产品*/
			ActivityBatchResult queryActivities(1:ActivityQueryParam param,2:pagination.Pagination pagination);
		
			/*查询单件批次产品*/
			ActivityResult queryActivityById(1:i32  activityId);
		
			/*查询某个活动下面所有卡片  */
			CardBatchResult queryCards(1:i32  activityId,2:CardQueryParam param,  3:pagination.Pagination pagination);
		
			/*查询根据id 的卡片记录*/
			CardResult queryCardById(1:i32  cardId);
		
			/*查询某个活动卡 充值记录 */
			CardRecordBatchResult queryRechargeCards(1:i32  userId, 2:pagination.Pagination pagination);
		
			/*查询根据id 的已充值的卡片记录*/
			CardRecordResult queryRechargeCardById(1:i32  rechargeCardId);
		
		    /* 导出 卡号和卡密 的excel  不进行分页 */
			ExcelExportResult exportExcelByqueryCards(1:i32  activityId,2:CardQueryParam param,3:string psd);
		
			/*web主站--积分充值*/
			result.StringResult recharge(1:RechargeParam param);
			
			
	        /*密码验证*/
	      result.Result validataPassword(1:string validataStr);
	  
	      /*定向充值*/
	      DirectRechargeResult directRecharge(1:ToRechargeParams params);
	
	      /*  作废一个有效批次活动*/
	      InvalidOneActivityResult invalidOneActivity(1:i32  activityId,2:string psd);




            /*新增红包活动*/
            result.Result createRedPaperActivity(1:Activity activity, 2:i32 userId);	/*userId:管理员id*/

        	/*编辑红包活动*/
        	result.Result updateRedPaperActivity(1:Activity activity, 2:i32 userId);	/*userId:管理员id*/

        	/*作废红包活动*/
        	result.Result invalidRedPaperActivity(1:string activityId, 2:i32 userId);		/*userId:管理员id*/

        	/*查询单个红包活动--管理中心用 */
        	ActivityRedPaperResult queryOneRedPaperActivity(1:i32 activityId);
        	
        	/*查询单个红包活动 --前端*/
        	ActivityRedPaperResult queryRedPaperActivity(1:string encryActivityId);

        	/*查询红包活动列表*/
        	ActivityListResult queryRedPaperActivityList(1:RedPaperActivityQueryParam queryParam, 2:pagination.Pagination pagination);

        	/*查询领取列表--管理中心*/
        	ReceiveRecoardListResult queryRedPaperReceivedList(1:string activityId,2:RedPaperSendQueryParam sendQueryParam, 3:pagination.Pagination pagination);

			/*查询领取列表--前端*/
        	ReceiveRecoardListResult getRedPaperReceivedList(1:string encryActivityId,2:RedPaperSendQueryParam sendQueryParam, 3:pagination.Pagination pagination);

        	/*导出领取列表*/
        	Result4Excel exportRedPaperExcelForReceived(1:i32 activityId, 2:QueryParam4Record params);

        	/*生成H5页面链接*/
        	result.StringResult generateH5Url(1:GenerateParam param);

        	/*领取红包*/
        	result.StringResult receiveRedbag(1:string encryActivityId, 2:string mobile);
			
			/*积分卡统计*/
			ActivityStatisticResult activityStatistic(1:ActivityStatisticParam param,2:pagination.Pagination pagination);
			
			/*积分卡统计导出*/
   			ExprotResult exprotActivityStatistic(1:ExprotParam param);
			
}
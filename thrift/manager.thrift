namespace java com.jfshare.finagle.thrift.manager

include "slotImage.thrift"
include "result.thrift"

struct ProductOpt {

	/*商品id*/
	1:string productId,
	
	/*修改后的商品状态*/
	2:i32 activeState,
	
	/*原因或内容描述*/
	3:optional string desc,
	
	/*操作员id， 卖家-sellerId, 管理员-managerId*/
	4:string operatorId,
	
	/*1-卖家， 2-管理员， 3-系统*/
	5:i32 operatorType,
	
	6:optional string createTime
}

/*订单查询条件*/
struct QueryConditions{

	/*商品ID*/
	1: string productId,          

	/*记录条数*/
	2: i32 recordCount,          

	/*商品状态*/
	3: i32 state
}


struct ProductOptResult{
	1:result.Result result,
	2:list<ProductOpt> productOptRecords
}

struct Commissioner {
    1:i32 csId,
    2:string loginName,
    3:string csName,
	4:string pwdEnc
}

/*登陆请求参数*/
struct LoginLog {
    1:i32 csId,
    2:string tokenId, /*令牌标识*/
    3:string ip,
    4:string browser, /*浏览器标识*/
    5:i32 fromSource, /*终端标识*/
    6:i32 loginAuto, /*是否自动登录*/
    7:string loginTime,
    8:string logoutTime,
}

struct CommissionerResult {
      1:result.Result result,
      2:optional Commissioner cs,
	  3:LoginLog loginLog,
	  4:optional bool value,
}

struct ModuleConfig{
	1:string id,
	2:string moduleName,/*模块名称*/
	3:string moduleDesc,/*模块描述*/
	4:string moduleType,/*模块类型  1:商品  2：品牌*/
	5:string create_time,/*创建时间*/
	6:string relaseChannel,/*发布渠道  app：移动端      h5：H5端      web:PC端*/
	7:string relaseStatus,/*发布状态*/
}

/*模块配置返回结果*/
struct ModuleConfigResult{
	1:result.Result result,
	2:list<ModuleConfig> moduleConfigList
}

/*模块配置请求参数*/
struct ModuleConfigParam{
	1:string moduleName,/*模块名称*/
	2:string moduleType,/*模块类型  1:商品  2：品牌*/
	3:string create_time,/*创建时间*/
	4:string relaseStatus,/*发布状态  0：未发布 1：已发布*/
	5:string relaseChannel,/*发布渠道  app：移动端      h5：H5端      web:PC端*/
}

struct ModuleConfigDetail{
	1:string id,/*序号*/
	2:string moduleId,/*模块ID*/
	3:string createTime,/*创建时间*/
	4:string relaId,/*关联ID*/
	5:string relaImgkey,/*关联图片*/
	6:string productRuleId,/*商品规则ID*/
	7:string relaSort,/*位置排序号*/
	8:string updateTime,/*更新时间*/	
}

/*模块配置明细返回结果*/
struct ModuleConfigDetailResult{
	1:result.Result result,
	2:list<ModuleConfigDetail> ModuleConfigDetailList
	
}

/*模块配置明细请求参数*/
struct ModuleConfigDetailParam{
	1:string moduleId,/*模块ID*/
	2:string createTime,/*创建时间*/
	3:string relaId,/*关联ID*/
	4:string relaImgkey,/*关联图片*/
	5:string productRuleId,/*商品规则ID*/
	6:string relaSort,/*位置排序号*/
}

/*发布返回结果*/
struct relaseResult{
      1:result.Result result,
	  2:string type,/*发布类型*/
	  3:string relaseCount,/*发布图片数量*/
}

/*发布请求参数*/
struct relaseParam{
    1:list<ModuleConfigDetail> ModuleConfigDetailList
}

/*====================================================原有的不动====================================================*/


struct AdvertSlotImage{
	1:i32 id,
	2:string imgKey,	/*图片key*/
	3:i32 advertId,		/*广告位id, H5&APP or PC or OTHERS*/
	4:string slotName,	/*广告位名称*/
	5:string remark,	/*广告位描述*/
	6:string jump,		/*跳转地址链接*/
	7:i32 isOnline,		/*状态,是否在线  1:在线 2:不在线*/
	8:i32 sort,			/*排序标识*/
	9:string startTime,	/*上线时间*/
	10:string endTime,	/*下线时间*/
	11:string createTime/*创建时间*/
}

struct AdvertSlot{
	1:i32 advertId,
	2:string slotName,
	3:i32 count,
	4:string createTime,
	5:string type
}

struct AdvertSlotImageParam{
	1:i32 advertId,
	2:i32 fromSource, 	/* 1前端 2管理中心,在node层去管理,前端不用传 */
	3:i32 type			/* 1主站 2APP&H5,需要相应端口传参*/
}

struct AdvertSlotImageListResult{
    1:result.Result result,
	2:optional list<AdvertSlotImage> slotImageList
}

struct AdvertSlotImageResult{
    1:result.Result result,
	2:optional AdvertSlotImage slotImage
}

struct AdvertSlotImageListParam{
	1:list<AdvertSlotImage> slotImageList,
	2:i32 advertId
}

struct AdvertSlotListResult{
	1:result.Result result,
	2:list<AdvertSlot> slotList
}

/*service*/
service ManagerServ{
	/*记录变更商品状态变更日志*/
	result.Result logProductOpt(1:ProductOpt productOpt)
	
	/*查询商品状态变更日志*/
	ProductOptResult queryProductOptRecords(1:QueryConditions conditions)
	
	/*查询登录名是否存在*/
    result.BoolResult isLoginNameExist(1:string loginName);

    /*注册*/
    result.Result signup(1:Commissioner cs);

    /*登陆*/
    CommissionerResult signin(1:Commissioner cs, 2:LoginLog loginLog);

    /*注销*/
    result.Result signout(1:LoginLog loginLog);

    /*是否登陆*/
    CommissionerResult isOnline(1:LoginLog loginLog);
	
	/* 保存广告图片 */
	result.StringResult saveSlotImage(1:slotImage.SlotImage slotImage);
	
	/* 修改广告图片 */
	result.StringResult updateSlotImage(1:slotImage.SlotImage slotImage);
	
	/* 查询广告图片列表 */
	slotImage.QuerySlotImageResult querySlotImageList(1:slotImage.QuerySlotImageParam querySlotImageParam);
	
	/* 查询广告图 */
	slotImage.QuerySlotImageResult querySlotImageOne(1:i32 id);
	
	/* 查询模块 */
	ModuleConfigResult  queryModuleConfig(ModuleConfigParam param);
	
	/* 查询模块配置明细*/
	ModuleConfigDetailResult  queryModuleConfigDetail(ModuleConfigDetailParam param);
	
	/*发布模块*/
	relaseResult relase(relaseParam param);
	
	/*====================================================原有的不动====================================================*/
	
	/* 保存广告位图片 */
	result.Result saveAdvertSlotImage(1:AdvertSlotImage slotImage);
	
	/* 修改广告位图片 */
	result.Result updateAdvertSlotImage(1:AdvertSlotImage slotImage);
	
	/* 查询广告位图片列表 -- 前端/管理中心 */
	AdvertSlotImageListResult queryAdvertSlotImageList(1:AdvertSlotImageParam param);
	
	/* 查询广告位图片 */
	AdvertSlotImageResult queryAdvertSlotImage(1:AdvertSlotImage slotImage);
	
	/*删除广告位图片*/
	result.Result deleteAdvertSlotImage(1:AdvertSlotImage slotImage);
	
	/*统一发布图片*/
	result.Result publishAdvertSlot(1:AdvertSlotImageListParam param);
	
	/*查询各端轮播图列表*/
	AdvertSlotListResult queryAdvertSlotList();
}
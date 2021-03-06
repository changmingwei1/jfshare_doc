namespace java com.jfshare.finagle.thrift.product

include "result.thrift"
include "pagination.thrift"

/*商品sku项*/
struct ProductSkuItem {
    1:optional string sellerClassNum,
    2:optional string shelf, 
    3:optional string curPrice,
    4:optional string orgPrice,
    5:optional string vPicture,
    6:optional string skuName,
    /* 重量 单位：kg*/
    7:optional string weight,
    /* 参考售价 */
    8:optional string refPrice,
    /* 仓库ID */
    9:optional i32 storehouseId,
    /* sku编码 */
    10:optional string skuNum;
}

/*商品sku*/
struct ProductSku {
 /*  1:optional map<string, ProductSkuItem> productSkuMap, K-V:skunum-ProductSkuItem*/
     1:optional list<ProductSkuItem> skuItems,
     /**sku总**/
     2:optional string sellerClassNum,    /*商家填写的sku编码*/
     3:optional string shelf,    /*货架*/
     4:optional string curPrice,      
     5:optional string orgPrice,         
     6:optional string  minCurPrice,
     7:optional string  maxCurPrice,
     8:optional string  minOrgPrice,
     9:optional string  maxOrgPrice,
     10:optional string vPicture, /*sku图片*/
     11:optional string skuName,
     12:optional string skuNum,
     /* 参考售价 */
     13:optional string refPrice

}

struct ProductSkuResult{
     1:result.Result result,
     2:optional ProductSku productSku,
}

struct Product {
	1:string productId,	
	2:optional i32 sellerId,
	3:optional string productName,		
	4:optional string viceName,
	5:optional i32 subjectId,
	6:optional i32 brandId,
	7:optional string imgKey=",,,,,",
	8:optional string detailKey,
	9:optional i32 maxBuyLimit,	
	10:optional i32 activeState,
	/* 1.积分现金够的商品,2.普通商品,3.虚拟商品 */
	11:optional i32 type,
	12:optional string remark,

	13:optional string createTime,
	14:optional i32 createUserId,	
	15:optional string lastUpdateTime,
	16:optional i32 lastUpdateId,

        /**大字段BLOB**/
	17:optional string skuTemplate,
	18:optional string attribute,

	19:optional ProductSku productSku,  /*商品sku信息*/
	20:optional string productUrl,
    21:optional string tags,    /*商品关键字，空格分隔*/
	22:optional string detailContent /*商品详情内容*/
    23:optional string productSnapshootId,

    /* 仓库， 可以存多个，多个以英文 “,” 隔开*/
    24:optional string storehouseIds,
    /* 邮费模板ID */
    25:optional i32 postageId,
    /* 第三方积分抵现比率 如:10，1分抵10分钱*/
    26:optional string thirdExchangeRate,

	/* 第三方商家标识  1：我买网 */
	27:optional i32 thirdPartyIdentify,
	/* 第三方商品ID */
	28:optional string thirdPartyProductId
	

}

struct ProductResult {
      1:result.Result result,
      2:optional Product product
}

struct ProductBatchListResult {
      1:result.Result result,
      2:optional list<Product> productList
}

struct ProductBatchResult {
	1:result.Result result,
	2:list<Product> productList
}

struct ProductDetailParam {
  1:optional string detailKey,  /*优先依赖detailKey查询*/
  2:optional string productId
}

/*需要查询出的粒度，0:不需要此信息,1:需要此信息*/
struct ProductRetParam {
	1:i32 baseTag, /*商品基础信息*/	
	2:i32 skuTemplateTag, /*商品选中sku模板*/
	3:i32 skuTag,  /*商品sku信息*/	
	4:i32 attributeTag /*商品属性信息*/
}

/* 商品概要 */
struct ProductSurvey {
	1:string productId,	
	2:string productName,
	3:i32 subjectId,
	4:i32 brandId,   
	5:string minOrgPrice,  
	6:string minCurPrice,         
	7:i32 activeStock,
	8:i32 totalSales, 
	9:i32 activeState,
	10:string imgUrl,
	11:optional string viceName,
	12:optional string createTime,
	13:optional i32 sellerId,
	14:optional i32 type,
	15:optional i64 clickRate,
	/* 仓库， 可以存多个，多个以英文 “,” 隔开*/
	16:optional string storehouseIds,
	/* 邮费模板ID */
	17:optional i32 postageId,
	18:optional string maxOrgPrice,
	19:optional string maxCurPrice,
	20:optional string sellerName,
	21:optional string subjectPath
}

/* 主页搜索的结果*/
struct ProductSearch {
	1:string productId,	
	2:string productName,
	3:i32 subjectId,
	4:i32 brandId,   
	5:string maxOrgPrice,  
	6:string maxCurPrice,         
	7:i32 activeStock,
	8:i32 totalSales, 
	9:i32 activeState,
	10:string imgUrl,
	11:optional string viceName,
	12:optional string createTime,
	13:optional i32 sellerId,
	14:optional i32 type,
	15:optional i64 clickRate,
	/* 仓库， 可以存多个，多个以英文 “,” 隔开*/
	16:optional string storehouseIds,
	/* 邮费模板ID */
	17:optional i32 postageId,
	18:optional string minOrgPrice,
	19:optional string minCurPrice
}
/*主页搜索的参数*/
struct ProductSearchParam {
/* 排序： 1:按创建时间降序   2:按现价降序   3:按现价升序  4:按点击量降序*/
	1:i32 type,
	2:string keyword,
	3:pagination.Pagination pagination
}
/*主页搜索的结果集**/
struct ProductSearchResult {
      1:result.Result result,
      2:optional pagination.Pagination pagination,
      3:optional list<ProductSearch> productSearchList
}


struct ProductSurveyQueryParam {
	1:i32 sellerId,
    2:optional string productId,
	3:optional string productName,       
	4:optional i32 activeState,
	5:optional pagination.Pagination pagination,
	/* 排序： create_time DESC:按创建时间降序   cur_price DESC:按现价降序   cur_price ASC:按现价升序  click_rate DESC:按点击量降序 */
	6:optional string sort,
	7:optional i32 subjectId,
	8:optional i32 brandId,
	9:optional list<i32> subjectIdList,
	10:optional list<string> productIdList,
	11:optional string exprotPassword
}


struct ProductSurveyQueryBatchParam {
	1:list<string> productIds,
	2:i32 fromType
}

/* 获取sku参数 */
struct ProductSkuParam {
	/* 商品ID */
	1:string productId,
	/* 商品sku编码 */
	2:string skuNum,
	/* 仓库ID */
    3:i32 storehouseId,
}

/* 批量获取sku参数 */
struct ProductSkuBatchParam {
	1:list<ProductSkuParam> productSkuParams
}

struct ProductSurveyResult {
      1:result.Result result,
      2:optional pagination.Pagination pagination,
      3:optional list<ProductSurvey> productSurveyList
}

struct ProductCard {
	/* 卖家ID */
	1:i32 sellerId,
	/* 商品ID */
	2:string productId,
	/* 卡号 */
	3:string cardNumber,
	/* 密码 */
	4:string password,
	/* 商品sku编码 */
	5:string skuNum,
	/* 买家ID */
    6:optional i32 buyerId,
    /* 验证时间 */
    7:optional string checkTime
}

struct ProductCardView {
	/* 商品ID */
	1:string productId,
	/* 卡号 */
	2:string cardNumber,
	/* 密码 */
	3:string password,
	/* 是否已发放  1：未发放 2：已发放 3：已使用 */
	4:i32 state,
	/* 商品sku编码 */
	5:string skuNum,
	/*发放账号*/
	6:optional string sendAccount,
	/*发放时间*/
	7:optional string sendTime,
	/**验证时间**/
	8:optional string validateTime
}

struct ProductCardViewParam {
	/* 卖家ID */
	1:i32 sellerId,
	/* 商品ID */
	2:string productId,
	/* 卡号（虚拟商品序列号） */
	3:string cardNumber,
	/* 是否已发放  0：全部  1：未发放 2：已发放 3：已使用 */
	4:i32 state,
	/* 商品sku编码 */
	5:string skuNum,
	/*发放开始时间*/
	6:optional string sendBeginTime,
	/**发放结束时间**/
	7:optional string sendEndTime,
	/*验证开始时间*/
	8:optional string validateBeginTime,
	/*验证结束时间*/
	9:optional string validateEndTime,
	/**发放账号*/
	10:optional string sendAccount,
	11:optional string exportPassword
}

struct ProductCardStatistics {
	1:string productId,
	2:string productName,
	/* 总数量 */
	3:i32 total,
	/* 未发放数量 */
	4:i32 usedNum,
	/* 已发放数量 */
	5:i32 unusedNum,
	/* 导入时间 */
	6:string createTime
	/* 商品sku编码 */
	7:string skuNum,
	8:optional string sendNum,
	9:optional string checkedNum,
	10:optional string skuName
}

struct ProductCardStatisticsParam {
	1:i32 sellerId,
	2:string productName
}

struct ProductCardSkuStatisticsParam {
	1:i32 sellerId,
	2:string productId
}

struct ProductCardParam {
    /* 商品ID */
	1:string productId,
	/* 交易唯一标识 */
	2:string transactionId,
	/* 获取卡密个数 */
	3:i32 num,
	/* 商品sku编码 */
	4:string skuNum,
	/* 买家ID */
	5:optional i32 buyerId,
	/*标志位 1表示第三方的卡密**/
	6:optional i32 flag
}

struct ProductCardImportParam {
    /* 卖家ID */
	1:i32 sellerId,
	/* 文件路径 */
	2:string path,
	/* 商品ID，用于验证 */
	3:string productId
}

struct ProductCardResult {
	1:result.Result result,
	2:list<ProductCard> cardList
}

struct ProductCardViewListResult {
	1:result.Result result,
	2:list<ProductCardView> cardViewList,
	3:pagination.Pagination pagination
}

struct ProductCardStatisticsResult {
	1:result.Result result,
	2:list<ProductCardStatistics> cardtatisticsList,
	3:pagination.Pagination pagination
}

struct ProductOpt {

	1:string productId,

	/*修改前的商品状态*/
	2:i32 curState,

	/*修改后的商品状态*/
	3:i32 activeState,

	/*原因或内容描述*/
	4:optional string desc,

	/*操作员id， 卖家-sellerId, 管理员-managerId*/
	5:string operatorId,

	/*1-卖家， 2-管理员， 3-系统*/
	6:i32 operatorType,

	/*创建时间*/
	7:optional string createTime
}

struct CaptchaQueryParam {
	/*买家id*/
	1:i32 sellerId,
	/*分页条件*/
	2:pagination.Pagination pagination,
	
	/*查询月份 格式:yyyy-MM*/
	3:optional string monthQuery,
	/*商品id*/
	4:optional string productId
}

struct CaptchaDayQueryParam {
	/*买家id*/
	1:i32 sellerId,
	/*分页条件*/
	2:pagination.Pagination pagination,
	
	/*查询日期 格式:yyyy-MM-dd */
	3:optional string date
}

struct AldCaptchaItem {
	/*商品id*/
	1:string productId,
	/*商品名称*/
	2:string productName,
	/*已销售*/
	3:i32 aldSold,
	/*已验证*/
	4:i32 aldCaptcha
}

struct DayAldCaptchaCount {
	/* 日期 */
	1:string date,
	/* 验证总数 */
	2:i32 checkedTotalNum
}

struct DayAldCaptchaItem {
	/*商品id*/
	1:string productId,
	/*商品名称*/
	2:string productName,
	/*已销售*/
	3:i32 aldSold,
	/*已验证*/
	4:i32 aldCaptcha,
	/*日期*/
	5:string date
}

struct CaptchaListResult {
	1:result.Result result,
	2:i32 yedNum,
	3:i32 monNum,
	4:pagination.Pagination pagination,
	5:list<AldCaptchaItem> itemList
}


struct DayCaptchaListResult {
	1:result.Result result,
	/*当月销售总数*/
	2:i32 soldNum,
	/*当月验证总数*/
	3:i32 checkedNum,
	4:pagination.Pagination pagination,
	5:list<DayAldCaptchaCount> dayAldCaptchaCountList
}

struct DayCaptchaProductResult {
	1:result.Result result,
	2:pagination.Pagination pagination,
	3:list<DayAldCaptchaItem> itemList
}

struct CaptchaDetailResult{
	1:result.Result result,
	2:string productName,
	3:list<ProductCard> productCards,
	4:pagination.Pagination pagination
	
}

/*========================== 第三方商品相关结构 ===========================*/

struct ThirdPartyProductQueryParam{
	/* 第三方商家标识 0：全部， 1：我买网 */
	1:i32 thirdPartyIdentify,
	/* 商品名称 */
	2:string productName,
	/* 商品状态 0：全部， 300：在售， 101：下架 */
	3:i32 activeState,
	/* 商品库存 0：全部， 1：全区有货， 2：部分缺货， 3：全区缺货 */
	4:i32 stockState,
	/* 价格变化 0：全部， 1：上升， 2：下降， 3：持平 */
	5:i32 priceState,
	/* 提报状态 0：全部， 1：已提报， 2：未提报 */
	6:i32 offerState,
	7:optional string productId
}

struct ThirdPartyProduct{
    /* 聚分享商品ID */
	1:string productId,
	/* 第三方商品ID */
	2:string thirdPartyProductId,
	/* 第三方商家标识  1：我买网 */
	3:i32 thirdPartyIdentify,
	/* 商品名称 */
	4:string name,
	/* 商品图片 */
	5:string imgKey,
	/* 商品商家编码 */
	6:string sellerClassNum,
	/* 结算价 */
	7:string curPrice,
	/* 价格变化 1：上升， 2：下降， 3：持平 */
	8:i32 priceState,
	/* 库存，json格式 {"华北":1520,"华东":2548,"华南":1426} */
	9:string stockInfo,
	/* 商品状态 300：在售， 101：下架 */
	10:i32 activeState,
	/* 提报状态 1：已提报， 2：未提报 */
	11:i32 offerState,
	/* 更新时间 */
	12:string updateTime
}

struct ThirdPartyProductQueryResult{
	1:result.Result result,
	2:list<ThirdPartyProduct> thirdPartyProductList,
	3:pagination.Pagination pagination
	
}


struct ThirdPartyProductLog{
	/* 商品状态 1：在售， 2：下架 */
	1:i32 productState,
	/* 结算价 */
	2:string curPrice,
	/* 更新时间 */
	3:string updateTime
}

struct ThirdPartyProductLogParam{
    /* 第三方商家标识  1：我买网 */
    1:i32 thirdPartyIdentify,
	/* 第三方商品ID */
	2:string thirdPartyProductId
}

struct ThirdPartyProductLogResult {
	1:result.Result result,
	2:list<ThirdPartyProductLog> logs,
	3:pagination.Pagination pagination
}
 /* 验码记录查询参数*/
struct CheckCodeListParam{
	 /* 发放账号 */
	1:optional string sendAccount,
	2:optional string checkBeginTime,
	3:optional string checkEndTime,
	4:optional string sellerId,
	5:optional string sellerName,
	6:optional string productId,
	7:optional string productName,


}

struct CheckCode{
	1:string sellerId,
	2:string sellerName,
	3:string productId,
	4:string productName,
	5:string skuNum,
	6:string skuName,
	7:string cardName,
	8:string password,
	9:string sendAccount,
	10:string checkTime
}

struct CheckCodeListResult{
	1:result.Result result,
	2:list<CheckCode> checkCodeList,
	3:pagination.Pagination pagination
}

struct QueryBatchProductParam{
	1:list<string> idList
}

/*商品基本信息*/
service ProductServ {
	/*查询商品*/
	ProductResult queryProduct(1:string productId, 2:ProductRetParam param);

	/*查询商品批量*/
	ProductBatchListResult queryBatchProduct(1:QueryBatchProductParam queryBatchProductParam, 2:ProductRetParam productRetParam);

	/*查询商品sku*/
	ProductSkuResult queryProductSku(1:string productId);

	/*查询商品指定sku 不用了 */
	ProductResult queryHotSKU(1:string productId, 2:string skuNum, 3:ProductRetParam param);

	/*查询商品指定sku*/
	ProductResult queryHotSKUV1(1:ProductSkuParam skuParam, 2:ProductRetParam param);
	
	/* 批量获取指定sku */
	ProductBatchResult queryHotSKUBatch(1:ProductSkuBatchParam skuParam, 2:ProductRetParam param);

	/*查询商品详情*/
	result.StringResult queryProductDetail(1:ProductDetailParam param);

	/*创建商品，返回商品ID*/
	result.StringResult addProduct(1:Product product);

	/*修改商品，返回商品ID*/
	result.StringResult updateProduct(1:Product product);

	/* 商品概要信息列表查询*/
	ProductSurveyResult productSurveyQuery(1:ProductSurveyQueryParam param);

	/* 商品搜索---主站--从es中去*/
	ProductSearchResult searchProduct(1:ProductSearchParam param);


	/* 按点击量查询商品列表 不用了 */
	ProductSurveyResult productSurveyQueryByClick(1:ProductSurveyQueryParam param);

	/* 管理后台查询商品概要信息列表查询*/
	ProductSurveyResult productSurveyBackendQuery(1:ProductSurveyQueryParam param);

	/*修改商品状态*/
	result.Result setProductState(1:ProductOpt productOpt);

	/* 首页楼层商品列表 */
	ProductSurveyResult queryFloorProduct(1:i32 floorId);

	/*查询商品快照*/
	ProductResult  queryProductSnap(1:string snapId, 2:ProductRetParam param);

	/*根据商品id批量查询 param.fromType=1从db查询  param.fromType=2 从cache查询*/
	ProductSurveyResult productSurveyQueryBatch(1:ProductSurveyQueryBatchParam param);
	
	/* 导入虚拟商品卡密 */
	result.Result importProductCard(ProductCardImportParam param);

	/* 获取虚拟商品卡密（关键接口） */
	ProductCardResult getProductCard(1:ProductCardParam param);

	/* 查询虚拟商品卡密，根据transactionId，查询卡密信息 */
	ProductCardResult queryProductCard(1:ProductCardParam param);

	/* 查询虚拟商品卡密统计列表，卖家管理专用 */
	ProductCardStatisticsResult statisticsProductCard(1:ProductCardStatisticsParam param, 2:pagination.Pagination pagination);
	
	/* 查询虚拟商品每个sku卡密统计列表，卖家管理专用 */
	ProductCardStatisticsResult statisticsSkuProductCard(1:ProductCardSkuStatisticsParam param, 2:pagination.Pagination pagination);
	
	/*导出卡密列表*/
	result.StringResult exportStatisticsSkuProductCard(1:ProductCardViewParam param);

	/* 查询单个虚拟商品卡密列表，卖家管理专用 */
	ProductCardViewListResult queryProductCardViewList(1:ProductCardViewParam param, 2:pagination.Pagination pagination);

    /* 使用虚拟商品卡密， 需要sellerId和cardNumber */
	ProductCardResult useProductCard(1:ProductCard productCard);
	
	
	/*查询卖家虚拟商品验证列表*/
	CaptchaListResult queryCaptchaList(1:CaptchaQueryParam param);
	
	/*查询卖家虚拟商品验证列表—按月统计每天的验证总数( 查询条件：按月)*/
    DayCaptchaListResult queryCaptchaTotalList(1:CaptchaQueryParam param);
	
	/* 根据日期查询商品每天验证码数据 */
	DayCaptchaProductResult queryCaptchaDayTotalList(1:CaptchaDayQueryParam param);
	
    /*卖家虚拟商品验证列表明细*/
    CaptchaDetailResult queryCaptchaDetails(1:CaptchaQueryParam param);
	/*管理中心的验码记录(卖家中心也可以共用)*/
	CheckCodeListResult queryCheckCodeList(1:CheckCodeListParam param,2:pagination.Pagination pagination);
	/**管理中心验码记录导出**/
	result.StringResult exportCheckCodeList(1:CheckCodeListParam param);

	/*商品导出*/
	result.StringResult exportProduct(1:ProductSurveyQueryParam param);
	
	/**添加商品详情**/
	result.StringResult addDetailMongo(1:i32 sellerId,2:string detailContent);
	
	/*========================== 第三方商品相关接口 ============================*/
	/* 查询同步过来的商品 */
	ThirdPartyProductQueryResult queryThirdPartyProduct(1:ThirdPartyProductQueryParam param, 2:pagination.Pagination pagination);
	
	/* 获取操作日志 */
	ThirdPartyProductLogResult getThirdPartyProductLog(1:ThirdPartyProductLogParam param, 2:pagination.Pagination pagination);
	
	/* 提报商品 */
	result.StringResult offerThirdPartyProduct(1:ThirdPartyProduct thirdPartyProduct);
	
	/* 导出第三方商品 */
	result.StringResult exportThirdPartyProduct(1:ThirdPartyProductQueryParam param);
}
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
//     1:optional map<string, ProductSkuItem> productSkuMap, /*K-V:skunum-ProductSkuItem*/
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
    25:optional i32 postageId





}

struct ProductResult {
      1:result.Result result,
      2:optional Product product
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
	4:i32 attributeTag, /*商品属性信息*/
}

/* 商品概要 */
struct ProductSurvey {
	1:string productId,	
	2:string productName,
	3:i32 subjectId,
	4:i32 brandId,   
	5:string orgPrice,  
	6:string curPrice,         
	7:i32 activeStock,
	8:i32 totalSales, 
	9:i32 activeState,
	10:string imgUrl,
	11:optional string viceName,
	12:optional string createTime,
	13:optional i32 sellerId
}

struct ProductSurveyQueryParam {
	1:i32 sellerId,
    2:optional string productId,
	3:optional string productName,       
	4:optional i32 activeState,
	5:optional pagination.Pagination pagination,
	6:optional string sort,
	7:optional i32 subjectId,
	8:optional i32 brandId,
	9:optional list<i32> subjectIdList,
	10:optional list<string> productIdList
}

struct ProductSurveyQueryBatchParam {
	1:list<string> productIds,
	2:i32 fromType
}

struct ProductSurveyResult {
      1:result.Result result,
      2:optional pagination.Pagination pagination,
      3:optional list<ProductSurvey> productSurveyList
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

/*商品基本信息*/
service ProductServ {
	/*查询商品*/
	ProductResult queryProduct(1:string productId, 2:ProductRetParam param);

	/*查询商品sku*/
	ProductSkuResult queryProductSku(1:string productId);

	/*查询商品指定sku*/
	ProductResult queryHotSKU(1:string productId, 2:string skuNum, 3:ProductRetParam param);

	/*查询商品详情*/
	result.StringResult queryProductDetail(1:ProductDetailParam param);
	
	/*创建商品，返回商品ID*/
	result.StringResult addProduct(1:Product product); 
	
	/*修改商品，返回商品ID*/
	result.StringResult updateProduct(1:Product product);

	/* 商品概要信息列表查询*/
	ProductSurveyResult productSurveyQuery(1:ProductSurveyQueryParam param);

	/* 按点击量查询商品列表 */
	ProductSurveyResult productSurveyQueryByHit(1:ProductSurveyQueryParam param);

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
}
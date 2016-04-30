namespace java com.jfshare.finagle.thrift.stock

include "result.thrift"

/*商品sku库存信息*/
struct StockItem {

	/* 商品sku代码 */
	1:string skuNum,
	/* 商品sku库存数量 */
	2:i32 count,
	/* 商品sku锁定数量 */
	3:i32 lockCount,
	/* 仓库ID */
   4:optional string storehouseId
}
 
struct StockInfo {

	/* 库存总数 */
	1:i32 total,
	
	/* 锁定总数 */
	2:i32 lockTotal,
	
	/* 商品id */
	3:string productId,
	
	/* 库存记录 */
	4:list<StockItem> stockItems
}
 

struct StockResult {

	/* 0-成功 1-失败 */
	1:result.Result result,
	
	2:StockInfo stockInfo
}

/* 锁库存接口结构 */
struct LockInfo {

	/* 商品ID */
	1:string productId,
	
	/* 商品sku代码 */
	2:string skuNum,
	
	/* 申请的数量 */
	3:i32 applyCount, 
	 
	/* 实际锁定的数量，如果lockCount < applyCount 表示申请失败 */
	4:i32 lockCount,
	
	/* 仓库ID */
   5:optional string storehouseId
	   
}


struct LockStockResult {

	/* 0-成功 1-失败 */
	1:result.Result result,
	
	2:list<LockInfo> lockInfoList
}

/*
 * 1.批量查询商品的库存总数, queryContents中元素为商品id, queryType=total
 * 2.批量查询商品的库存总数及sku的库存数, queryContents中元素为商品id, queryType=all
 * 3.批量查询商品的某sku的库存数, queryContents中元素为商品id_仓库id_skuNum, queryType=sku
 */
struct BatchQueryParam {
	
	/* 
	 * 查询参数列表
	 * 1.查询商品维度库存总数，  
	 */
	1:list<string> queryContents,
	
	/* 
	 * 查询方式:
	 * total-只查询库存总数
	 * all-查询总数及sku的库存数
	 * sku-查询某一sku的库存数 
	 */
	2:string queryType
}

struct QueryParam {

	/* 商品id */
	1:string productId, 
	/* 仓库id */
	2:string storehouseId, 
	/* sku编码 */
	3:string skuNum,
	/* 查询维度, product-商品维度, storehouse-仓库维度, sku-sku维度 */
	4:string queryType
}

/* service */
service StockServ{

	/* 设置库存接口,tranId=快照id */	
	result.Result setStock(1:string tranId, 2:StockInfo stockInfo)
	/* 查询库存接口, */
	StockResult queryStock(1:QueryParam param)
	/* 批量查询库存接口, */
	StockResult batchQueryStock(1: BatchQueryParam param)
	/* 锁定库存接口 */
	LockStockResult  lockStock(1:string tranId,  2:list<LockInfo> lockInfoList)
	/* 释放库存接口 */
	result.Result releaseStock(1:string tranId,  2:list<LockInfo> lockInfoList)
	/* 释放库存锁定量接口 */
	result.Result releaseLockCount(1:string tranId,  2:list<LockInfo> lockInfoList)
	/* 删除库存信息接口 */
	result.Result removeStock(1:string productId)
	/* 创建库存接口 */
	result.Result createStock(1:string tranId, 2:StockInfo stockInfo)
	/* 补充库存接口,tranId=商品ID,StockItem中的count是库存增量 */
	result.Result supplyStock(1:string tranId, 2:StockInfo stockInfo)
    /* 全量补充库存接口,tranId=商品ID,StockItem中的count是库存全量，即商品sku库存更新后的值 */
	result.Result supplyFullStock(1:string tranId, 2:StockInfo stockInfo)
}
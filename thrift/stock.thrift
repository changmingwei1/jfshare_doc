namespace java com.jfshare.finagle.thrift.stock

include "result.thrift"

/*商品sku库存信息*/
struct StockItem {

	/*商品sku代码*/
	1:string skuNum,
	
	/*商品sku库存数量*/
	2:i32 count,
	
	/*商品sku锁定数量*/
	3:i32 lockCount,
	/* 仓库ID */
    4:optional string storehouseId
}
 
struct StockInfo {

	/*库存总数*/
	1:i32 total,
	
	/*锁定总数*/
	2:i32 lockTotal,
	
	/*商品id*/
	3:string productId,
	
	/*K-V:sku-StockItem*/
	4:map<string, StockItem> stockItemMap,
	
	5:list<StockItem> stockItems
}
 

struct StockResult {

	/*0-成功 1-失败*/
	1:result.Result result,
	
	2:StockInfo stockInfo
}

/*所库存接口结构*/
struct LockInfo {

	/*商品ID*/
	1:string productId,
	
	/*商品sku代码*/
	2:string skuNum,
	
	/*申请的数量*/
	3:i32 applyCount, 
	 
	/*实际锁定的数量，如果lockCount < applyCount 表示申请失败*/
	4:i32 lockCount   
}


struct LockStockResult {

	/*0-成功 1-失败*/
	1:result.Result result,
	

	2:list<LockInfo> lockInfoList
}


/*service*/

service StockServ{
	/*设置库存接口,tranId=快照id*/
	result.Result setStock(1:string tranId, 2:StockInfo stockInfo)
	/*获取库存接口*/
	StockResult getStock(1:string productId)
	/*根据商品ID和Sku获取对于库存接口*/
	StockResult getStockForSku(1:string productId, 2:list<string> skuNums)
	/*锁定库存接口*/
	LockStockResult  lockStock(1:string tranId,  2:list<LockInfo> lockInfoList)
	/*释放库存接口*/
	result.Result releaseStock(1:string tranId,  2:list<LockInfo> lockInfoList)
	/*释放库存锁定量接口*/
	result.Result releaseLockCount(1:string tranId,  2:list<LockInfo> lockInfoList)
	/*删除库存信息接口*/
	result.Result removeStock(1:string productId)
	/*创建库存接口*/
	result.Result createStock(1:string tranId, 2:StockInfo stockInfo)
	/*补充库存接口,tranId=商品ID,StockItem中的count是库存增量*/
	result.Result supplyStock(1:string tranId, 2:StockInfo stockInfo)
    /*全量补充库存接口,tranId=商品ID,StockItem中的count是库存全量，即商品sku库存更新后的值*/
	result.Result supplyFullStock(1:string tranId, 2:StockInfo stockInfo)
}
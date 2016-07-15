namespace java com.jfshare.finagle.thrift.cart

include "result.thrift"
include "seller.thrift"
include "product.thrift"

/*购物车项目*/
struct Item {		        
	/*商品ID */
	1:string productId,	

	/*sku编码 pId-vId:pId-vId*/
	2:string skuNum, 

	/*商品数量*/
	3:i32 count,	
	
	/*添加购物车时的价格*/
	4:string price,
	
	/*渠道*/
	5:string wi,
}

/*购物车详细项*/
struct ItemPlus {
	1:product.Product product,

        /*商品的采购数量*/
	2:i32 count,	

	/*该商品未付款的数量*/
	3:i32 lockCount,
	
	/*购物车价格*/
	4:string cartPrice,
	
	/*该商品所有规格的总数量*/
	5:i32 totalCount,
	
	/*该规格商品的库存数量*/
	6:i32 skuCount,
		
	/*渠道*/
	7:string wi,
	
	/*已购数量*/
	8:i32 currBuy,
	
	/*发货时间*/
	9:i32 sellerSendTime,
}

/*购物车项目明细*/
struct ItemDetail {
	/*商品信息*/
	1:ItemPlus product
}

/*按商家分组的购物车项目明细*/
struct sellerItemDetail {
	/*卖家信息*/
	1:optional seller.Seller seller, 

	/*项目列表*/
	2:list<ItemDetail> itemDetailList,
}

/*购物车*/
struct CartResult {
	/*结果*/
	1:result.Result result,
	
	/*购物车列表项*/
	2:list<sellerItemDetail> itemList,
	
	/*无效的列表项*/
	3:list<ItemDetail> invalidItemList,
}

/*Mini购物车*/
struct MiniCartResult {
	/*结果*/
	1:result.Result result,
	
	/*购物车列表项*/
	2:list<ItemPlus> pList,
	
	/*购物车中未失效的商品数量*/
	3:i32 validCount,
	
	/*失效的商品数量*/
	4:i32 invalidCount,
}

/*更新购物车商品 | 清除购物车明细*/
struct CartKey {
	1:string productId,
	2:string skuNum,
}

/*购物车商品数量校验结果*/
struct CheckItemInfo {       
	/*商品ID */
	1:string productId,	

	/*sku编码 pId-vId:pId-vId*/
	2:string skuNum, 

	/*商品库存数量*/
	3:i32 skuCount,	
	
	/*购物车中已添加的数量*/
	4:i32 currQuantity,
	
	/*限购最大数量*/
	5:i32 maxBuyLimit,
	
	/* 已购数量*/
	6:i32 currBuy,
	
	/* 超出限购标识; 如果购物车中商品数量超出限购,该值为true*/
	7:bool isOutOfGauge,
	
	/* 超出库存的标识; 如果购物车中商品数量超过库存, 该值为true*/
	8:bool isOutOfStock,
}

struct CheckCartResult {
	/*结果*/
	1:result.Result result,
	
	/*校验结果*/
	2:list<CheckItemInfo> checkList,
	
	/*更新购物车时，表明是更新商品还是删除商品*/
	3:string value,
}

/*购物车服务*/
service CartServ{
	/*	获取购物车中商品项的数量 source: 0:系统；1：PC；2：无线*/
	result.StringResult countItem(1:string userKey, 2:i32 source)
	
	/*	添加购物车项目*/
	CheckCartResult addItem(1:string userKey, 2:Item item, 3:i32 source)

	/*	修改购物车项目， cartKeyList： 已勾选的商品集合*/
	CheckCartResult updateItem(1:string userKey, 2:list<CartKey> cartKeyList, 3:CartKey cartKey, 4:Item item, 5:i32 source)
	 
	/*	删除购物车项目*/
	result.Result deleteItem(1:string userKey, 2:list<CartKey> cartKeyList, 3:i32 source)
	 
	/*	合并购物车项目*/
	 result.Result mergeItem(1:string sessionId, 2:string userId, 3:i32 source)

	/*	购物车列表*/
	 CartResult listItem(1:string userKey, 3:i32 source)
	 
	 /*	miniCart购物车列表 如果value的值为null 或 空串 请重新请求*/
	 MiniCartResult listMiniItem(1:string userKey, 2:i32 source)
	 
	 /*	查询已勾选的购物车列表*/
	 CartResult findListByCartKey(1:string userKey, 2:list<CartKey> cartKeyList, 3:i32 source)
	 
	 /*	校验购物车数量*/
	 CheckCartResult checkItem(1:string userKey, 2:list<CartKey> cartKeyList, 3:i32 source)
	 
	 /* 获取购物车更新的时间戳 */
	 result.StringResult getTimeStamp(1:string userKey, 2:i32 source)
}
	





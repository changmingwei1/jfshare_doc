namespace java com.jfshare.finagle.thrift.baseTemplate

include "result.thrift"


/*********************** 以下是仓库相关结构 ***********************/
/* 仓库信息 */
struct Storehouse {
    /* 记录ID */
	1:i32 id,
	/* 卖家ID */
	2:i32 sellerId,
	/* 仓库名称 */
	3:string name,
	/* 支持的省份 多个以英文 “,” 隔开 */
	4:string supportProvince
}

/* 查询仓库参数 */
struct StorehouseQueryParam {
    /* 记录ID */
    1:i32 id,
    /* 卖家ID */
    2:i32 sellerId
}

/*********************** 以下是邮费相关结构 ***********************/

/* 邮费信息 */
struct Postage {
    
	1:string supportProvince,
	
    /**
    *  计费规则：
    *
    *  商品计费规则json格式
    *  { number:2,     【件, 千克】
    *    postage:10,   【运费】
    *    addNumber:2,  【增加   件, 千克】
    *    addPostage:5  【增加运费】
    *  }
    *
    * 商家计费规则json格式
    *  { number:2,      【多少件以下】，【多少重量以下】
    *  	 amount: 10,    【多少钱以上】
    *  	 limit:1,       【是否类推, 1类推， 0不类推】
    *  	 postage:10,    【运费】
    *  }
    *
    */
    2:string rule

}

/* 邮费模板 */
struct PostageTemplate {
    /* 记录ID */
	1:i32 id,
	/* 卖家ID */
	2:i32 sellerId,
	/* 邮费模板名称 */
	3:string name,
	/* 类型 11：按件数  12：按重量  21：按订单件数+订单金额  22：按订单重量+订单金额 */
    4:i32 type,
    /* 邮费信息 */
    5:list<Postage> postageList,
    /* 分组： 1：商品邮费模板  2：店铺邮费模板 */
    6:i32 group,
    /* 模板描述 */
    7:optional string desc
}

/* 查询邮费模板参数 */
struct PostageTemplateQueryParam {
    /* 记录ID */
    1:i32 id,
    /* 卖家ID */
    2:i32 sellerId,
    /* 类型 1：按件数  2：按件数上不封顶  3：按重量  4：按重量上不封顶*/
    3:i32 type,
    /* 邮费名称 */
    4:optional string name
}


/* 仓库接口返回值 */
struct StorehouseResult {
	1:result.Result result,
	2:optional list<Storehouse> storehouseList
}

/* 邮费模板接口返回值 */
struct PostageTemplateResult {
	1:result.Result result,
	2:optional list<PostageTemplate> postageTemplateList
}




service BaseTemplateServ{
/*********************** 以下是仓库相关接口 ***********************/
    /* 添加仓库 */
	result.StringResult addStorehouse(1:Storehouse storehouse);
	/* 修改仓库 */
	result.Result updateStorehouse(1:Storehouse storehouse);
	/* 删除仓库 */
	result.Result deleteStorehouse(1:i32 sellerId, 2:i32 id);
	/* 删除仓库 Storehouse实体中需要给sellerId和id赋值，否则删除失败 */
	result.Result deleteStorehouseBatch(1:list<Storehouse> storehouseList);
	/* 查询仓库 */
	StorehouseResult queryStorehouse(1:StorehouseQueryParam param);
	/* 获取仓库信息 */
	StorehouseResult getStorehouse(1:list<i32> storehouseIds);


/*********************** 以下是邮费相关结构 ***********************/

    /* 添加邮费模板 */
    result.StringResult addPostageTemplate(1:PostageTemplate postageTemplate);
    /* 修改邮费模板 */
    result.Result updatePostageTemplate(1:PostageTemplate postageTemplate);
    /* 删除邮费模板 */
    result.Result deletePostageTemplate(1:i32 sellerId, 2:i32 id);
    /* 删除邮费模板 PostageTemplate实体中需要给sellerId和id赋值，否则删除失败 */
    result.Result deletePostageTemplateBatch(1:list<PostageTemplate> postageTemplateList);
    /* 查询邮费模板 */
    PostageTemplateResult queryPostageTemplate(1:PostageTemplateQueryParam param);
    /* 获取邮费模板信息 */
    PostageTemplateResult getPostageTemplate(1:list<i32> postageTemplateIds);


    /* 添加邮费 */
	/* result.StringResult addPostage(1:Postage postage); *
	/* 修改邮费 */
	/* result.Result updatePostage(1:Postage postage); */
	/* 删除邮费 */
	/* result.Result deletePostage(1:i32 sellerId, 2:i32 id); */
	/* 删除邮费 Postage实体中需要给sellerId和id赋值，否则删除失败 */
	/* result.Result deletePostageBatch(1:list<Postage> postageList); */
	/* 查询邮费 */
	/* PostageResult queryPostage(1:PostageQueryParam param); */
	/* 获取邮费信息 */
    /* PostageResult getPostage(1:list<i32> postageIds); */
}
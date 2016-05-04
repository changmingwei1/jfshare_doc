namespace java com.jfshare.finagle.thrift.subject

include "result.thrift"
include "brand.thrift"

/*归属类目节点信息*/
struct SubjectNode {
	/*类目ID, 主键，自增长*/
	1:i32 id,
	/*类目名称*/
	2:string name,
	/*类目图标*/
	3:string img_key,
	/*父类目，引入类目ID,默认为0表示一级类目*/
	4:i32 pid,
	/*类目排序,显示时同级类目的排序序号*/
	5:i32 sorted,
	/*是否是叶子节点*/
	6:i32 isLeaf
	/*对应的前台类目Ids，多个以","隔开  结构如：{"main":"1,2,3", "wireless":"4,5,6"} 可以直接用 Map 解析 */
	7:optional string displayIds
	/*类目状态 1: 新增   2：删除   3：已发布    4：已删除
	 *  新增：卖家创建/编辑商品、报名时不显示
	 *  删除：卖家创建/编辑商品、报名时仍显示
	 *  已发布：卖家创建/编辑商品、报名时显示
	 *  已删除：卖家创建/编辑商品、报名时不显示
	 */
	8:optional i32 status
}

/*归属类目信息*/
struct SubjectInfo {
	/*类目ID, 主键，自增长*/
	1:i32 id,
	/*类目名称*/
	2:string name,
	/*类目图标*/
	3:string img_key,
	/*父类目，引入类目ID,默认为0表示一级类目*/
	4:i32 pid,
	/*类目排序,显示时同级类目的排序序号*/
	5:i32 sorted,
	/*类目级数*/
	6:i32 level,
	/*是否叶子节点 1:是  0:否        */
	7:i32 isLeaf,
	/*备注*/
	8:string demo,
	/*创建时间*/
	9:string createTime,
	/*创建人*/
	10:i32 creator,
	/*最后修改时间*/
	11:string updateTime,
	/*最后修改人*/
	12:i32 updater,
	/*类目状态 1: 新增   2：删除   3：已发布    4：已删除
	 *  新增：卖家创建/编辑商品、报名时不显示
	 *  删除：卖家创建/编辑商品、报名时仍显示
	 *  已发布：卖家创建/编辑商品、报名时显示
	 *  已删除：卖家创建/编辑商品、报名时不显示
	 */
	13:i32 status,
	/*删除状态*/
	14:i32 deleted,
	/*类目路径*/
	15:optional string path,
	/*类目对应属性*/
	16:string attributes,
	/*对应的前台类目Ids，多个以","隔开  结构如：{"main":"1,2,3", "wireless":"4,5,6"}  可以直接用 Map 解析 */
	17:optional string displayIds,
	/*类目父树路径集合*/
	18:optional list<SubjectNode> subjectNodes
}

/*属性信息*/
struct SubjectAttribute {
	/*属性ID, 主键，自增长*/
	1:i32 id,
	/*属性名称*/
	2:string name,
	/*属性所属类目ID*/
	3:i32 subjectId,
	/*覆盖父级属性ID*/
	4:i32 rewriteId,
	/*属性类别 1. input 2. radio 3. checkbox 4.select 5.custom 6.system*/
	5:string type,
	/*属性取值 多个值以逗号隔开*/
	6:string value,
	/*是否必填  0：非必填，1：必填*/
	7:i32 beRequired,
	/*是否为sku属性 0:否  1:是*/
	8:i32 isSku,
	/*备注*/
	9:string demo,
	/*创建时间*/
	10:string createTime,
	/*创建人*/
	11:i32 creator,
	/*最后修改时间*/
	12:string updateTime,
	/*最后修改人*/
	13:i32 updater,
	/*是否已删除，0:未；1：已*/
	14:i32 deleted,
	/*扩展字段1*/
	15:optional string ext1,
	/*扩展字段2*/
	16:optional string ext2,
	/*扩展字段3*/
	17:optional string ext3,
	/*扩展字段4*/
	18:optional string ext4,
	/*扩展字段5*/
	19:optional string ext5,
	/*扩展字段6*/
	20:optional string ext6	
}

/*归属类目结果信息*/
struct SubjectInfoResult {
	/*结果信息*/
	1:result.Result result,
	/*类目信息*/
	2:SubjectInfo subjectInfo,
	/*类目属性信息*/
	3:list<SubjectAttribute> subjectAttributes,
	/*类目下的品牌信息*/
	4:list<brand.BrandInfo> brandList 
}

/*归属类目树结果信息*/
struct SubjectTreeResult {
	/*结果信息*/
	1:result.Result result,
	/*类目父树或者子树集合，子查父包含当前类目，父查子不包含当前类目*/
	2:list<SubjectNode> subjectNodes
}

/*归属类目查询条件*/
struct SubjectQueryParam {
	/*父节点ID*/
	1:i32 pId,
	/*节点名称*/
	2:string name,
	/*状态*/
	3:i32 status
}

/*品牌类目对应关系参数*/
struct BrandSubjectParam {
	/*品牌ID*/
	1:i32 bId,
	/*对应关系集合*/
	2:list<i32> Subjects,
}

/*分页对象*/
struct Page {
	/* 记录总数 */
    1:i32 total,
    /* 总页数 */
    2:i32 pageCount,
    /* 每页数量，默认为10 */
    3:i32 pageSize,
    /* 当前页数，默认从第1页开始 */
    4:i32 curPage
}

/*归属类目查询结果信息*/
struct SubjectQueryResult {
	/*结果信息*/
	1:result.Result result,
	/*类目集合*/
	2:list<SubjectInfo> subjectInfos,
	/*分页信息*/
	3:Page page
}

/*表现类目节点信息*/
struct DisplaySubjectNode {
	/*类目ID, 主键，自增长*/
	1:i32 id,
	/*类目名称*/
	2:string name,
	/*类目图标*/
	3:string img_key,
	/*父类目，引入类目ID,默认为0表示一级类目*/
	4:i32 pid,
	/*类目排序,显示时同级类目的排序序号*/
	5:i32 sorted,
	/*是否是叶子节点*/
	6:i32 isLeaf
	/*类目状态 1: 新增   2：删除   3：已发布    4：已删除
	 *  新增：卖家创建/编辑商品、报名时不显示
	 *  删除：卖家创建/编辑商品、报名时仍显示
	 *  已发布：卖家创建/编辑商品、报名时显示
	 *  已删除：卖家创建/编辑商品、报名时不显示
	 */
	7:optional i32 status
} 

/*表现类目信息*/
struct DisplaySubjectInfo {
	/*类目ID, 主键，自增长*/
	1:i32 id,
	/*类目名称*/
	2:string name,
	/*类目图标*/
	3:string img_key,
	/*父类目，引入类目ID,默认为0表示一级类目*/
	4:i32 pid,
	/*类目排序,显示时同级类目的排序序号*/
	5:i32 sorted,
	/*类目级数*/
	6:i32 level,
	/*是否叶子节点 1:是  0:否        */
	7:i32 isLeaf,
	/*备注*/
	8:string demo,
	/*创建时间*/
	9:string createTime,
	/*创建人*/
	10:i32 creator,
	/*最后修改时间*/
	11:string updateTime,
	/*最后修改人*/
	12:i32 updater,
	/*类目状态 1: 新增   2：删除   3：已发布    4：已删除
	 *  新增：卖家创建/编辑商品、报名时不显示
	 *  删除：卖家创建/编辑商品、报名时仍显示
	 *  已发布：卖家创建/编辑商品、报名时显示
	 *  已删除：卖家创建/编辑商品、报名时不显示
	 */
	13:i32 status,
	/*删除状态*/
	14:i32 deleted,
	/*类目路径*/
	15:optional string path,
	/*类目对应属性*/
	16:string attributes,
	/*类目父树路径集合*/
	17:optional list<SubjectNode> subjectNodes
}


/*表现类目参数信息*/
struct DisplaySubjectParam {
	/*类目对象，需要 id */
	1:DisplaySubjectInfo displaySubjectInfo,
	/*类目标志 主站：main   无线：wireless   OEM：oem    优品汇：yph*/
	2:string flag
	
} 

/*表现类目结果*/
struct DisplaySubjectResult {
	/*结果信息*/
	1:result.Result result,
	/*类目信息*/
	2:DisplaySubjectInfo displaySubjectInfo
}

/*表现类目树结果*/
struct DisplaySubjectTreeResult {
	/*结果信息*/
	1:result.Result result,
	/*类目父树或者子树集合，子查父包含当前类目，父查子不包含当前类目*/
	2:list<DisplaySubjectNode> displaySubjectNodes
}

/*归属类目查询条件*/
struct DisplaySubjectQueryParam {
	/*父节点ID*/
	1:i32 pId,
	/*节点名称*/
	2:string name,
	/*类目标志，即渠道类型*/
	3:string type
}

/*归属类目查询结果信息*/
struct DisplaySubjectQueryResult {
	/*结果信息*/
	1:result.Result result,
	/*类目集合*/
	2:list<DisplaySubjectInfo> displaySubjectInfos,
	/*分页信息*/
	3:Page page
}

struct DisplaySubjectChannelInfo {
	/*渠道ID*/
	1:i32 id,
	/*渠道名称*/
	2:string name,
	/*渠道编码*/
	3:string code,
	/*创建人ID*/
	4:i32 creator,
	/*修改人ID*/
	5:i32 updater,
	/*最后更新时间*/
	6:optional string updateTime,
	/*最后修改人姓名*/
	7:optional string updaterName
}

struct DisplaySubjectChannelQueryResult {
	/*结果信息*/
	1:result.Result result,
	/*渠道集合*/
	2:list<DisplaySubjectChannelInfo> channelInfos,
	/*分页信息*/
	3:Page page
}

struct DisplaySubjectChannelQueryParam {
	/*渠道名称*/
	1:string name
}

struct SubjectRefDisplayInfo {
	/*归属类目ID*/
	1:i32 subjectId,
	/*表现类目ID*/
	2:i32 displayId
}

/************************* 以下是类目属性相关结构 ***********************/
/* 类目属性查询参数 */
struct SubjectAttributeQueryParam {
	/*归属类目ID*/
	1:i32 subjectId,
}

/* 类目属性查询结果 */
struct SubjectAttributeResult {
    /*结果信息*/
    1:result.Result result,
    /*类目属性信息*/
    3:list<SubjectAttribute> subjectAttributes
}

/**
* 类目服务中的redis缓存被注释掉了，需要放开
*
**/
service SubjectServ{
	/*添加归属类目*/
	result.Result add(1:SubjectInfo subject);
	
	/*更新归属类目*/
	result.Result update(1:SubjectInfo subject);
	
	/*删除某个归属类目，逻辑删除*/
	result.Result deleteById(1:i32 subjectId);
	
	/*根据id查询归属类目信息，携带属性信息*/
	SubjectInfoResult getById(1:i32 subjectId);
	
	/*查询归属类目子集树结构，仅包含直属下级节点，查询一级时，参数subjectId为： 0  */
	SubjectTreeResult getSubTree(1:i32 subjectId);
	
	/*查询归属类目子集树结构(类目管理页面专用)，仅包含直属下级节点，查询一级时，参数subjectId为： 0  */
	SubjectTreeResult getSubTreeForManage(1:i32 subjectId);
	
	/*根据id查询，查询此节点所属路径*/
	SubjectTreeResult getSuperTree(1:i32 subjectId);
	
	/*根据id查询，查询此节点下所有的叶子节点*/
	SubjectTreeResult getLeavesById(1:i32 subjectId);
	
	/*遍历整棵归属类目树 返回json格式*/
	result.StringResult getWholeTree();
	
	/*遍历整棵归属类目树 返回对象格式*/
	SubjectTreeResult getWholeTreeList();
	
	/*发布归属类目，状态：新增 --> 已发布， 删除 --> 已删除*/
	result.Result releaseSubject(1:i32 subjectId);
	
	/*条件查询归属类目*/
	SubjectQueryResult querySubjects(1:SubjectQueryParam queryParam, 2:Page page);
	
	/*添加表现类目，参数需要类目实体和类目标识*/
	result.Result add4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*更新表现类目，参数需要类目实体和类目标识*/
	result.Result update4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*删除某个表现类目，逻辑删除，参数需要类目实体（有id即可）和类目标识*/
	result.Result delete4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*根据id查询表现类目信息，参数需要类目实体（有id即可）和类目标识*/
	DisplaySubjectResult getById4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*查询表现类目子集树结构，仅包含直属下级节点，参数需要类目实体（有id即可）和类目标识，查询一级时，参数中的id为： 0  */
	DisplaySubjectTreeResult getSubTree4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*根据id查询，查询此节点所属路径，参数需要类目实体（有id即可）和类目标识*/
	DisplaySubjectTreeResult getSuperTree4dis(1:DisplaySubjectParam displaySubjectParam);
	
	/*根据传入的 后台类目Id获取前台结构  对应的前台类目Ids，多个以","隔开  结构如：{"main":"1,2,3", "wireless":"4,5,6"} 可以直接用 Map 解析   */
	result.StringResult getDisplayIdsBySubjectId(1:i32 subjectId);
	
	/*遍历整棵表现类目树 返回对象格式*/
	DisplaySubjectTreeResult getWholeTreeList4dis(1:string type);
	
	/*条件查询表现类目*/
	DisplaySubjectQueryResult querySubjects4dis(1:DisplaySubjectQueryParam queryParam, 2:Page page);
	
	
	/*添加归属类目渠道*/
	result.Result addChannel(1:DisplaySubjectChannelInfo channel);
	
	/*更新归属类目渠道*/
	result.Result updateChannel(1:DisplaySubjectChannelInfo channel);
	
	/*删除某个归属类目渠道，逻辑删除*/
	result.Result deleteChannelById(1:i32 channelId);
	
	/*获取所有归属类目渠道*/
	DisplaySubjectChannelQueryResult queryChannels(1:DisplaySubjectChannelQueryParam queryParam, 2:Page page);
	
	
	/*添加归属类目与表现类目的关系*/
	result.Result addRelation(1:SubjectRefDisplayInfo relation);
	
	/*删除归属类目与表现类目的关系*/
	result.Result deleteRelation(1:SubjectRefDisplayInfo relation);
	
	/*根据表现类目ID查询归属类目信息*/
	SubjectQueryResult querySubjectsRelation(1:i32 displayId, 2:Page page);

	/*品牌相关的类目*/
	SubjectQueryResult queryBrandSubject(1:brand.BrandInfo brand);
	/*更新品牌和类目的关系，上传最终结果，非增量*/
	result.Result updateBrandSubject(1:BrandSubjectParam bsParam);
/************************* 以下是类目属性相关接口 ***********************/

    /*添加属性*/
    result.Result addSubjectAttribute(1:SubjectAttribute atrribute);
    /*修改属性*/
    result.Result updateSubjectAttribute(1:SubjectAttribute atrribute);
    /*删除属性*/
	result.Result deleteSubjectAttribute(1:SubjectAttribute atrribute);
	/*批量删除属性*/
    result.Result deleteSubjectAttributeBatch(1:list<SubjectAttribute> atrributeList);
	/*查询属性信息*/
	SubjectAttributeResult querySubjectAttribute(1:SubjectAttributeQueryParam param);
	/*某一类目属性应用于同级同父节点的其他类目*/
	result.Result applyAttributeToSuperAll(1:SubjectInfo subject);
}
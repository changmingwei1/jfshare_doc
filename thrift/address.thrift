namespace java com.jfshare.finagle.thrift.address

include "result.thrift"



/*收货地址信息 */
struct AddressInfo {
	1:i32 userId,             /*买家ID*/
	2:i32 id,                 /*记录ID*/
	3:string receiverName,    /*收货人姓名*/
	4:string mobile,          /*收货人手机号*/
	5:string telCode,         /*电话区号*/
	6:string tel,             /*收货人电话*/
	7:string telExtNumber,    /*电话分机号*/
	8:i32 provinceId,         /*省区域ID*/
	9:string provinceName,     /*省区域名字*/
	10:i32 cityId,             /*市区域ID  */
	11:string cityName,         /*市区域名字*/
	12:i32 countyId,           /*县区域ID  */
	13:string countyName,       /*县区域名字*/
	14:string address,         /*收货地址*/
	15:string postCode,        /*邮编*/
	16:i32 isDefault,           /*是否是默认地址*/
	17:string email,             /*邮箱*/
	18:optional i32 index       /*顺序序号*/
}



struct AddressInfoListResult {
	1:result.Result result,
	2:optional list<AddressInfo> addressInfoList     
}


struct AddressInfoResult {
	1:result.Result result,
	2:AddressInfo addressInfo;
}


service AddressServ{
	result.StringResult addAddress(1:AddressInfo addressInfo)		/*添加地址*/
	result.Result updateAddress(1:AddressInfo addressInfo)			/*修改地址*/
	result.Result delAddress(1:i32 userId, 2:i32 id)			/*删除地址*/
	AddressInfoListResult queryAddress(1:i32 userId)			/*根据用户id查询地址*/
	AddressInfo queryAddressById(1:i32 id, 2:i32 userId)          /*根据id查询某个地址*/
	AddressInfoResult queryAddressInfo(1:i32 id, 2:i32 userId)

	result.Result setDefaultAddress(1:i32 userId, 2:i32 addressId)         /*设置默认地址*/
	AddressInfoResult getDefaultAddress(1:i32 userId)         /*获得用户默认地址*/
}
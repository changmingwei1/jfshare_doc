namespace java com.jfshare.finagle.thrift.common

include "result.thrift"


struct AreaInfo {
	/*ID*/
	1:i32 id,
	/*区域名称*/
	2:string name,
	/*区域短名称*/
	3:string shortName,
	/*区域属性*/
	4:string property,
	/*邮政编码*/
	5:string postCode,
	/*区域名称拼音*/
	6:optional string pinyin,
	/*区域名称首字母*/
	7:optional string initial,
	/*省ID*/
	8:optional i32 provinceId,
	/*市ID*/             
	9:optional i32 cityId,
	/*区ID*/
	10:optional i32 countyId
}

struct Attribution {
	/*省ID*/
	1:i32 provinceId,
	/*省份名称*/
	2:string provinceName, 
	/*市ID*/                    
	3:i32 cityId,
	/*市命称*/
	4:string cityName,
	/*区ID*/
	5:optional i32 countyId,
	/*区命称*/
	6:optional string countyName,
	/*省份短命称*/
	7:optional string shortProvinceName,
	/*市短命称*/
	8:optional string shortCityName,
	/*区短命称*/
	9:optional string shortCountyName
}

struct AttributionOperator {
	1:i32 provinceId,

	/*省份名称*/
	2:string provinceName,                     
	3:i32 cityId,              
	4:string cityName,
	5:string operator
}

struct AttributionId {
	1:i32 provinceId,
	2:i32 cityId,
	3:i32 countyId
}


struct AreaInfoResult {
	1:result.Result result,
	2:optional list<AreaInfo> areaInfo
}


struct AttributionResult {
	1:result.Result result,
	2:optional Attribution areaInfo,
}

struct AttributionOperatorResult {
	1:result.Result result,
	2:optional AttributionOperator attributionOperator,
}

struct AttributionIdResult {
	1:result.Result result,
	2:optional AttributionId attributionId
}

struct Captcha {
	1:string id,
	2:string value,
	3:binary captchaBytes
}

struct CaptchaResult {
	1:result.Result result,
	2:Captcha captcha
}

struct MsgCaptcha {
	1:string type,
	2:string mobile,
	3:string captchaDesc
}

struct ShortMsg {
	1:string mobile,
	2:string content
}

service CommonServ{
	/*获取省份信息*/
	AreaInfoResult province()               
	
	/*获取省份的市区信息*/
	AreaInfoResult city(1:i32 provinceId) 
	
	/*获取省份的市区的县级信息*/
	AreaInfoResult county(1:i32 cityId) 
	
	/*获取街道信息*/
	AreaInfoResult street(1:i32 county) 

	AttributionResult numberAttribution(1: string number)

	AttributionOperatorResult numberAttributionOperator(1: string number)

	AttributionResult ipAttribution(1: string ip)

	AttributionResult cityAttribution(1: i32 cityId)

	AttributionIdResult idByName(1:string provinceName, 2:string cityName, 3:string countyName)

	/*根据区县ID，查找到省ID和市ID*/
	AttributionIdResult getAttributionIdByCountyId(1:i32 countyId)

	/*根据省市区ID，查找到省市区name.
	规则:查询county信息，则上级的省市ID为必填，同理查询city信息，则上级的省ID为必填.如果只查询省信息，则可以只传省ID
	*/
	AttributionResult getAttributionNameById(1:i32 provinceId,2:i32 cityId,3:i32 countyId)
	
	/*获取验证码*/
	CaptchaResult getCaptcha(1:string id)
	
	/*验证验证码*/
	result.Result validateCaptcha(1:Captcha captcha)
	
	/*发送短信验证码*/
	result.Result sendMsgCaptcha(1:MsgCaptcha captcha)
	
	/*验证短信验证码*/
	result.Result validateMsgCaptcha(1:MsgCaptcha captcha)
	
	/*获取二维码*/
	CaptchaResult getQRCode(1:string id)
	
	/*发送短信*/
	result.Result sendMsg(1:ShortMsg msg)
	
}
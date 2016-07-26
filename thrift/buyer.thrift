namespace java com.jfshare.finagle.thrift.buyer

include "result.thrift"

struct AuthInfo{
    1:string token,
    2:string ppInfo
}

struct AuthInfoResult{
    1:result.Result result,
    2:AuthInfo authInfo
}

struct ThirdpartyUser{
	1:string signinName,
	2:string userName,
	3:string thirdType,
	4:string custId,
	5:string accountNo,
	6:string extInfo
}

struct Buyer {
    1:i32 userId,
    2:string loginName,
    3:string userName,
    4:string pwdEnc,
    5:string favImg,
    6:string birthday,
    7:i32 sex,
    8:string idCard,
    9:string mobile,
    10:string tel,
    11:string email,
    12:i32 provinceId,
    13:i32 cityId,
    14:i32 countyId,
    15:string provinceName,
    16:string cityName,
    17:string countyName,
    18:string address,
    19:string postCode,
    20:i32 degree,
    21:i32 salary,
    22:string remark,
    23:i32 serial,
    24:string createTime,
    25:string lastUpdateTime,
	26:i32 state
}

/*登陆请求参数*/
struct LoginLog {
    1:i32 userId,
    2:string tokenId, /*令牌标识*/
    3:string ip,
    4:string browser, /*浏览器标识*/
    5:i32 fromSource, /*终端标识*/
    6:i32 loginAuto, /*是否自动登录*/
    7:string loginTime,
    8:string logoutTime,
    9:i32 clientType, /*客户端标识   Android:1 Ios:2  H5:3 Web:4 */
    10:string version,
}

struct BuyerResult{
    1:result.Result result,
    2:Buyer buyer,
    3:LoginLog loginLog,
    4:optional bool value,
    5:optional ThirdpartyUser thirdUser,
    6:optional AuthInfo authInfo
}

struct BuyerListResult{
     1:result.Result result,
    2:list<Buyer> buyerList
}
/*======第三方登陆========*/
struct ValidateInfo{
    1:i32 thirdType,
    2:string custId,
    3:string accessToken,
    4:string openId,
    5:optional string valiNum,/*验证码*/
    6:optional string valiNumType /*验证类型*/
}

struct UserInfoThird{
	1:string custId,
	2:string mobile,
	3:i32 thirdType,
	4:string extInfo
}

/*=================*/

/*买家服务*/
service BuyerServ {
    /*查询登录名是否存在*/
    result.BoolResult buyerIsExist(1:string loginName);

    /*注册*/
    result.Result signin(1:Buyer buyer);
    
    /*new注册*/
    result.Result newSignin(1:Buyer buyer);

    /*登陆*/
    BuyerResult login(1:Buyer buyer, 2:LoginLog loginLog);

    /*普通登陆*/
    BuyerResult newLogin(1:Buyer buyer, 2:LoginLog loginLog);

    /*短信登陆*/
    BuyerResult smsLogin(1:Buyer buyer, 2:LoginLog loginLog);

    /*注销*/
    result.Result logout(1:LoginLog loginLog);

    /*是否登陆*/
    BuyerResult isOnline(1:LoginLog loginLog);

    /*获取登陆信息*/
    BuyerResult getOnlineInfo(1:LoginLog loginLog);

    /*找回密码*/
    result.StringResult pwdFind(1:i32 findWay, 2:string account);
	
	/*获取用户信息*/
    BuyerResult getBuyer(1:Buyer buyer);
    
    /*批量获取用户信息*/
    BuyerListResult getListBuyer(1:optional list<i32> userIdList);
	
	/*更新用户信息*/
    result.Result updateBuyer(1:Buyer buyer);
	
	/*重置用户密码*/
    result.Result resetBuyerPwd(1:string newPwd, 2:Buyer buyer);

    /*重置用户密码*/
    result.Result newResetBuyerPwd(1:string newPwd, 2:Buyer buyer);

	/*绑定第三方登录账号*/
    BuyerResult signinThirdParty(1:LoginLog loginLog, 2:ThirdpartyUser thirdUser);
	
	/*账号是否绑定第三方账号*/
    BuyerResult isBindThirdParty(1:string thirdType, 2:LoginLog loginLog);
    
    /* 获取鉴权信息*/
    AuthInfoResult getAuthInfo(1:AuthInfo authInfo, 2:Buyer buyer, 3:LoginLog loginLog);

    /* 验证鉴权 */
    result.Result validAuth(1:LoginLog loginLog, 2:AuthInfo authInfo);
    
    /*=================第三方注册登录=======*/
    /*第三方账号登陆*/
    BuyerResult thirdUserSignin(1:LoginLog loginLog, 2:UserInfoThird UserThird, 3:ValidateInfo validateInfo);
    
    /*账号是否已注册及登陆*/
    BuyerResult isExitsThirdUser(1:LoginLog loginLog, 2:ValidateInfo validateInfo);
    
    /*HTTS请求方法*/
    BuyerResult requestHttps(1:string url,2:string extInfo);
    
    
}

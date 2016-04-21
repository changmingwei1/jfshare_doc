namespace java com.jfshare.finagle.thrift.seller

include "result.thrift"

struct Seller {
    1:i32 sellerId,
    2:string loginName,
    3:string sellerName,
	4:string pwdEnc
}

/*登陆请求参数*/
struct LoginLog {
    1:i32 sellerId,
    2:string tokenId, /*令牌标识*/
    3:string ip,
    4:string browser, /*浏览器标识*/
    5:i32 fromSource, /*终端标识*/
    6:i32 loginAuto, /*是否自动登录*/
    7:string loginTime,
    8:string logoutTime,
}

struct SellerResult {
      1:result.Result result,
      2:optional Seller seller,
	  3:LoginLog loginLog,
	  4:optional bool value,
}

/*需要查询出的粒度，0:不需要此信息,1:需要此信息*/
struct SellerRetParam {
	1:i32 baseTag, /*基础信息*/
}

struct SellersResult {
      1:result.Result result,
      2:map<i32, SellerResult> sellerMap, 
}

/*卖家服务*/
service SellerServ {
    /*查询卖家*/
    SellerResult querySeller(1:i32 sellerId, 2:SellerRetParam param);   
     /*批量查询卖家*/
    SellersResult querySellerBatch(1:list<i32> sellerIds, 2:SellerRetParam param);   
	
	/*查询登录名是否存在*/
    result.BoolResult isLoginNameExist(1:string loginName);

    /*注册*/
    result.Result signup(1:Seller seller);

    /*登陆*/
    SellerResult signin(1:Seller seller, 2:LoginLog loginLog);

    /*注销*/
    result.Result signout(1:LoginLog loginLog);

    /*是否登陆*/
    SellerResult isOnline(1:LoginLog loginLog);

    /*获取登陆信息*/
    SellerResult getOnlineInfo(1:LoginLog loginLog);

    /*找回密码*/
    result.StringResult pwdFind(1:i32 findWay, 2:string account);
	
	/*更新卖家信息*/
    result.Result updateSeller(1:Seller seller);
	
	/*重置卖家密码*/
    result.Result resetSellerPwd(1:string newPwd, 2:Seller seller);	
}
namespace java com.jfshare.finagle.thrift.message

include "result.thrift"

/* 系统消息 */
struct SystemMessage{
    1:i32 id,
    2:optional string title,
    3:optional string content,
    4:optional string beginDate,
    5:optional string endDate,
    6:optional i32 status,
    7:optional i32 pushTarget,
    8:optional string createTime
}

struct SystemMessageResult{
    1:result.Result result,
    2:optional list<SystemMessage> messages
}

struct PushMessage{
    1:string title,
    2:string content,
    3:string contentType
}

service MessageServ{
    result.Result addSystemMessage(1:SystemMessage message);
    SystemMessageResult getSystemMessage(1:SystemMessage message);
    result.Result deleteSystemMessage(1:i32 id);
    result.Result updateSystemMessage(1:SystemMessage message);
    result.Result sendPush(1:PushMessage message);
}

namespace java com.jfshare.finagle.thrift.fileNameMapped

include "result.thrift"

struct FileNameMappedInfo {
    1:i32 id,
    2:string filenameMd5,
    3:optional string filename,
    4:optional string fileid,
    5:optional i32 backupState,
    6:optional string backupTime,
    7:optional string source,
}

struct QueryParam {
    1: string filename
}

struct FileNameMappedResult{
	1:result.Result result,
	2:optional FileNameMappedInfo fileNameMappedInfo
}


/*品牌*/
service FileNameMappedServ {

	
	/* 保存文件映射 */
	result.StringResult saveFileNameMappedInfo(1:FileNameMappedInfo fileNameMappedInfo);
	
	/* 获取文件映射 */
	FileNameMappedResult queryFileNameMapped(1:QueryParam queryParam);
}
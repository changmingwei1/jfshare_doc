namespace java com.jfshare.finagle.thrift.manager

include "result.thrift"

struct SlotImage{
	1:i32 id
	2:string imgKey
	3:i32 width
	4:i32 height
	5:string jump
	6:i32 type
	7:string lastUpdateTime
	8:string createTime
	9:i32 isDelete
}

struct QuerySlotImageParam{
	1:i32 type
}

struct QuerySlotImageResult{
      1:result.Result result,
	  2:optional list<SlotImage> slotImageList
	  3:optional SlotImage slotImage
}
﻿SELECT CONCAT("ALTER TABLE ",table_name," ADD `postage` int(11) DEFAULT '0' COMMENT '邮费',ADD `postage_template_id` int(11) DEFAULT '0' COMMENT '运费模板id',ADD `storehouse_id` int(11) DEFAULT '0' COMMENT '仓库id', ADD `thirdExchangeRate` varchar(16) DEFAULT NULL COMMENT '第三方积分抵现比率 如:10，1分抵10分钱';") AS create_sql
FROM information_schema.TABLES WHERE table_name like 'tb_order_info_%'





11111122223333
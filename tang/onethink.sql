--
-- 数据库: `onethink`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_action`
--

CREATE TABLE IF NOT EXISTS `think_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表' AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `think_action`
--

INSERT INTO `think_action` (`id`, `name`, `title`, `remark`, `rule`, `log`, `type`, `status`, `update_time`) VALUES
(1, 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', 1, 1, 1387181220),
(2, 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', 2, 1, 1380173180),
(3, 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', 2, 1, 1383285646),
(4, 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', 2, 1, 1386139726),
(5, 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', 2, 1, 1383285551),
(6, 'update_config', '更新配置', '新增或修改或删除配置', '', '', 1, 1, 1383294988),
(7, 'update_model', '更新模型', '新增或修改模型', '', '', 1, 1, 1383295057),
(8, 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', 1, 1, 1383295963),
(9, 'update_channel', '更新导航', '新增或修改或删除导航', '', '', 1, 1, 1383296301),
(10, 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', 1, 1, 1383296392),
(11, 'update_category', '更新分类', '新增或修改或删除分类', '', '', 1, 1, 1383296765);

-- --------------------------------------------------------

--
-- 表的结构 `think_action_log`
--

CREATE TABLE IF NOT EXISTS `think_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表' AUTO_INCREMENT=1 ;

 

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_extend`
--

CREATE TABLE IF NOT EXISTS `think_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

--
-- 转存表中的数据 `think_auth_extend`
--

INSERT INTO `think_auth_extend` (`group_id`, `extend_id`, `type`) VALUES
(1, 1, 2);
 

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group`
--

CREATE TABLE IF NOT EXISTS `think_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户组表' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `think_auth_group`
--

INSERT INTO `think_auth_group` (`id`, `module`, `type`, `title`, `description`, `status`, `rules`) VALUES
(1, 'admin', 1, '默认用户组', '默认用户组', 1, '1,13,14,113,231'),
(2, 'admin', 1, '测试用户', '测试用户', 1, '1,7,86,87,88,89,90,91,92,93,94,95,96,97,98,99'),
(3, 'admin', 1, '演示组', '演示组', 1, '1');

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `think_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组访问权限表';

--
-- 转存表中的数据 `think_auth_group_access`
--

INSERT INTO `think_auth_group_access` (`uid`, `group_id`) VALUES
(2, 1);
 

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_rule`
--

CREATE TABLE IF NOT EXISTS `think_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='权限规则表' AUTO_INCREMENT=232 ;

--
-- 转存表中的数据 `think_auth_rule`
--

INSERT INTO `think_auth_rule` (`id`, `module`, `type`, `name`, `title`, `status`, `condition`) VALUES
(1, 'admin', 2, 'Admin/Index/index', '首页', 1, ''),
(2, 'admin', 2, 'Admin/AuthManager/index', '权限', 1, ''),
(3, 'admin', 2, 'Admin/User/index', '用户', 1, ''),
(4, 'admin', 2, 'Admin/Config/index', '配置', 1, ''),
(5, 'admin', 2, 'Admin/Menu/index', '系统', 1, ''),
(6, 'admin', 2, 'Admin/Addons/index', '扩展', 1, ''),
(7, 'admin', 2, 'Admin/Article/mydocument', '内容', 1, ''),
(8, 'admin', 2, 'Admin/Attribute/index', '其他', 1, ''),
(9, 'admin', 2, 'Admin/Other/index', '备用菜单', -1, ''),
(10, 'admin', 1, 'Admin/Action/actionlog', '行为日志', 1, ''),
(11, 'admin', 1, 'Admin/Action/edit', '查看行为日志', 1, ''),
(12, 'admin', 1, 'Admin/User/index', '用户信息', 1, ''),
(13, 'admin', 1, 'Admin/User/updatePassword', '修改密码', 1, ''),
(14, 'admin', 1, 'Admin/User/updateNickname', '修改昵称', 1, ''),
(15, 'admin', 1, 'Admin/User/add', '新增用户', 1, ''),
(16, 'admin', 1, 'Admin/User/action', '用户行为', 1, ''),
(17, 'admin', 1, 'Admin/User/addaction', '新增用户行为', 1, ''),
(18, 'admin', 1, 'Admin/User/editaction', '编辑用户行为', 1, ''),
(19, 'admin', 1, 'Admin/User/saveAction', '保存用户行为', 1, ''),
(20, 'admin', 1, 'Admin/User/setStatus', '变更行为状态', 1, ''),
(21, 'admin', 1, 'Admin/User/changeStatus?method=forbidUser', '禁用会员', 1, ''),
(22, 'admin', 1, 'Admin/User/changeStatus?method=resumeUser', '启用会员', 1, ''),
(23, 'admin', 1, 'Admin/User/changeStatus?method=deleteUser', '删除会员', 1, ''),
(24, 'admin', 1, 'Admin/AuthManager/index', '权限管理', 1, ''),
(25, 'admin', 1, 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', 1, ''),
(26, 'admin', 1, 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', 1, ''),
(27, 'admin', 1, 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', 1, ''),
(28, 'admin', 1, 'Admin/AuthManager/createGroup', '新增', 1, ''),
(29, 'admin', 1, 'Admin/AuthManager/editGroup', '编辑', 1, ''),
(30, 'admin', 1, 'Admin/AuthManager/writeGroup', '保存用户组', 1, ''),
(31, 'admin', 1, 'Admin/AuthManager/group', '授权', 1, ''),
(32, 'admin', 1, 'Admin/AuthManager/access', '访问授权', 1, ''),
(33, 'admin', 1, 'Admin/AuthManager/user', '成员授权', 1, ''),
(34, 'admin', 1, 'Admin/AuthManager/removeFromGroup', '解除授权', 1, ''),
(35, 'admin', 1, 'Admin/AuthManager/addToGroup', '保存成员授权', 1, ''),
(36, 'admin', 1, 'Admin/AuthManager/category', '分类授权', 1, ''),
(37, 'admin', 1, 'Admin/AuthManager/addToCategory', '保存分类授权', 1, ''),
(38, 'admin', 1, 'Admin/AuthManager/modelauth', '模型授权', 1, ''),
(39, 'admin', 1, 'Admin/AuthManager/addToModel', '保存模型授权', 1, ''),
(40, 'admin', 1, 'Admin/Menu/index', '后台菜单', 1, ''),
(41, 'admin', 1, 'Admin/Menu/add', '新增', 1, ''),
(42, 'admin', 1, 'Admin/Menu/edit', '编辑', 1, ''),
(43, 'admin', 1, 'Admin/Menu/sort', '排序', 1, ''),
(44, 'admin', 1, 'Admin/Menu/import', '导入', 1, ''),
(45, 'admin', 1, 'Admin/Channel/index', '前台菜单', 1, ''),
(46, 'admin', 1, 'Admin/Channel/add', '新增', 1, ''),
(47, 'admin', 1, 'Admin/Channel/edit', '编辑', 1, ''),
(48, 'admin', 1, 'Admin/Channel/del', '删除', 1, ''),
(49, 'admin', 1, 'Admin/Channel/sort', '排序', 1, ''),
(50, 'admin', 1, 'Admin/Config/edit', '编辑', 1, ''),
(51, 'admin', 1, 'Admin/Config/del', '删除', 1, ''),
(52, 'admin', 1, 'Admin/Config/add', '新增', 1, ''),
(53, 'admin', 1, 'Admin/Config/save', '保存', 1, ''),
(54, 'admin', 1, 'Admin/Config/sort', '排序', 1, ''),
(55, 'admin', 1, 'Admin/Model/index', '模型管理', 1, ''),
(56, 'admin', 1, 'Admin/Model/add', '新增', 1, ''),
(57, 'admin', 1, 'Admin/Model/edit', '编辑', 1, ''),
(58, 'admin', 1, 'Admin/Model/setStatus', '改变状态', 1, ''),
(59, 'admin', 1, 'Admin/Model/update', '保存数据', 1, ''),
(60, 'admin', 1, 'Admin/Model/generate', '生成', 1, ''),
(61, 'admin', 1, 'Admin/Addons/index', '插件管理', 1, ''),
(62, 'admin', 1, 'Admin/Addons/checkForm', '检测创建', 1, ''),
(63, 'admin', 1, 'Admin/Addons/preview', '预览', 1, ''),
(64, 'admin', 1, 'Admin/Addons/build', '快速生成插件', 1, ''),
(65, 'admin', 1, 'Admin/Addons/config', '设置', 1, ''),
(66, 'admin', 1, 'Admin/Addons/disable', '禁用', 1, ''),
(67, 'admin', 1, 'Admin/Addons/enable', '启用', 1, ''),
(68, 'admin', 1, 'Admin/Addons/install', '安装', 1, ''),
(69, 'admin', 1, 'Admin/Addons/uninstall', '卸载', 1, ''),
(70, 'admin', 1, 'Admin/Addons/saveconfig', '更新配置', 1, ''),
(71, 'admin', 1, 'Admin/Addons/adminList', '插件后台列表', 1, ''),
(72, 'admin', 1, 'Admin/Addons/execute', 'URL方式访问插件', 1, ''),
(73, 'admin', 1, 'Admin/Addons/hooks', '钩子管理', 1, ''),
(74, 'admin', 1, 'Admin/Addons/addHook', '新增钩子', 1, ''),
(75, 'admin', 1, 'Admin/Addons/edithook', '编辑钩子', 1, ''),
(76, 'admin', 1, 'Admin/Addons/create', '创建', 1, ''),
(77, 'admin', 1, 'Admin/Database/index?type=export', '备份数据库', 1, ''),
(78, 'admin', 1, 'Admin/Database/optimize', '优化表', 1, ''),
(79, 'admin', 1, 'Admin/Database/repair', '修复表', 1, ''),
(80, 'admin', 1, 'Admin/Database/index?type=import', '还原数据库', 1, ''),
(81, 'admin', 1, 'Admin/Database/export', '备份', 1, ''),
(82, 'admin', 1, 'Admin/Think/lists?model=download', '下载管理', 1, ''),
(83, 'admin', 1, 'Admin/Think/lists?model=config', '配置管理', 1, ''),
(84, 'admin', 1, 'Admin/Think/add', '新增数据', 1, ''),
(85, 'admin', 1, 'Admin/Think/edit', '编辑数据', 1, ''),
(86, 'admin', 1, 'Admin/Article/index', '文档列表', 1, ''),
(87, 'admin', 1, 'Admin/Article/add', '新增', 1, ''),
(88, 'admin', 1, 'Admin/Article/edit', '编辑', 1, ''),
(89, 'admin', 1, 'Admin/Article/setStatus', '改变状态', 1, ''),
(90, 'admin', 1, 'Admin/Article/update', '保存', 1, ''),
(91, 'admin', 1, 'Admin/Article/autoSave', '保存草稿', 1, ''),
(92, 'admin', 1, 'Admin/Article/move', '移动', 1, ''),
(93, 'admin', 1, 'Admin/Article/copy', '复制', 1, ''),
(94, 'admin', 1, 'Admin/Article/paste', '粘贴', 1, ''),
(95, 'admin', 1, 'Admin/Article/batchOperate', '导入', 1, ''),
(96, 'admin', 1, 'Admin/Article/recycle', '回收站', 1, ''),
(97, 'admin', 1, 'Admin/Article/permit', '还原', 1, ''),
(98, 'admin', 1, 'Admin/Article/clear', '清空', 1, ''),
(99, 'admin', 1, 'Admin/Article/sort', '文档排序', 1, ''),
(100, 'admin', 1, 'Admin/Attribute/add', '新增', 1, ''),
(101, 'admin', 1, 'Admin/Attribute/edit', '编辑', 1, ''),
(102, 'admin', 1, 'Admin/Attribute/setStatus', '改变状态', 1, ''),
(103, 'admin', 1, 'Admin/Attribute/update', '保存数据', 1, ''),
(104, 'admin', 1, 'Admin/Category/edit', '编辑', 1, ''),
(105, 'admin', 1, 'Admin/Category/add', '新增', 1, ''),
(106, 'admin', 1, 'Admin/Category/remove', '删除', 1, ''),
(107, 'admin', 1, 'Admin/Category/operate/type/move', '移动', 1, ''),
(108, 'admin', 1, 'Admin/Category/operate/type/merge', '合并', 1, ''),
(109, 'admin', 1, 'Admin/Database/import', '恢复', 1, ''),
(110, 'admin', 1, 'Admin/Database/del', '删除', 1, ''),
(111, 'admin', 1, 'Admin/Category/index', '分类管理', 1, ''),
(112, 'admin', 1, 'Admin/Attribute/index', '属性管理', 1, ''),
(113, 'admin', 1, 'Admin/Other/index', '备用菜单项', 1, ''),
(114, 'admin', 1, 'Admin/Config/index', '配置内容', 1, ''),
(115, 'admin', 1, 'Admin/Config/group', '网站设置', 1, ''),
(116, 'admin', 2, 'Home/Index/index', '首页', -1, ''),
(117, 'admin', 2, 'Home/AuthManager/index', '权限', -1, ''),
(118, 'admin', 2, 'Home/User/index', '用户', -1, ''),
(119, 'admin', 2, 'Home/Config/index', '配置', -1, ''),
(120, 'admin', 2, 'Home/Menu/index', '系统', -1, ''),
(121, 'admin', 2, 'Home/Addons/index', '扩展', -1, ''),
(122, 'admin', 2, 'Home/Article/mydocument', '内容', -1, ''),
(123, 'admin', 2, 'Home/Attribute/index', '其他', -1, ''),
(124, 'admin', 2, 'Home/Other/index', '备用菜单', -1, ''),
(125, 'admin', 1, 'Home/Action/actionlog', '行为日志', -1, ''),
(126, 'admin', 1, 'Home/Action/edit', '查看行为日志', -1, ''),
(127, 'admin', 1, 'Home/User/index', '用户信息', -1, ''),
(128, 'admin', 1, 'Home/User/updatePassword', '修改密码', -1, ''),
(129, 'admin', 1, 'Home/User/updateNickname', '修改昵称', -1, ''),
(130, 'admin', 1, 'Home/User/add', '新增用户', -1, ''),
(131, 'admin', 1, 'Home/User/action', '用户行为', -1, ''),
(132, 'admin', 1, 'Home/User/addaction', '新增用户行为', -1, ''),
(133, 'admin', 1, 'Home/User/editaction', '编辑用户行为', -1, ''),
(134, 'admin', 1, 'Home/User/saveAction', '保存用户行为', -1, ''),
(135, 'admin', 1, 'Home/User/setStatus', '变更行为状态', -1, ''),
(136, 'admin', 1, 'Home/User/changeStatus?method=forbidUser', '禁用会员', -1, ''),
(137, 'admin', 1, 'Home/User/changeStatus?method=resumeUser', '启用会员', -1, ''),
(138, 'admin', 1, 'Home/User/changeStatus?method=deleteUser', '删除会员', -1, ''),
(139, 'admin', 1, 'Home/AuthManager/index', '权限管理', -1, ''),
(140, 'admin', 1, 'Home/AuthManager/changeStatus?method=deleteGroup', '删除', -1, ''),
(141, 'admin', 1, 'Home/AuthManager/changeStatus?method=forbidGroup', '禁用', -1, ''),
(142, 'admin', 1, 'Home/AuthManager/changeStatus?method=resumeGroup', '恢复', -1, ''),
(143, 'admin', 1, 'Home/AuthManager/createGroup', '新增', -1, ''),
(144, 'admin', 1, 'Home/AuthManager/editGroup', '编辑', -1, ''),
(145, 'admin', 1, 'Home/AuthManager/writeGroup', '保存用户组', -1, ''),
(146, 'admin', 1, 'Home/AuthManager/group', '授权', -1, ''),
(147, 'admin', 1, 'Home/AuthManager/access', '访问授权', -1, ''),
(148, 'admin', 1, 'Home/AuthManager/user', '成员授权', -1, ''),
(149, 'admin', 1, 'Home/AuthManager/removeFromGroup', '解除授权', -1, ''),
(150, 'admin', 1, 'Home/AuthManager/addToGroup', '保存成员授权', -1, ''),
(151, 'admin', 1, 'Home/AuthManager/category', '分类授权', -1, ''),
(152, 'admin', 1, 'Home/AuthManager/addToCategory', '保存分类授权', -1, ''),
(153, 'admin', 1, 'Home/AuthManager/modelauth', '模型授权', -1, ''),
(154, 'admin', 1, 'Home/AuthManager/addToModel', '保存模型授权', -1, ''),
(155, 'admin', 1, 'Home/Menu/index', '后台菜单', -1, ''),
(156, 'admin', 1, 'Home/Menu/add', '新增', -1, ''),
(157, 'admin', 1, 'Home/Menu/edit', '编辑', -1, ''),
(158, 'admin', 1, 'Home/Menu/sort', '排序', -1, ''),
(159, 'admin', 1, 'Home/Menu/import', '导入', -1, ''),
(160, 'admin', 1, 'Home/Channel/index', '前台菜单', -1, ''),
(161, 'admin', 1, 'Home/Channel/add', '新增', -1, ''),
(162, 'admin', 1, 'Home/Channel/edit', '编辑', -1, ''),
(163, 'admin', 1, 'Home/Channel/del', '删除', -1, ''),
(164, 'admin', 1, 'Home/Channel/sort', '排序', -1, ''),
(165, 'admin', 1, 'Home/Config/edit', '编辑', -1, ''),
(166, 'admin', 1, 'Home/Config/del', '删除', -1, ''),
(167, 'admin', 1, 'Home/Config/add', '新增', -1, ''),
(168, 'admin', 1, 'Home/Config/save', '保存', -1, ''),
(169, 'admin', 1, 'Home/Config/sort', '排序', -1, ''),
(170, 'admin', 1, 'Home/Model/index', '模型管理', -1, ''),
(171, 'admin', 1, 'Home/Model/add', '新增', -1, ''),
(172, 'admin', 1, 'Home/Model/edit', '编辑', -1, ''),
(173, 'admin', 1, 'Home/Model/setStatus', '改变状态', -1, ''),
(174, 'admin', 1, 'Home/Model/update', '保存数据', -1, ''),
(175, 'admin', 1, 'Home/Model/generate', '生成', -1, ''),
(176, 'admin', 1, 'Home/Addons/index', '插件管理', -1, ''),
(177, 'admin', 1, 'Home/Addons/checkForm', '检测创建', -1, ''),
(178, 'admin', 1, 'Home/Addons/preview', '预览', -1, ''),
(179, 'admin', 1, 'Home/Addons/build', '快速生成插件', -1, ''),
(180, 'admin', 1, 'Home/Addons/config', '设置', -1, ''),
(181, 'admin', 1, 'Home/Addons/disable', '禁用', -1, ''),
(182, 'admin', 1, 'Home/Addons/enable', '启用', -1, ''),
(183, 'admin', 1, 'Home/Addons/install', '安装', -1, ''),
(184, 'admin', 1, 'Home/Addons/uninstall', '卸载', -1, ''),
(185, 'admin', 1, 'Home/Addons/saveconfig', '更新配置', -1, ''),
(186, 'admin', 1, 'Home/Addons/adminList', '插件后台列表', -1, ''),
(187, 'admin', 1, 'Home/Addons/execute', 'URL方式访问插件', -1, ''),
(188, 'admin', 1, 'Home/Addons/hooks', '钩子管理', -1, ''),
(189, 'admin', 1, 'Home/Addons/addHook', '新增钩子', -1, ''),
(190, 'admin', 1, 'Home/Addons/edithook', '编辑钩子', -1, ''),
(191, 'admin', 1, 'Home/Addons/create', '创建', -1, ''),
(192, 'admin', 1, 'Home/Database/index?type=export', '备份数据库', -1, ''),
(193, 'admin', 1, 'Home/Database/optimize', '优化表', -1, ''),
(194, 'admin', 1, 'Home/Database/repair', '修复表', -1, ''),
(195, 'admin', 1, 'Home/Database/index?type=import', '还原数据库', -1, ''),
(196, 'admin', 1, 'Home/Database/export', '备份', -1, ''),
(197, 'admin', 1, 'Home/Think/lists?model=download', '下载管理', -1, ''),
(198, 'admin', 1, 'Home/Think/lists?model=config', '配置管理', -1, ''),
(199, 'admin', 1, 'Home/Think/add', '新增数据', -1, ''),
(200, 'admin', 1, 'Home/Think/edit', '编辑数据', -1, ''),
(201, 'admin', 1, 'Home/Article/index', '文档列表', -1, ''),
(202, 'admin', 1, 'Home/Article/add', '新增', -1, ''),
(203, 'admin', 1, 'Home/Article/edit', '编辑', -1, ''),
(204, 'admin', 1, 'Home/Article/setStatus', '改变状态', -1, ''),
(205, 'admin', 1, 'Home/Article/update', '保存', -1, ''),
(206, 'admin', 1, 'Home/Article/autoSave', '保存草稿', -1, ''),
(207, 'admin', 1, 'Home/Article/move', '移动', -1, ''),
(208, 'admin', 1, 'Home/Article/copy', '复制', -1, ''),
(209, 'admin', 1, 'Home/Article/paste', '粘贴', -1, ''),
(210, 'admin', 1, 'Home/Article/batchOperate', '导入', -1, ''),
(211, 'admin', 1, 'Home/Article/recycle', '回收站', -1, ''),
(212, 'admin', 1, 'Home/Article/permit', '还原', -1, ''),
(213, 'admin', 1, 'Home/Article/clear', '清空', -1, ''),
(214, 'admin', 1, 'Home/Article/sort', '文档排序', -1, ''),
(215, 'admin', 1, 'Home/Attribute/add', '新增', -1, ''),
(216, 'admin', 1, 'Home/Attribute/edit', '编辑', -1, ''),
(217, 'admin', 1, 'Home/Attribute/setStatus', '改变状态', -1, ''),
(218, 'admin', 1, 'Home/Attribute/update', '保存数据', -1, ''),
(219, 'admin', 1, 'Home/Category/edit', '编辑', -1, ''),
(220, 'admin', 1, 'Home/Category/add', '新增', -1, ''),
(221, 'admin', 1, 'Home/Category/remove', '删除', -1, ''),
(222, 'admin', 1, 'Home/Category/operate/type/move', '移动', -1, ''),
(223, 'admin', 1, 'Home/Category/operate/type/merge', '合并', -1, ''),
(224, 'admin', 1, 'Home/Database/import', '恢复', -1, ''),
(225, 'admin', 1, 'Home/Database/del', '删除', -1, ''),
(226, 'admin', 1, 'Home/Category/index', '分类管理', -1, ''),
(227, 'admin', 1, 'Home/Attribute/index', '属性管理', -1, ''),
(228, 'admin', 1, 'Home/Other/index', '备用菜单项', -1, ''),
(229, 'admin', 1, 'Home/Config/index', '配置内容', -1, ''),
(230, 'admin', 1, 'Home/Config/group', '网站设置', -1, ''),
(231, 'admin', 2, 'Admin/Auth/index', '备用菜单', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `think_category`
--

CREATE TABLE IF NOT EXISTS `think_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='分类表' AUTO_INCREMENT=44 ;

--
-- 转存表中的数据 `think_category`
--

INSERT INTO `think_category` (`id`, `name`, `title`, `pid`, `sort`, `list_row`, `meta_title`, `keywords`, `description`, `template_index`, `template_lists`, `template_detail`, `template_edit`, `model`, `type`, `link_id`, `allow_publish`, `display`, `reply`, `check`, `reply_model`, `extend`, `create_time`, `update_time`, `status`, `icon`) VALUES
(1, 'blog', '分类--二级', 0, 0, 10, '', '', '', '', '', '', '', '2,3', '2,1,3', 0, 0, 1, 0, 0, '1', '', 1379474947, 1393927489, 1, 0),
(2, 'default_blog', '三级分类菜单', 1, 0, 10, '', '', '', '', '', '', '', '2,3', '2,1,3', 0, 1, 1, 0, 1, '1', '', 1379475028, 1394027030, 1, 31),
(39, 'third', '三级分类', 1, 0, 10, '', '', '', '', '', '', '', '', '', 0, 1, 1, 1, 0, '', '', 1393855477, 1393855477, 1, 0),
(41, 'item04', '五级分类0', 42, 0, 10, '', '', '', '', '', '', '', '2,3', '2,1,3', 0, 1, 1, 1, 0, '', '', 1393855583, 1393925546, 1, 0),
(42, 'item00502', '四级分类', 39, 0, 10, '', '', '', '', '', '', '', '2,3', '2', 0, 1, 1, 1, 1, '', '', 1393897391, 1393909771, 1, 0),
(43, 'item04002', '四级内容', 2, 0, 10, '', '', '', '', '', '', '', '2,3', '2,1,3', 0, 1, 1, 1, 0, '', '', 1393897434, 1394027014, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `think_channel`
--

CREATE TABLE IF NOT EXISTS `think_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='前台菜单表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `think_channel`
--

INSERT INTO `think_channel` (`id`, `pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`) VALUES
(1, 0, '首页', 'Index/index', 1, 1379475111, 1379923177, 1, 0),
(2, 0, '博客', 'Article/index?category=blog', 2, 1379475131, 1379483713, 1, 0),
(3, 0, '官网', 'http://www.onethink.cn', 3, 1379475154, 1387163458, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `think_config`
--

CREATE TABLE IF NOT EXISTS `think_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='配置表' AUTO_INCREMENT=27 ;

--
-- 转存表中的数据 `think_config`
--

INSERT INTO `think_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(1, 'WEB_SITE_TITLE', 1, '网站标题', 1, '', '网站标题前台显示标题', 1378898976, 1393805612, 1, '管理框架', 0),
(2, 'WEB_SITE_DESCRIPTION', 2, '网站描述', 1, '', '网站搜索引擎描述', 1378898976, 1379235841, 1, 'OneThink内容管理框架', 1),
(3, 'WEB_SITE_KEYWORD', 2, '网站关键字', 1, '', '网站搜索引擎关键字', 1378898976, 1381390100, 1, 'ThinkPHP,OneThink', 8),
(4, 'WEB_SITE_CLOSE', 4, '关闭站点', 1, '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', 1378898976, 1379235296, 1, '1', 1),
(5, 'CONFIG_TYPE_LIST', 3, '配置类型列表', 4, '', '主要用于数据解析和页面表单的生成', 1378898976, 1379235348, 1, '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', 2),
(6, 'WEB_SITE_ICP', 1, '网站备案号', 1, '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', 1378900335, 1379235859, 1, '', 9),
(7, 'DOCUMENT_POSITION', 3, '文档推荐位', 2, '', '文档推荐位，推荐到多个位置KEY值相加即可', 1379053380, 1379235329, 1, '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', 3),
(8, 'DOCUMENT_DISPLAY', 3, '文档可见性', 2, '', '文章可见性仅影响前台显示，后台不收影响', 1379056370, 1379235322, 1, '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', 4),
(9, 'COLOR_STYLE', 4, '后台色系', 1, 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', 1379122533, 1379235904, 1, 'default_color', 10),
(10, 'CONFIG_GROUP_LIST', 3, '配置分组', 4, '', '配置分组', 1379228036, 1384418383, 1, '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', 4),
(11, 'HOOKS_TYPE', 3, '钩子的类型', 4, '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', 1379313397, 1379313407, 1, '1:视图\r\n2:控制器', 6),
(12, 'AUTH_CONFIG', 3, 'Auth配置', 4, '', '自定义Auth.class.php类配置', 1379409310, 1379409564, 1, 'AUTH_ON:1\r\nAUTH_TYPE:2', 8),
(13, 'OPEN_DRAFTBOX', 4, '是否开启草稿功能', 2, '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', 1379484332, 1379484591, 1, '1', 1),
(15, 'LIST_ROWS', 0, '后台每页记录数', 2, '', '后台数据每页显示记录数', 1379503896, 1393927984, 1, '1000', 10),
(16, 'USER_ALLOW_REGISTER', 4, '是否允许用户注册', 3, '0:关闭注册\r\n1:允许注册', '是否开放用户注册', 1379504487, 1379504580, 1, '1', 3),
(17, 'CODEMIRROR_THEME', 4, '预览插件的CodeMirror主题', 4, '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', 1379814385, 1384740813, 1, 'ambiance', 3),
(18, 'DATA_BACKUP_PATH', 1, '数据库备份根路径', 4, '', '路径必须以 / 结尾', 1381482411, 1381482411, 1, './Data/', 5),
(19, 'DATA_BACKUP_PART_SIZE', 0, '数据库备份卷大小', 4, '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', 1381482488, 1381729564, 1, '20971520', 7),
(20, 'DATA_BACKUP_COMPRESS', 4, '数据库备份文件是否启用压缩', 4, '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', 1381713345, 1381729544, 1, '1', 9),
(21, 'DATA_BACKUP_COMPRESS_LEVEL', 4, '数据库备份文件压缩级别', 4, '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', 1381713408, 1381713408, 1, '9', 10),
(22, 'DEVELOP_MODE', 4, '开启开发者模式', 4, '0:关闭\r\n1:开启', '是否开启开发者模式', 1383105995, 1383291877, 1, '1', 11),
(23, 'ALLOW_VISIT', 3, '不受限控制器方法', 0, '', '', 1386644047, 1386644741, 1, '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', 0),
(24, 'DENY_VISIT', 3, '超管专限控制器方法', 0, '', '仅超级管理员可访问的控制器方法', 1386644141, 1386644659, 1, '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', 0),
(25, 'REPLY_LIST_ROWS', 0, '回复列表每页条数', 2, '', '', 1386645376, 1393766966, 1, '1000', 0),
(26, 'ADMIN_ALLOW_IP', 2, '后台允许访问IP', 4, '', '多个用逗号分隔，如果不配置表示不限制IP访问', 1387165454, 1387165553, 1, '', 12);

-- --------------------------------------------------------

--
-- 表的结构 `think_member`
--

CREATE TABLE IF NOT EXISTS `think_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `email` varchar(32) NOT NULL COMMENT '邮箱',
  `moblie` varchar(15) NOT NULL COMMENT '手机号码',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户信息表' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `think_member`
--

INSERT INTO `think_member` (`uid`, `nickname`, `password`, `email`, `moblie`, `sex`, `birthday`, `qq`, `score`, `login`, `reg_ip`, `reg_time`, `last_login_ip`, `last_login_time`, `status`) VALUES
(1, 'admin', '13010678e23efe96fe5d460289544df0', 'a@b.com', '', 0, '0000-00-00', '', 0, 0, 0, 0, 2130706433, 1395304408, 1);
 
-- --------------------------------------------------------

--
-- 表的结构 `think_menu`
--

CREATE TABLE IF NOT EXISTS `think_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='后台菜单表' AUTO_INCREMENT=121 ;

--
-- 转存表中的数据 `think_menu`
--

INSERT INTO `think_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
(1, '首页', 0, 0, 'Index/index', 0, '', '', 0),
(2, '权限', 0, 0, 'AuthManager/index', 0, '权限管理', '', 0),
(3, '用户', 0, 0, 'User/index', 0, '', '', 0),
(4, '配置', 0, 0, 'Config/index', 0, '', '', 0),
(5, '系统', 0, 0, 'Menu/index', 0, '', '', 0),
(6, '扩展', 0, 0, 'Addons/index', 0, '', '', 0),
(7, '内容', 0, 0, 'Article/mydocument', 0, '', '', 0),
(8, '其他', 0, 0, 'Attribute/index', 0, '前台相关', '', 0),
(9, '备用菜单', 0, 0, 'Auth/index', 1, '备用', '', 0),
(10, '行为日志', 3, 0, 'Action/actionlog', 0, '', '日志管理', 0),
(11, '查看日志', 1, 0, 'Action/edit', 1, '', '', 0),
(12, '用户信息', 3, 0, 'User/index', 0, '', '用户管理', 0),
(13, '修改手机', 12, 0, 'User/updatePassword', 0, '修改手机号码', '', 0),
(14, '修改用户资料', 12, 0, 'User/updateNickname', 0, '修改用户资料', '', 0),
(15, '查看行为日志', 10, 0, 'Action/edit', 0, '查看行为日志', '', 0),
(16, '新增用户', 12, 0, 'User/add', 0, '添加新用户', '', 0),
(17, '修改密码', 1, 0, 'User/updatePassword', 1, '修改密码', '', 0),
(18, '修改昵称', 1, 0, 'User/updateNickname', 1, '修改昵称', '', 0),
(19, '用户行为', 3, 0, 'User/action', 0, '', '用户管理', 0),
(20, '新增用户行为', 19, 0, 'User/addaction', 0, '', '', 0),
(21, '编辑用户行为', 19, 0, 'User/editaction', 0, '', '', 0),
(22, '保存用户行为', 19, 0, 'User/saveAction', 0, '"用户->用户行为"保存编辑和新增的用户行为', '', 0),
(23, '变更行为状态', 19, 0, 'User/setStatus', 0, '"用户->用户行为"中的启用,禁用和删除权限', '', 0),
(24, '禁用会员', 19, 0, 'User/changeStatus?method=forbidUser', 0, '"用户->用户信息"中的禁用', '', 0),
(25, '启用会员', 19, 0, 'User/changeStatus?method=resumeUser', 0, '"用户->用户信息"中的启用', '', 0),
(26, '删除会员', 19, 0, 'User/changeStatus?method=deleteUser', 0, '"用户->用户信息"中的删除', '', 0),
(27, '权限管理', 2, 0, 'AuthManager/index', 0, '权限管理', '权限管理', 0),
(28, '删除', 27, 0, 'AuthManager/changeStatus?method=deleteGroup', 0, '删除用户组', '', 0),
(29, '禁用', 27, 0, 'AuthManager/changeStatus?method=forbidGroup', 0, '禁用用户组', '', 0),
(30, '恢复', 27, 0, 'AuthManager/changeStatus?method=resumeGroup', 0, '恢复已禁用的用户组', '', 0),
(31, '新增', 27, 0, 'AuthManager/createGroup', 0, '创建新的用户组', '', 0),
(32, '编辑', 27, 0, 'AuthManager/editGroup', 0, '编辑用户组名称和描述', '', 0),
(33, '保存用户组', 27, 0, 'AuthManager/writeGroup', 0, '新增和编辑用户组的"保存"按钮', '', 0),
(34, '授权', 27, 0, 'AuthManager/group', 0, '"后台 \\ 用户 \\ 用户信息"列表页的"授权"操作按钮,用于设置用户所属用户组', '', 0),
(35, '访问授权', 27, 0, 'AuthManager/access', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"访问授权"操作按钮', '', 0),
(36, '成员授权', 27, 0, 'AuthManager/user', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"成员授权"操作按钮', '', 0),
(37, '解除授权', 27, 0, 'AuthManager/removeFromGroup', 0, '"成员授权"列表页内的解除授权操作按钮', '', 0),
(38, '保存成员授权', 27, 0, 'AuthManager/addToGroup', 0, '"用户信息"列表页"授权"时的"保存"按钮和"成员授权"里右上角的"添加"按钮)', '', 0),
(39, '分类授权', 27, 0, 'AuthManager/category', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"分类授权"操作按钮', '', 0),
(40, '保存分类授权', 27, 0, 'AuthManager/addToCategory', 0, '"分类授权"页面的"保存"按钮', '', 0),
(41, '模型授权', 27, 0, 'AuthManager/modelauth', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"模型授权"操作按钮', '', 0),
(42, '保存模型授权', 27, 0, 'AuthManager/addToModel', 0, '"分类授权"页面的"保存"按钮', '', 0),
(43, '后台菜单', 5, 0, 'Menu/index', 0, '', '菜单管理', 0),
(44, '新增', 43, 0, 'Menu/add', 0, '', '', 0),
(45, '编辑', 43, 0, 'Menu/edit', 0, '', '', 0),
(46, '排序', 43, 0, 'Menu/sort', 1, '', '', 0),
(47, '导入', 43, 0, 'Menu/import', 0, '', '', 0),
(48, '前台菜单', 5, 0, 'Channel/index', 0, '', '菜单管理', 0),
(49, '新增', 48, 0, 'Channel/add', 0, '', '', 0),
(50, '编辑', 48, 0, 'Channel/edit', 0, '', '', 0),
(51, '删除', 48, 0, 'Channel/del', 0, '', '', 0),
(52, '排序', 48, 0, 'Channel/sort', 1, '', '', 0),
(53, '配置内容', 4, 1, 'Config/index', 0, '', '配置管理', 0),
(54, '网站设置', 4, 2, 'Config/group', 0, '', '配置管理', 0),
(55, '编辑', 53, 0, 'Config/edit', 0, '新增编辑和保存配置', '', 0),
(56, '删除', 53, 0, 'Config/del', 0, '删除配置', '', 0),
(57, '新增', 53, 0, 'Config/add', 0, '新增配置', '', 0),
(58, '保存', 53, 0, 'Config/save', 0, '保存配置', '', 0),
(59, '排序', 53, 0, 'Config/sort', 1, '', '', 0),
(60, '模型管理', 8, 0, 'Model/index', 0, '', '数据库', 0),
(61, '新增', 60, 0, 'Model/add', 0, '', '', 0),
(62, '编辑', 60, 0, 'Model/edit', 0, '', '', 0),
(63, '改变状态', 60, 0, 'Model/setStatus', 0, '', '', 0),
(64, '保存数据', 60, 0, 'Model/update', 0, '', '', 0),
(65, '生成', 60, 0, 'Model/generate', 0, '', '', 0),
(66, '插件管理', 6, 0, 'Addons/index', 0, '', '扩展', 0),
(67, '检测创建', 66, 0, 'Addons/checkForm', 0, '检测插件是否可以创建', '', 0),
(68, '预览', 66, 0, 'Addons/preview', 0, '预览插件定义类文件', '', 0),
(69, '快速生成插件', 66, 0, 'Addons/build', 0, '开始生成插件结构', '', 0),
(70, '设置', 66, 0, 'Addons/config', 0, '设置插件配置', '', 0),
(71, '禁用', 66, 0, 'Addons/disable', 0, '禁用插件', '', 0),
(72, '启用', 66, 0, 'Addons/enable', 0, '启用插件', '', 0),
(73, '安装', 66, 0, 'Addons/install', 0, '安装插件', '', 0),
(74, '卸载', 66, 0, 'Addons/uninstall', 0, '卸载插件', '', 0),
(75, '更新配置', 66, 0, 'Addons/saveconfig', 0, '更新插件配置处理', '', 0),
(76, '插件后台列表', 66, 0, 'Addons/adminList', 0, '', '', 0),
(77, 'URL方式访问插件', 66, 0, 'Addons/execute', 0, '控制是否有权限通过url访问插件控制器方法', '', 0),
(78, '钩子管理', 6, 0, 'Addons/hooks', 0, '', '扩展', 0),
(79, '新增钩子', 78, 0, 'Addons/addHook', 0, '', '', 0),
(80, '编辑钩子', 78, 0, 'Addons/edithook', 0, '', '', 0),
(81, '创建', 66, 0, 'Addons/create', 0, '服务器上创建插件结构向导', '', 0),
(82, '备份数据库', 5, 0, 'Database/index?type=export', 0, '备份数据库', '数据备份', 0),
(83, '优化表', 82, 0, 'Database/optimize', 0, '优化数据表', '', 0),
(84, '修复表', 82, 0, 'Database/repair', 0, '修复数据表', '', 0),
(85, '还原数据库', 5, 0, 'Database/index?type=import', 0, '数据库恢复', '数据备份', 0),
(86, '备份', 82, 0, 'Database/export', 0, '备份', '', 0),
(87, '下载管理', 60, 0, 'Think/lists?model=download', 0, '', '', 0),
(88, '配置管理', 60, 0, 'Think/lists?model=config', 0, '', '', 0),
(89, '新增数据', 60, 0, 'Think/add', 1, '', '', 0),
(90, '编辑数据', 60, 0, 'Think/edit', 1, '', '', 0),
(91, '文档列表', 7, 0, 'Article/index', 1, '', '内容', 0),
(92, '新增', 91, 0, 'Article/add', 0, '', '', 0),
(93, '编辑', 91, 0, 'Article/edit', 0, '', '', 0),
(94, '改变状态', 91, 0, 'Article/setStatus', 0, '', '', 0),
(95, '保存', 91, 0, 'Article/update', 0, '', '', 0),
(96, '保存草稿', 91, 0, 'Article/autoSave', 0, '', '', 0),
(97, '移动', 91, 0, 'Article/move', 0, '', '', 0),
(98, '复制', 91, 0, 'Article/copy', 0, '', '', 0),
(99, '粘贴', 91, 0, 'Article/paste', 0, '', '', 0),
(100, '导入', 91, 0, 'Article/batchOperate', 0, '', '', 0),
(101, '回收站', 7, 0, 'Article/recycle', 0, '', '内容', 0),
(102, '还原', 91, 0, 'Article/permit', 0, '', '', 0),
(103, '清空', 91, 0, 'Article/clear', 0, '', '', 0),
(104, '文档排序', 91, 0, 'Article/sort', 1, '', '', 0),
(105, '新增', 117, 0, 'Attribute/add', 0, '', '', 0),
(106, '编辑', 117, 0, 'Attribute/edit', 0, '', '', 0),
(107, '改变状态', 117, 0, 'Attribute/setStatus', 0, '', '', 0),
(108, '保存数据', 117, 0, 'Attribute/update', 0, '', '', 0),
(109, '编辑', 116, 0, 'Category/edit', 0, '编辑和保存栏目分类', '', 0),
(110, '新增', 116, 0, 'Category/add', 0, '新增栏目分类', '', 0),
(111, '删除', 116, 0, 'Category/remove', 0, '删除栏目分类', '', 0),
(112, '移动', 116, 0, 'Category/operate/type/move', 0, '移动栏目分类', '', 0),
(113, '合并', 116, 0, 'Category/operate/type/merge', 0, '合并栏目分类', '', 0),
(114, '恢复', 85, 0, 'Database/import', 0, '数据库恢复', '', 0),
(115, '删除', 85, 0, 'Database/del', 0, '删除备份文件', '', 0),
(116, '分类管理', 8, 0, 'Category/index', 0, '分类管理', '前台设置', 0),
(117, '属性管理', 8, 0, 'Attribute/index', 0, '网站属性配置。', '前台设置', 0),
(118, '备用菜单项', 9, 0, 'Other/index', 1, '备用菜单项', '', 1),
(119, '备用菜单项', 9, 0, 'Other/index', 1, '备用菜单项', '', 1),
(120, '备用菜单项', 9, 0, 'Other/index', 1, '备用菜单项', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_model`
--

CREATE TABLE IF NOT EXISTS `think_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文档模型表' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `think_model`
--

INSERT INTO `think_model` (`id`, `name`, `title`, `extend`, `relation`, `need_pk`, `field_sort`, `field_group`, `attribute_list`, `template_list`, `template_add`, `template_edit`, `list_grid`, `list_row`, `search_key`, `search_list`, `create_time`, `update_time`, `status`, `engine_type`) VALUES
(1, 'document', '基础文档', 0, '', 1, '{"1":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', 0, '', '', 1383891233, 1384507827, 1, 'MyISAM'),
(2, 'article', '文章', 1, '', 1, '{"1":["3","24","2","5"],"2":["9","13","19","10","12","16","17","26","20","14","11","25"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', 0, '', '', 1383891243, 1387260622, 1, 'MyISAM'),
(3, 'download', '下载', 1, '', 1, '{"1":["3","28","30","32","2","5","31"],"2":["13","10","27","9","12","16","17","19","11","20","14","29"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', 0, '', '', 1383891252, 1387260449, 1, 'MyISAM');
 

<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="使用 thinkPHP 和 bootstrap 管理系统">
<meta name="author" content="">
<title><?php echo ($meta_title); ?>|<?php echo C('WEB_SITE_TITLE');?></title>
<link rel="shortcut icon" href="/Public/favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/bootstrap.min.css" />
<!-- Font Awesome CSS -->
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/font-awesome/css/font-awesome.min.css" />
<!-- 弹出提示框，ajax用 css -->
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/messenger.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/messenger-theme-block.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/alert_confirm_prompt.css" />  
<!-- 表格 css-->
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/dataTables.bootstrap.css" />

<!-- 页面通用的  CSS - Include with every page -->
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/sb/style.css" /> 
<!--
 
-->
<!-- Custom styles for this template -->
<!-- 用于加载 css 代码 --> 
<!-- 页面header钩子，一般用于加载插件CSS文件和代码 -->
<?php echo hook('pageHeader');?>
</head>
<body>
<div id="wrapper">
  <!-- 导航条 ================================================== --> 
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="<?php echo U('Index/index');?>">&nbsp;&nbsp;ThinkPHP 3.2.1</a>
    </div><!-- /.navbar-header -->

    <ul class="nav navbar-nav navbar-top-links">
        <li class="disabled"><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        <li class="disabled"><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    <?php if(is_array($__MENU__["main"])): $i = 0; $__LIST__ = $__MENU__["main"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li class="<?php echo ((isset($menu["class"]) && ($menu["class"] !== ""))?($menu["class"]):''); ?>"><a href="<?php echo (U($menu["url"])); ?>"><?php echo ($menu["title"]); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>	
    </ul>

    <ul class="nav navbar-top-links navbar-right">
        <!-- 用户栏 -->
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="fa fa-user fa-fw"></i><?php echo get_username();?>  <i class="fa fa-caret-down"></i>
            </a>
            <ul class="dropdown-menu dropdown-user">
                <li><a href="<?php echo U('User/updateNickname');?>"><i class="fa fa-user fa-fw"></i> 修改昵称</a>
                </li>
                <li><a href="<?php echo U('User/updatePassword');?>"><i class="fa fa-gear fa-fw"></i> 修改密码</a>
                </li>
                <li class="divider"></li>
                <li><a href="<?php echo U('Public/logout');?>"><i class="fa fa-sign-out fa-fw"></i> 退出</a>
                </li>
            </ul><!-- /.dropdown-user -->
        </li><!-- /.dropdown -->
    </ul><!-- /.navbar-top-links -->
</nav><!-- /.navbar-static-top -->
<!--  /导航条结束点   ================================================== -->  
  	
<nav class="navbar-default navbar-static-side" role="navigation">
<div class="sidebar-collapse">
  <ul class="nav" id="side-menu">
    
    <li id="subnav" class="active" >
      <?php if(!empty($_extra_menu)): ?>
        <?php echo extra_menu($_extra_menu,$__MENU__); endif; ?>
      <?php if(is_array($__MENU__["child"])): $i = 0; $__LIST__ = $__MENU__["child"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub_menu): $mod = ($i % 2 );++$i; if(!empty($sub_menu)): if(!empty($key)): ?><a href="#"><h3><i class="fa fa-sitemap fa-fw"></i><?php echo ($key); ?></h3><span class="fa arrow"></span></a><?php endif; ?>
        <ul class="nav nav-second-level">
            <?php if(is_array($sub_menu)): $i = 0; $__LIST__ = $sub_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li class="" >											
                <a href="<?php echo (U($menu["url"])); ?>"><i class="fa fa-table fa-fw"></i>&nbsp;&nbsp;<?php echo ($menu["title"]); ?></a>
            </li><?php endforeach; endif; else: echo "" ;endif; ?>
        </ul><?php endif; endforeach; endif; else: echo "" ;endif; ?>
    </li> 
    
  </ul> 
</div>
</nav>

  <div id="page-wrapper"> 
  <div class="row">  
    <div id="main" class="col-lg-12 main">
      
      <?php if(!empty($_show_nav)): ?><!-- nav -->
      <div class="breadcrumb">
        <span>您的位置:</span>
        <?php $i = '1'; ?>
        <?php if(is_array($_nav)): foreach($_nav as $k=>$v): if($i == count($_nav)): ?><span><?php echo ($v); ?></span>
            <?php else: ?>
            <span><a href="<?php echo ($k); ?>"><?php echo ($v); ?></a>&gt;</span><?php endif; ?>
            <?php $i = $i+1; endforeach; endif; ?>
      </div><!-- /nav --><?php endif; ?>
             
      
<!-- 标题栏 -->
<div class="main-title cf">
    <h2>查看行为日志</h2>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        查看
    </div>
    
    <div class="panel-body">
        <div class="row">
            <!-- 表单 -->
            <form action="<?php echo U();?>" method="post"  role="form" class="form col-lg-6">
                <!-- 基础 -->
                <div id="tab1" class="tab-pane in tab1">
                    <div class="form-group">
                        <label class="item-label">行为名称</label>
                        <div class="form-control">
                            <span><?php echo get_action($info['action_id'], "title");?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="item-label">执行者</label>
                        <div class="form-control">
                            <span><?php echo get_nickname($info['user_id']);?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="item-label">执行IP</label>
                        <div class="form-control">
                            <span><?php echo long2ip($info['action_ip']);?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="item-label">执行时间</label>
                        <div class="form-control">
                            <span><?php echo date('Y-m-d H:i:s',$info['create_time']);?></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="item-label">备注</label>
                        <textarea class="form-control" readonly="readonly" ><?php echo ($info["remark"]); ?></textarea>
                    </div>
                </div>

                <!-- 按钮 -->
                <div class="form-group"> 
                    <button class="btn btn-default return-btn" onclick="javascript:history.back(-1);return false;">返 回</button> 
                </div>
            </form>
        </div><!-- /.row (nested) -->
    </div><!-- /.panel-body -->
</div><!-- /.panel -->
 
    </div>  
  </div>
</div>		  
    <!--  页脚，版权信息   ================================================== -->     
  <footer class="bs-footer" role="contentinfo">
	<div class="container">	  
		<p> 本站由 <strong><a href="http://www.thinkphp.cn" target="_blank">Think 3.2.1</a></strong> 强力驱动</p>
	</div>
  </footer>
  <!--  /页脚，版权信息   ================================================== -->  

  <div class="hidden"><!-- 用于加载统计代码等隐藏元素 -->
	
  </div>
</div>    
  
<!-- Core Scripts - Include with every page -->
<script type="text/javascript" src="/Public/static/jquery-1.10.2.min.js"></script> 
<script type="text/javascript" src="/Public/Admin/js/sb/bootstrap.min.js"></script> 
<!-- Page-Level Plugin Scripts - 侧边栏 -->
<script type="text/javascript" src="/Public/Admin/js/sb/plugins/metisMenu/jquery.metisMenu.js"></script>  
<!-- 弹出提示框，ajax用 js -->
<script type="text/javascript" src="/Public/Admin/js/sb/plugins/messenger/messenger.min.js"></script> 
<script type="text/javascript" src="/Public/Admin/js/sb/alert_confirm_prompt.js"></script> 
<!-- Page-Level Plugin Scripts - Tables 表格-->
<script type="text/javascript" src="/Public/Admin/js/sb/plugins/dataTables/jquery.dataTables.js"></script> 
<script type="text/javascript" src="/Public/Admin/js/sb/plugins/dataTables/dataTables.bootstrap.js"></script>  

<!-- 页面通用的  js -->
<!--  think JS   ================================================== -->  
<script type="text/javascript" src="/Public/Admin/js/sb/think.js"></script>
<script type="text/javascript" src="/Public/Admin/js/sb/common.js"></script> 
<!--   

-->



 
<!-- 页面footer钩子，一般用于加载插件JS文件和JS代码 -->
<?php echo hook('pageFooter', 'widget');?>
</body>
</html>
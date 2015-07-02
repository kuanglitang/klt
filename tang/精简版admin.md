
第一次安装可以用  
http://127.0.0.1/index.php/install/   
的方式来调用安装模块来安装系统。其实
安装模块起的作用是  新增管理员帐号，更新 admin/conf/ 
下面的配置文件， 生成 UC_AUTH_KEY 这个加密常量 （登陆密码用到了这个参数）


如果不使用安装，直接把数据库表还原到数据库中，则使用根目录下的 oneThink.sql 

数据库名为onethink
登录用户、密码为
admin
admin


通过这段时间的研究，发现
用户、登录管理、权限分配管理、菜单管理、前台导航菜单管理、系统日志
这些是一个系统的最小集合。其他的功能都可以另外加表，加模型的方式解决
精简版仅仅包括了以上提及的这些模块，以便于大家的参考学习。
需要完整版可以参考 另外一个帖子（oneThink深度定制版）

这个精简版和原版的oneThink 主要修改的地方在于：
1、取消了模块的命名空间，便于迁移
2、合并了user 模块和 common 模块，仅剩下 admin 一个模块
3、将 会员表 和 用户表合并，更便于理解
4、修改了 控制器文件 Public.class  、AdminController.class  
和模型文件 MemberModel.class 
5、修改了 所有的视图文件，增加了 bootstrap 的主题
6、重新整理更新了后台菜单的排序
7、修改了公共的 common.js 文件，更新了 ajax 方式，
更新了提示信息、确认对话框的显示，和bootstrap 主题统一起来


需要自行在 ThinkPHP 目录下放3.2.1包
后台主要功能：
1、用户Passport系统(auth)
2、配置管理系统(网站参数配制)
3、权限控制系统(权限分配)
4、多级分类系统(分类管理\树形)
5、用户行为系统(用户行为)
6、系统日志系统(用户行为日志)



菜单配置

后台首页

用户
    用户管理
            用户信息
            用户行为
            
            
    权限管理
            角色组管理
                访问
                分类
                成员
                
    日志管理
            行为日志   
            
            
配置
    配置管理
            网站设置
            配置内容
            
系统
    菜单导航
            菜单管理
            导航管理
 
            
            

        
控制器       

ActionController.class      行为控制器
AdminController.class       后台公共控制器
AuthManager.class           权限管理
CategoryController.class    分类管理
ChannelController.class     导航管理
ConfigController.class      后台配置控制器 
IndexController.class       后台首页
MenuController.class        菜单管理
Public.class                登录页
User.class                  用户管理



模型
ActionModel.class
AuthGroupModel.class
AuthRuleModel.class
CategoryModel.class
Channel.class
ConfigModel.class
MemberModel.class
MenuModel.class
ModelModel.class
TreeModel.class


public\admin 目录，新增的内容
css\sb  样式文件
js\sb   js文件
font-awesome    字体和图标  
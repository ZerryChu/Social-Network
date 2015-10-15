<html>

<head>
<meta charset="utf-8">
<title>社交网络后台服务器api文档</title>
=======
<title>社交网络api文档</title>

>>>>>>> origin/master
</head>
<body>
<ul id="tree" class="ztree"></ul>

<p><article class='markdown-body'></p>

<h1 id="toc_0">社交网络后台服务器api文档</h1>

<h2 id="toc_1">用户模块</h2>

<h3 id="toc_2">用户注册：</h3>

<pre><code>URL: /user/reg
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;password&quot;:require、(密码)
    &quot;nickname&quot;:require、(昵称)    
    &quot;age&quot;:require、(年龄)
    &quot;habit&quot;:require(爱好)     
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {
        &quot;returnmsg&quot;: &quot;REG_SUCCEED&quot;
    }
</code></pre>

<h3 id="toc_3">用户登陆：</h3>

<pre><code>URL: /user/login
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;password&quot;:require、(密码)
    &quot;userToken&quot;:require(用户标识)
    
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {
        &quot;returnmsg&quot;:&quot;LOGIN_SUCCEED&quot;
    }
</code></pre>

<h3 id="toc_4">用户注销：</h3>

<pre><code>URL: /user/logout
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require(登陆标识)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;LOGOUT_SUCCEED&quot;}
</code></pre>

<h3 id="toc_5">添加好友：</h3>

<pre><code>URL: /user/addfriend
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;friendUsername&quot;:require、(朋友用户名)
    &quot;group&quot;:require(分组名)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;:&quot;ADD_FRIEND_SUCCEED&quot;}
</code></pre>

<h3 id="toc_6">显示信息：</h3>

<pre><code>URL: /user/getinfo
Method: POST
Params:
    &quot;username&quot;:require(用户名)
Return:
    &quot;returndata&quot;:返回信息
Response(JSON):
    &quot;returdata&quot;: 
        {
        	&quot;nickname&quot;: (作者昵称),
       	    &quot;age&quot;: (年龄);,
        	&quot;habit&quot;: (爱好),
        	&quot;type&quot;: (1：普通用户 2：管理员)
        	&quot;friend_num&quot;: (朋友数)
        	&quot;message_num&quot;: (微博数)
        }
</code></pre>

<h2 id="toc_7">微博帖子模块</h2>

<h3 id="toc_8">发微博</h3>

<pre><code>URL: /message/send
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;content&quot;:require、(帖子内容)
    &quot;type&quot;:require(1：所有人可见 2：好友可见)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;ADD_MESSAGE_SUCCEED&quot;}
</code></pre>

<h3 id="toc_9">删除微博</h3>

<pre><code>URL: /message/delete
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;userToken&quot;:require、(登陆标示)
    &quot;id&quot;:require(微博id)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;DELETE_MESSAGE_SUCCEED&quot;}
</code></pre>

<h3 id="toc_10">获取微博数据</h3>

<pre><code>URL: /message/show
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;type&quot;:require(1: 所有人可见 2: 仅看好友微博)
Return:
    &quot;returndata&quot;:返回信息
Response(JSON):
    {
        &quot;returndata&quot;: 
        [
            {
                &quot;author&quot;: (作者昵称),
                &quot;content&quot;: &quot;(微博内容);,
                &quot;create_time&quot;: (发微博的时间),
                &quot;repost_times&quot;: (转发量),
                &quot;comment_times&quot;: (评论量),
                &quot;support_times&quot;: (点赞量)
            },
            {
                ...
            }
            ...
        ]
    }
</code></pre>

<h3 id="toc_11">转发微博</h3>

<pre><code>URL: /message/repost
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;id&quot;:require(微博id)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {
        &quot;returnmsg&quot;:&quot;ADD_REPOST_SUCCEED&quot;
    }
</code></pre>

<h3 id="toc_12">评论微博</h3>

<pre><code>URL: /message/comment
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;id&quot;:require、(微博id)
    &quot;content&quot;:require(评论内容)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;ADD_COMMENT_SUCCEED&quot;}
</code></pre>

<h3 id="toc_13">微博点赞</h3>

<pre><code>URL: /message/support
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;:&quot;ADD_SUPPORT_SUCCEED&quot;}
</code></pre>

<h2 id="toc_14">微博评论模块</h2>

<h3 id="toc_15">显示评论</h3>

<pre><code>URL: /comment/show
Method: POST
Params:
    &quot;id&quot;:require(微博id)
Return:
    "returnmsg":返回信息
Response(JSON):
    {
        &quot;returnmsg&quot;: 
        {
        	&quot;nickname&quot;: (用户昵称),
        	&quot;content&quot;: (评论内容),
        	&quot;create_time&quot;: (评论时间)
        }, 
        {
        ...
        },
        ...
    }
</code></pre>

<p></article></p>
<<<<<<< HEAD
=======


>>>>>>> origin/master
</body>
</html>

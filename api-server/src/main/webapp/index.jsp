<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html><html>

<head>
<meta charset="utf-8">
<title>社交网络api文档</title>
<style type="text/css">
body {
  font-family: Helvetica, arial, sans-serif;
  font-size: 14px;
  line-height: 1.6;
  padding-top: 10px;
  padding-bottom: 10px;
  background-color: white;
  padding: 30px; }

article.markdown-body {
  padding-left: 100px;
}

body > *:first-child {
  margin-top: 0 !important; }
body > *:last-child {
  margin-bottom: 0 !important; }

a {
  color: #4183C4; }
a.absent {
  color: #cc0000; }
a.anchor {
  display: block;
  padding-left: 30px;
  margin-left: -30px;
  cursor: pointer;
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0; }

h1, h2, h3, h4, h5, h6 {
  margin: 20px 0 10px;
  padding: 0;
  font-weight: bold;
  -webkit-font-smoothing: antialiased;
  cursor: text;
  position: relative; }

h1:hover a.anchor, h2:hover a.anchor, h3:hover a.anchor, h4:hover a.anchor, h5:hover a.anchor, h6:hover a.anchor {
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA09pVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoMTMuMCAyMDEyMDMwNS5tLjQxNSAyMDEyLzAzLzA1OjIxOjAwOjAwKSAgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OUM2NjlDQjI4ODBGMTFFMTg1ODlEODNERDJBRjUwQTQiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OUM2NjlDQjM4ODBGMTFFMTg1ODlEODNERDJBRjUwQTQiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo5QzY2OUNCMDg4MEYxMUUxODU4OUQ4M0REMkFGNTBBNCIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo5QzY2OUNCMTg4MEYxMUUxODU4OUQ4M0REMkFGNTBBNCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PsQhXeAAAABfSURBVHjaYvz//z8DJYCRUgMYQAbAMBQIAvEqkBQWXI6sHqwHiwG70TTBxGaiWwjCTGgOUgJiF1J8wMRAIUA34B4Q76HUBelAfJYSA0CuMIEaRP8wGIkGMA54bgQIMACAmkXJi0hKJQAAAABJRU5ErkJggg==) no-repeat 10px center;
  text-decoration: none; }

h1 tt, h1 code {
  font-size: inherit; }

h2 tt, h2 code {
  font-size: inherit; }

h3 tt, h3 code {
  font-size: inherit; }

h4 tt, h4 code {
  font-size: inherit; }

h5 tt, h5 code {
  font-size: inherit; }

h6 tt, h6 code {
  font-size: inherit; }

h1 {
  font-size: 28px;
  color: black; }

h2 {
  font-size: 24px;
  border-bottom: 1px solid #cccccc;
  color: black; }

h3 {
  font-size: 18px; }

h4 {
  font-size: 16px; }

h5 {
  font-size: 14px; }

h6 {
  color: #777777;
  font-size: 14px; }

p, blockquote, ul, ol, dl, li, table, pre {
  margin: 15px 0; }

hr {
  background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAECAYAAACtBE5DAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OENDRjNBN0E2NTZBMTFFMEI3QjRBODM4NzJDMjlGNDgiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OENDRjNBN0I2NTZBMTFFMEI3QjRBODM4NzJDMjlGNDgiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo4Q0NGM0E3ODY1NkExMUUwQjdCNEE4Mzg3MkMyOUY0OCIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo4Q0NGM0E3OTY1NkExMUUwQjdCNEE4Mzg3MkMyOUY0OCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PqqezsUAAAAfSURBVHjaYmRABcYwBiM2QSA4y4hNEKYDQxAEAAIMAHNGAzhkPOlYAAAAAElFTkSuQmCC) repeat-x 0 0;
  border: 0 none;
  color: #cccccc;
  height: 4px;
  padding: 0;
}

body > h2:first-child {
  margin-top: 0;
  padding-top: 0; }
body > h1:first-child {
  margin-top: 0;
  padding-top: 0; }
  body > h1:first-child + h2 {
    margin-top: 0;
    padding-top: 0; }
body > h3:first-child, body > h4:first-child, body > h5:first-child, body > h6:first-child {
  margin-top: 0;
  padding-top: 0; }

a:first-child h1, a:first-child h2, a:first-child h3, a:first-child h4, a:first-child h5, a:first-child h6 {
  margin-top: 0;
  padding-top: 0; }

h1 p, h2 p, h3 p, h4 p, h5 p, h6 p {
  margin-top: 0; }

li p.first {
  display: inline-block; }
li {
  margin: 0; }
ul, ol {
  padding-left: 30px; }

ul :first-child, ol :first-child {
  margin-top: 0; }

dl {
  padding: 0; }
  dl dt {
    font-size: 14px;
    font-weight: bold;
    font-style: italic;
    padding: 0;
    margin: 15px 0 5px; }
    dl dt:first-child {
      padding: 0; }
    dl dt > :first-child {
      margin-top: 0; }
    dl dt > :last-child {
      margin-bottom: 0; }
  dl dd {
    margin: 0 0 15px;
    padding: 0 15px; }
    dl dd > :first-child {
      margin-top: 0; }
    dl dd > :last-child {
      margin-bottom: 0; }

blockquote {
  border-left: 4px solid #dddddd;
  padding: 0 15px;
  color: #777777; }
  blockquote > :first-child {
    margin-top: 0; }
  blockquote > :last-child {
    margin-bottom: 0; }

table {
  padding: 0;border-collapse: collapse; }
  table tr {
    border-top: 1px solid #cccccc;
    background-color: white;
    margin: 0;
    padding: 0; }
    table tr:nth-child(2n) {
      background-color: #f8f8f8; }
    table tr th {
      font-weight: bold;
      border: 1px solid #cccccc;
      margin: 0;
      padding: 6px 13px; }
    table tr td {
      border: 1px solid #cccccc;
      margin: 0;
      padding: 6px 13px; }
    table tr th :first-child, table tr td :first-child {
      margin-top: 0; }
    table tr th :last-child, table tr td :last-child {
      margin-bottom: 0; }

img {
  max-width: 100%; }

span.frame {
  display: block;
  overflow: hidden; }
  span.frame > span {
    border: 1px solid #dddddd;
    display: block;
    float: left;
    overflow: hidden;
    margin: 13px 0 0;
    padding: 7px;
    width: auto; }
  span.frame span img {
    display: block;
    float: left; }
  span.frame span span {
    clear: both;
    color: #333333;
    display: block;
    padding: 5px 0 0; }
span.align-center {
  display: block;
  overflow: hidden;
  clear: both; }
  span.align-center > span {
    display: block;
    overflow: hidden;
    margin: 13px auto 0;
    text-align: center; }
  span.align-center span img {
    margin: 0 auto;
    text-align: center; }
span.align-right {
  display: block;
  overflow: hidden;
  clear: both; }
  span.align-right > span {
    display: block;
    overflow: hidden;
    margin: 13px 0 0;
    text-align: right; }
  span.align-right span img {
    margin: 0;
    text-align: right; }
span.float-left {
  display: block;
  margin-right: 13px;
  overflow: hidden;
  float: left; }
  span.float-left span {
    margin: 13px 0 0; }
span.float-right {
  display: block;
  margin-left: 13px;
  overflow: hidden;
  float: right; }
  span.float-right > span {
    display: block;
    overflow: hidden;
    margin: 13px auto 0;
    text-align: right; }

code, tt {
  margin: 0 2px;
  padding: 0 5px;
  white-space: nowrap;
  border: 1px solid #eaeaea;
  background-color: #f8f8f8;
  border-radius: 3px; }

pre code {
  margin: 0;
  padding: 0;
  white-space: pre;
  border: none;
  background: transparent; }

.highlight pre {
  background-color: #f8f8f8;
  border: 1px solid #cccccc;
  font-size: 13px;
  line-height: 19px;
  overflow: auto;
  padding: 6px 10px;
  border-radius: 3px; }

pre {
  background-color: #f8f8f8;
  border: 1px solid #cccccc;
  font-size: 13px;
  line-height: 19px;
  overflow: auto;
  padding: 6px 10px;
  border-radius: 3px; }
  pre code, pre tt {
    background-color: transparent;
    border: none; }

sup {
    font-size: 0.83em;
    vertical-align: super;
    line-height: 0;
}
* {
	-webkit-print-color-adjust: exact;
}
@media screen and (min-width: 914px) {
    body {
        width: 854px;
        margin:0 auto;
    }
}
@media print {
	table, pre {
		page-break-inside: avoid;
	}
	pre {
		word-wrap: break-word;
	}
}
</style>
</head>
<body>
<ul id="tree" class="ztree"></ul>

<p><article class='markdown-body'></p>

<h1 id="toc_0">社交网络API文档</h1>

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
        &quot;returnmsg&quot;: &quot;注册成功&quot;,
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
        &quot;returnmsg&quot;:&quot;登陆成功&quot;
    }
</code></pre>

<h3 id="toc_4">用户注销：</h3>

<pre><code>URL: /user/logout
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;用户已退出&quot;}
</code></pre>

<h3 id="toc_5">绑定设备到用户名下</h3>

<pre><code>URL: /user/regsensor
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;:&quot;传感器绑定成功&quot;}
</code></pre>

<h3 id="toc_6">获取用户所有已绑定设备</h3>

<pre><code>URL: /user/mysensor
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
Return:
    &quot;returnmsg&quot;:返回信息
    &quot;sensor&quot;:传感器数据
Response(JSON):
    {
        &quot;returnmsg&quot;:&quot;数据获取成功&quot;,
        &quot;sensor&quot;:[{
                &quot;modifyTime&quot;:&quot;2014-12-04 13:35:42.0&quot;,
                &quot;sensorAddr&quot;: &quot;教学楼2&quot;,
                &quot;sensorType&quot;:&quot;红外传感器&quot;,
                &quot;serialNum&quot;:&quot;B291&quot;,
            },
            {
                &quot;modifyTime&quot;:&quot;2014-12-04 13:35:02.0&quot;,
                &quot;sensorAddr&quot;: &quot;教学楼2&quot;,
                &quot;sensorType&quot;:&quot;光线传感器&quot;,
                &quot;serialNum&quot;:&quot;B230&quot;,
            }
        ]
    }
Ps. &lt;modifyTime:绑定到用户的时间&gt;
</code></pre>

<h2 id="toc_9">设备模块</h2>

<h3 id="toc_10">后台注册传感器(需要高权限用户)</h3>

<pre><code>URL: /sensor/add
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;sensortype&quot;:require、(设备类型)
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;该序列号已经存在&quot;}
</code></pre>

<h2 id="toc_11">设备数据模块</h2>

<h3 id="toc_12">持久化单条传感器数据</h3>

<pre><code>URL: /sensordata/add
Method: POST
Params:
    &quot;temperature&quot;:require、(温度)
    &quot;humidity&quot;:require、(湿度)
    &quot;co&quot;:require、(一氧化碳)
    &quot;smoke&quot;:require、(烟雾浓度)
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;数据接收成功&quot;}
</code></pre>

<h3 id="toc_13">获取实时数据</h3>

<pre><code>URL: /sensordata/realtime
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
    &quot;data&quot;:返回的数据(JSON)
Response(JSON):
    {
        &quot;returnmsg&quot;: &quot;数据获取成功&quot;,
        &quot;data&quot;:{
            &quot;co&quot;: 0.5,
            &quot;createTime&quot;: &quot;2014-12-04 16:50:13.0&quot;,
            &quot;humidity&quot;: 10,
            &quot;smoke&quot;: 0.8,
            &quot;temperature&quot;: 12
        }
    }
</code></pre>

<h3 id="toc_14">获取历史数据</h3>

<pre><code>URL: /sensordata/history
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;serialnum&quot;:require、(设备序列号)
    &quot;timestamp&quot;:require、(时间点)
Return:
    &quot;returnmsg&quot;:返回信息
    &quot;data&quot;:返回的数据(JSON)
Response(JSON):
    {
        &quot;returnmsg&quot;:&quot;数据获取成功&quot;,
        &quot;data&quot;:[{
                &quot;co&quot;:0.5,
                &quot;createTime&quot;:&quot;2014-12-04 16:50:13.0&quot;,
                &quot;humidity&quot;:10,
                &quot;smoke&quot;:0.8,
                &quot;temperature&quot;:12
            },
            {
                &quot;co&quot;:0.5,
                &quot;createTime&quot;:&quot;2014-12-04 13:59:18.0&quot;,
                &quot;humidity&quot;:10,
                &quot;smoke&quot;:0.8,
                &quot;temperature&quot;:12
            },
            {
                &quot;co&quot;:0.5,
                &quot;createTime&quot;:&quot;2014-12-04 13:59:01.0&quot;,
                &quot;humidity&quot;:10,
                &quot;smoke&quot;:0.8,
                &quot;temperature&quot;:12
            }
        ]
    }
</code></pre>

<h3 id="toc_15">保存警报信息</h3>

<pre><code>URL: /sensordata/alert/add
Method: POST
Params:
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
Response(JSON):
    {&quot;returnmsg&quot;: &quot;数据接收成功&quot;}
</code></pre>

<h3 id="toc_16">查询警报信息</h3>

<pre><code>URL: /alert/get
Method: POST
Params:
    &quot;username&quot;:require、(用户名)
    &quot;usertoken&quot;:require、(登陆标识)
    &quot;serialnum&quot;:require、(设备序列号)
Return:
    &quot;returnmsg&quot;:返回信息
    &quot;data&quot;:返回的数据(JSON)
Response(JSON):
    {
        &quot;returnmsg&quot;:&quot;DATA_FETCH_SUCCESS&quot;,
        &quot;data&quot;:[{
                    &quot;createTime&quot;:&quot;2014-12-29 14:00:16.0&quot;
                },
                {
                    &quot;createTime&quot;:&quot;2014-12-30 12:55:42.0&quot;
                }
            ]
    }
</code></pre>

<h3>查询警报信息统计数据</h3>

<pre><code>URL: /sensordata/alert/count
Method: POST
Params:
    "username":require、(用户名)
    "usertoken":require、(登陆标识)
    "timestamp":require、(时间点)
Return:
    "returnmsg":返回信息
    "data":返回的数据(JSON)
Response(JSON):
    {
        "returnmsg": "DATA_FETCH_SUCCESS",
        "data":[
        {
            "count": 4,
            "serialNum": "40A259C7"
        },
        {
            "count": 9,
            "serialNum": "40A61AF3"
        }
        ]
    }
</code></pre>

<h3>查询传感器数据统计数据</h3>

<pre><code>URL: /sensordata/count
Method: POST
Params:
    "username":require、(用户名)
    "usertoken":require、(登陆标识)
    "timestamp":require、(时间点)
Return:
    "returnmsg":返回信息
    "data":返回的数据(JSON)
Response(JSON):
    {
        "returnmsg": "DATA_FETCH_SUCCESS",
        "data":[
        {
            "count": 4,
            "serialNum": "40A259C7"
        },
        {
            "count": 9,
            "serialNum": "40A61AF3"
        }
        ]
    }   
</code></pre>

<p></article></p>

<script type="text/javascript" src="static/js/jquery-1.10.2.min.js"></script>

<script type="text/javascript" src="static/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript" src="static/js/jquery.ztree_toc.js"></script>

<SCRIPT type="text/javascript" >
$(document).ready(function(){
    $('#tree').ztree_toc({
        is_auto_number:true,
        documment_selector:'.markdown-body',
        ztreeStyle: {
            width:'260px',
            overflow: 'auto',
            position: 'fixed',
            'z-index': 2147483647,
            border: '0px none',
            left: '0px',
            top: '55px'
        }
    });
});
</SCRIPT>
</body>
</html>
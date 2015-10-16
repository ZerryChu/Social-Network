<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
    .top {
        width: 100%;
        height: 27px;
        background: url(images/top_bg.jpg) repeat-x;
    }

    .top_content {
        width: 1000px;
        margin: 0 auto;
        line-height: 27px;
    }
    .top_content li {
        float: left;
        list-style-image: url(images/arrow.jpg);
        width: 90px;
    }

    .search_text {
        margin-left: 500px;
        width: 150px;
        margin-top: 1px;
        height: 23px;
        background: url(images/search.jpg) no-repeat right center;
        background-color: white;
        padding-right: 25px;
    }

</style>
<body>
	<div class="top">
    <ul class="top_content">
        <li>
            首页
        </li>
        <li>
            敬请期待
        </li>
        <!--  at    好友    私信 -->
		<form action="" method="post">
            <input type="text" class="search_text" />
        </form>
    </ul>
</div>
</body>
</html>
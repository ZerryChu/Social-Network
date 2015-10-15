<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>

<!-- show user & userToken  -->

<div id="userinfo">
    <div id="nickname"></div>
    <img>
    <br>
    朋友数： <span id="friend_num"></span>微博数： <span id="message_num"></span>
</div>

<div id="messages">
    <!-- jquery 加标签 -->
    <!-- id : number  -->
    <div id="" class="weiboinfo">
        <br>
        <span class="weibo_name"></span><span class="create_time"></span>
        <br>
        <span class="content"></span>
        <br>
        <span class="repost_times"></span><span class="comment_times"></span><span class="support_times"></span>
    </div>
</div>


<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="scripts/login.js" type="text/javascript"></script>
<script src="scripts/showUserInfo.js" type="text/javascript"></script>
<script src="scripts/show_messages.js" type="text/javascript"></script>
<script src="scripts/send_message.js" type="text/javascript"></script>
<script src="scripts/delete_message.js" type="text/javascript"></script>
<SCRIPT type="text/javascript" >
    $(document).ready(function(){
        showUserInfo();
        show_messages();
    });
</SCRIPT>

</body>
</html>
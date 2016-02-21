/**
 * Created by zhuzirui on 11/20/15.
 */
    /* 用于防止重复提交  */

/*
 * time : 停顿的毫秒
 */
var ifCanSubmit = true;
var t;
function checkSubmit(time) {
    if(ifCanSubmit == true) {
        ifCanSubmit = false;
        t = setTimeout('ifCanSubmit = true;', time);
        return true;
    } else {
        /*alert("操作过于频繁");*/
        clearTimeout(t);
        t = setTimeout('ifCanSubmit = true;', time);
        return false;
    }
}


var _ifCanSubmit = [];
var _t = [];

$(document).ready(function() {
	for(var i = 0;i < 3; i++)
		_ifCanSubmit[i] = true;
});

/**
 * 内容切换频率太快则不访问后台，不更新数据（时间太短后台数据变化的很小，无需更新）， true 则向后台要数据并执行更新cookies操作， false直接执行cookies中的数据
 */
function _checkSubmit(time, num) {
    if(_ifCanSubmit[num] == true) {
        _ifCanSubmit[num] = false;
        var str = "_ifCanSubmit[" + num + "] = true;";
        _t[num] = setTimeout(str, time);
        return true;
    } else {
        clearTimeout(_t[num]);
        var str = "_ifCanSubmit[" + num + "] = true;";
        _t[num] = setTimeout(str, time);
        return false;
    }
}
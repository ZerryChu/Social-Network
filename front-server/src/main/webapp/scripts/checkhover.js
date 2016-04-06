/**
 * 在用到mouseover和mouseout事件来作为事件触发的条件，但是如果我们用做触发的元素内部有其他的元素的时候当鼠标移上的时候会反复
 * 的触发mouseover和mouseout事件。因为内部元素在鼠标移上的时候会向它的父对象派发事件，所以外面元素相当于也触发了mouseover 事件。
 */
function contains(parentNode, childNode) {
    if (parentNode.contains) {
        return parentNode != childNode && parentNode.contains(childNode);
    } else {
        return !!(parentNode.compareDocumentPosition(childNode) & 16);
    }
}

function checkHover(e,target){
    if (getEvent(e).type=="mouseover")  {
        return !contains(target,getEvent(e).relatedTarget||getEvent(e).fromElement) && !((getEvent(e).relatedTarget||getEvent(e).fromElement)===target);
    } else {
        return !contains(target,getEvent(e).relatedTarget||getEvent(e).toElement) && !((getEvent(e).relatedTarget||getEvent(e).toElement)===target);
    }
}

function getEvent(e){
    return e||window.event;
}

/* 使用方法
myElement.onmouseover=function(e){
    if(checkHover(e,this)){
        do someting...
    }
}
myElement.onmouseout=function(e){
    if(checkHover(e,this)){
        do someting...
    }
}
*/


//var editDoc = document.getElementById('edit');
//var btnBoldDoc = document.getElementById('bold');
//var btnItalicsDoc = document.getElementById('italics');
//var btnUnderlineDoc = document.getElementById('underline');
//var btnRedDoc = document.getElementById('red');
//var btnBlackDoc = document.getElementById('black');
//var btnImageDoc = document.getElementById('image');
//var btnFontDoc = document.getElementById('font');
//var btnFontFamilyDoc = document.getElementById('fontFamily');
//var btnHtmlDoc = document.getElementById('html');

//btnBoldDoc.onclick = function(){
//    unfocus();
//}


var b = false;


//OC调用JS
function ocTojsAction(parameter)
{
    switch (parameter) {
            
        case 'bold':
            bold();
            break;
        case 'unbold':
            unbold();
            break;
            
        case 'italics':
            italics();
            break;
        case 'unitalics':
            unitalics();
            break;
            
            
        case 'underline':
            underline();
            break;
        case 'ununderline':
            ununderline();
            break;
            
        case 'justifyLeft':
            justifyLeft();
            break;
            
        case 'justifyCenter':
            justifyCenter();
            break;
            
        case 'insertImage':
            insertImage('https://stanserver.cn:444/scEdit.png','img');
            break;
            
        case 'unfocus':
            unfocus();
            break;
            
        default:
            break;
    }

}


var bold_b = false;
var italics_b = false;
var underline_b = false;

//加粗
function bold(){
    bold_b = true;
    document.execCommand('bold',false,null);
}
function unbold(){
    bold_b = false;
    document.execCommand('bold', false, null);
    unZeroSpace('bold');
}

//斜体
function italics(){
    italics_b = true;
    document.execCommand('italic', false, null);
}
function unitalics(){
    italics_b = false;
    document.execCommand('italic', false, null);
    unZeroSpace('italic');
}

//下划线
function underline(){
    underline_b = true;
    document.execCommand('underline', false, null);
}
function ununderline(){
    underline_b = false;
    document.execCommand('underline', false, null);
    unZeroSpace('underline');
}

//取消选择和多选
function unZeroSpace(e){
    document.execCommand('insertHTML', false, '&zwnj;');
    if(bold_b){
        bold();
    }
    if(italics_b){
        italics();
    }
    if(underline_b){
        underline();
    }
}


//左对齐
function justifyLeft(){
    document.execCommand('justifyLeft', false, null);
}
//中间对齐
function justifyCenter(){
    document.execCommand('justifyCenter', false, null);
}
//插入图片
function insertImage(url, alt) {
    var html ='</br><img src="' + url + '" alt="' + alt + '" style="width:80%;"/>';
    insertHTML(html);
    
    justifyCenter();
    setTimeout(function() {
    	insertHTML("</br>");
    }, 100);
    setTimeout(function() {
    	justifyLeft();
    }, 200);
    setTimeout(function() {
        document.scrollTop = 2000;
    }, 400);
    
}

//插入html
function insertHTML(html) {
    document.execCommand('insertHTML', false, html);
}
//失去焦点
function unfocus()
{
    document.activeElement.blur();
}
//键盘输入
document.onkeydown=function(event)
{
    if(b){
        insertHTML('<span>'+event.key+'</span>');
    }else{
        b = false;
    }
    
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13){ // enter 键
//        insertHTML("<br/>");
    }
}




////红色
//btnRedDoc.onclick = function(){
//    document.execCommand("styleWithCSS", null, true);
//    document.execCommand('foreColor',false,'red');
//    document.execCommand("styleWithCSS", null, false);
//}
////黑色
//btnBlackDoc.onclick = function(){
//    document.execCommand("styleWithCSS", null, true);
//    document.execCommand('foreColor',false,'rgb(0,0,0)');
//    document.execCommand("styleWithCSS", null, false);
//}
////插入图片
//btnImageDoc.onclick = function(){
//    document.execCommand('insertImage', false, '1.png');
//}
//
////字体大小
//btnFontDoc.onclick = function(){
//    document.execCommand("fontSize", false, '20px');
//}
////字体风格
//btnFontFamilyDoc.onclick = function(){
//    document.execCommand("fontname", false, '微软雅黑');
//}
////插入html
//btnHtmlDoc.onclick = function(){
//    document.execCommand("CreateLink", false, 'www.baidu.com');
//    var a = editDoc.innerHTML;
//    console.log(a);
//}

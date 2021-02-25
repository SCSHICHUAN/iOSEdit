
var editDoc = document.getElementById('edit');
var fontSizeDoc = document.getElementById('fontSize');

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

window.onload=function(){
    editDoc.focus();
    fontSizeDoc.hidden = true;
    textSet();
    
}



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
        case 'insertVideo':
            insertVideo('https://stanserver.cn:444/cat1.mp4');
            break;
        case 'fontSize':
            fontSize();
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
    
    var select = document.getSelection();
    //有高亮的文字
    var highlight =select.isCollapsed;
    if(highlight){
        document.execCommand('insertHTML', false, '&zwnj;');
    }
    
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
var imgID = 0;
function insertImage(url, alt) {
    imgID += 1;
    var html ='</br><img id = "'+imgID+'"src="' + url + '" alt="' + alt + '" style="width:80%;"/>';
    insertHTML(html);
    scrollFocus();
}

//插入视频
function insertVideo(url) {
    imgID += 1;
    var html ='</br><div style="width:100%"><video id = '+imgID+' src='+url+' controls="controls" autoplay playsinline style="width:80%">您的浏览器不支持 video 标签。</video>&zwnj;</div>';
    insertHTML(html);
    scrollFocus();
    
}
//插入图片视频音频滚动
function scrollFocus()
{
    justifyCenter();
    setTimeout(function() {
        insertHTML("</br>");
    }, 100);
    setTimeout(function() {
        justifyLeft();
    }, 200);
    
    //滚动到可见区域
    setTimeout(function() {
        var imgDoc =  document.getElementById(imgID);
        imgDoc.scrollIntoView();
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


var shoFontView = true;
function fontSize(){
    shoFontView = !shoFontView;
    if(shoFontView){
        fontSizeDoc.hidden = true;
    }else{
        fontSizeDoc.hidden = false;
    }
    
}
//button 标签才可以触发 execCommand
function textSet(){
    $('#fontSize').click(function(e) {
        var  target =  $(e.target);
        var  ID = target.attr("id");
        var  html = target.text();
        
        switch (ID) {
                
            case 'fontSize_a':
                redText();
                break;
            case 'fontSize_b':
                blackText();
                break;
                
            case 'fontSize_c':
                fountSize(html);
                break;
            case 'fontSize_d':
                fountSize(html);
                break;
            
            case 'fontSize_e':
                fountSize(html);
                break;
            case 'fontSize_f':
                fountSize(html);
                break;
                
            case 'fontSize_g':
                fountSize(html);
                break;
                fountSize(html);
            case 'fontSize_h':
                
                break;
                
            case 'fontSize_j':
                
                break;
            
                
                
            default:
                break;
        }

        editDoc.focus();
    });
}

//红色
function redText(){
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor',false,'red');
    document.execCommand("styleWithCSS", null, false);
}
//黑色
function blackText(){
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor',false,'rgb(0,0,0)');
    document.execCommand("styleWithCSS", null, false);
}
////插入图片
//btnImageDoc.onclick = function(){
//    document.execCommand('insertImage', false, '1.png');
//}
//
//字体大小
function fountSize(size){
    var font = size;
    document.execCommand("fontSize", false,size);
}
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




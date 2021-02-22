
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




function focus(){
      setTimeout(function(){
      editDoc.focus();
  },1000);
}


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
            
        case 'underline':
            underline();
            break;
            
        default:
            break;
    }

}



//加粗
function bold(){
    document.execCommand('bold',false,null);
}
function unbold(){
    document.execCommand('bold',false,null);
}
//斜体
function italics(){
    document.execCommand('italic', false, null);
}
//下划线
function underline(){
    document.execCommand('underline', false, null);
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


var editDoc = document.getElementById('edit');
var btnBoldDoc = document.getElementById('bold');
var btnItalicsDoc = document.getElementById('italics');
var btnUnderlineDoc = document.getElementById('underline');
var btnRedDoc = document.getElementById('red');
var btnBlackDoc = document.getElementById('black');
var btnImageDoc = document.getElementById('image');
var btnFontDoc = document.getElementById('font');
var btnFontFamilyDoc = document.getElementById('fontFamily');
var btnHtmlDoc = document.getElementById('html');



function focus(){
      setTimeout(function(){
      editDoc.focus();
  },1000);
}


//OC调用JS
function changeColor(parameter)
{
   document.execCommand('bold',false,null);
   editDoc.focus();
}

//加粗
btnBoldDoc.onclick = function(){
    document.execCommand('bold',false,null);
    focus();

}
//斜体
btnItalicsDoc.onclick = function(){
    document.execCommand('italic', false, null);
}
//下划线
btnUnderlineDoc.onclick = function(){
    document.execCommand('underline', false, null);
}

//红色
btnRedDoc.onclick = function(){
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor',false,'red');
    document.execCommand("styleWithCSS", null, false);
}
//黑色
btnBlackDoc.onclick = function(){
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor',false,'rgb(0,0,0)');
    document.execCommand("styleWithCSS", null, false);
}
//插入图片
btnImageDoc.onclick = function(){
    document.execCommand('insertImage', false, '1.png');
}

//字体大小
btnFontDoc.onclick = function(){
    document.execCommand("fontSize", false, '20px');
}
//字体风格
btnFontFamilyDoc.onclick = function(){
    document.execCommand("fontname", false, '微软雅黑');
}
//插入html
btnHtmlDoc.onclick = function(){
    document.execCommand("CreateLink", false, 'www.baidu.com');
    var a = editDoc.innerHTML;
    console.log(a);
}

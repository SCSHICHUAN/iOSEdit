//
//  WebController.m
//  iOSEdit
//
//  Created by Stan on 2021/2/20.
//

#import "WebController.h"
#import <WebKit/WebKit.h>
#import "ScriptDelegate.h"
#import <objc/runtime.h>

WebController *publicWebController;

#pragma mak-添加wktoolBar
@interface _NoInputAccessoryView : NSObject
@end
@implementation _NoInputAccessoryView
- (id)inputAccessoryView {
    return publicWebController.bottomView;
}
@end


@interface WebController ()
<WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate>
{
    UIButton *bold;
    UIButton *justifyLeftButton;
    UIButton *justifyCenterButton;
}
@property(nonatomic)WKWebView *wkWebView;
@end

@implementation WebController
-(WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[self wkWebViewConfiguration]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
//       _wkWebView.scrollView.scrollEnabled = NO;
    }
    return _wkWebView;
}
-(WKWebViewConfiguration *)wkWebViewConfiguration
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    //设置
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.minimumFontSize = 0;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.javaScriptEnabled = YES;
    config.preferences = preferences;
    
    config.allowsInlineMediaPlayback = YES;
    config.mediaTypesRequiringUserActionForPlayback = YES;
    config.applicationNameForUserAgent = @"SCEdit";
    
    
    ScriptDelegate *scriDelegate = [[ScriptDelegate alloc] initWithScriptDelegate:self];
    WKUserContentController *wkUserVC = [[WKUserContentController alloc] init];
    [wkUserVC addScriptMessageHandler:scriDelegate name:@"jsToOCWithPrams"];
    config.userContentController = wkUserVC;
    
    return config;
}
-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
        UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 10,  [UIScreen mainScreen].bounds.size.width, 44)];
        toolView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        
        UIButton *boldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [boldButton setImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
        [boldButton setImage:[UIImage imageNamed:@"BHOVER"] forState:UIControlStateSelected];
        boldButton.frame = CGRectMake(0, 0, 44, 44);
        [toolView addSubview:boldButton];
        [boldButton addTarget:self action:@selector(boldButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *italicsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [italicsButton setImage:[UIImage imageNamed:@"I"] forState:UIControlStateNormal];
        [italicsButton setImage:[UIImage imageNamed:@"IHOVER"] forState:UIControlStateSelected];
        italicsButton.frame = CGRectMake(44, 0, 44, 44);
        [toolView addSubview:italicsButton];
        [italicsButton addTarget:self action:@selector(italicsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *underlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [underlineButton setImage:[UIImage imageNamed:@"u"] forState:UIControlStateNormal];
        [underlineButton setImage:[UIImage imageNamed:@"uHOVER"] forState:UIControlStateSelected];
        underlineButton.frame = CGRectMake(44*2, 0, 44, 44);
        [toolView addSubview:underlineButton];
        [underlineButton addTarget:self action:@selector(underlineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *justifyLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justifyLeftButton setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
        [justifyLeftButton setImage:[UIImage imageNamed:@"zuohover"] forState:UIControlStateSelected];
        justifyLeftButton.frame = CGRectMake(44*3, 0, 44, 44);
        [toolView addSubview:justifyLeftButton];
        [justifyLeftButton addTarget:self action:@selector(justifyLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self->justifyLeftButton = justifyLeftButton;
        
        UIButton *justifyCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justifyCenterButton setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateNormal];
        [justifyCenterButton setImage:[UIImage imageNamed:@"zhonghover"] forState:UIControlStateSelected];
        justifyCenterButton.frame = CGRectMake(44*4, 0, 44, 44);
        [toolView addSubview:justifyCenterButton];
        [justifyCenterButton addTarget:self action:@selector(justifyCenterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self->justifyCenterButton = justifyCenterButton;
        
        UIButton *insertImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [insertImageButton setImage:[UIImage imageNamed:@"tupian"] forState:UIControlStateNormal];
        insertImageButton.frame = CGRectMake(44*5, 0, 44, 44);
        [insertImageButton addTarget:self action:@selector(insertImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:insertImageButton];
        
        UIButton *insertVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [insertVideoButton setImage:[UIImage imageNamed:@"icon_video"] forState:UIControlStateNormal];
        insertVideoButton.frame = CGRectMake(44*6, 0, 44, 44);
        [insertVideoButton addTarget:self action:@selector(insertVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:insertVideoButton];
        
        UIButton *fontSizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fontSizeButton setImage:[UIImage imageNamed:@"ziti"] forState:UIControlStateNormal];
        fontSizeButton.frame = CGRectMake(44*7, 0, 44, 44);
        [fontSizeButton addTarget:self action:@selector(fontSizeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:fontSizeButton];
        
        UIButton *closeKeyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeKeyButton setImage:[UIImage imageNamed:@"jianpanxia"] forState:UIControlStateNormal];
        closeKeyButton.frame = CGRectMake(44*8, 0, 44, 44);
        [closeKeyButton addTarget:self action:@selector(closeKeyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:closeKeyButton];
        
        [_bottomView addSubview:toolView];
        
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载本地的html
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SCEdit.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.wkWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [self.view addSubview:self.wkWebView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    publicWebController = self;
    [self removeInputAccessoryViewFromWKWebView:self.wkWebView];
    [self allowDisplayingKeyboardWithoutUserAction];
    
}

- (void)removeInputAccessoryViewFromWKWebView:(WKWebView *)webView {
    UIView *targetView;

    for (UIView *view in webView.scrollView.subviews) {
        if([[view.class description] hasPrefix:@"WKContent"]) {
            targetView = view;
        }
    }
    if (!targetView) {
        return;
    }
    NSString *noInputAccessoryViewClassName = [NSString stringWithFormat:@"%@_NoInputAccessoryView", targetView.class.superclass];
    Class newClass = NSClassFromString(noInputAccessoryViewClassName);

    if(newClass == nil) {
        newClass = objc_allocateClassPair(targetView.class, [noInputAccessoryViewClassName cStringUsingEncoding:NSASCIIStringEncoding], 0);
        if(!newClass) {
            return;
        }
        Method method = class_getInstanceMethod([_NoInputAccessoryView class], @selector(inputAccessoryView));
        class_addMethod(newClass, @selector(inputAccessoryView), method_getImplementation(method), method_getTypeEncoding(method));

        objc_registerClassPair(newClass);
    }
    object_setClass(targetView, newClass);
}
-(void)doneClicked
{
    NSLog(@"%s",__func__);
}
#pragma mark-WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

/**
 *   键盘弹出
 */
//- (void)keyboardWillShow:(NSNotification *)note
//{
//
//    // 1.取出键盘的高度
//    CGRect temp  = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = temp.size.height;
//    // 2.让工具条向上平移
//    // 2.1取出键盘弹出的动画时间
//    NSTimeInterval timte = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView animateWithDuration:timte delay:0 options:7 << 16 animations:^{
//        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -height+44);
//    } completion:nil];
//}
//
///**
// *  键盘隐藏
// */
//- (void)keyboardWillHide:(NSNotification *)note
//{
//    // 2.1取出键盘弹出的动画时间
//    NSTimeInterval timte = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    // 清空transform
//    [UIView animateWithDuration:timte delay:0 options:7 << 16 animations:^{
//        self.bottomView.transform = CGAffineTransformIdentity;
//    } completion:nil];
//
//}

-(void)boldButtonClick:(UIButton*)send
{
    send.selected = !send.selected;
    if (send.isSelected) {
        [self ocTojs:@"bold"];
    }else{
        [self ocTojs:@"unbold"];
    }
}

-(void)italicsButtonClick:(UIButton*)send
{
    send.selected = !send.selected;
    if (send.isSelected) {
        [self ocTojs:@"italics"];
    }else{
        [self ocTojs:@"unitalics"];
    }
}

-(void)underlineButtonClick:(UIButton*)send
{
    send.selected = !send.selected;
    if (send.isSelected) {
        [self ocTojs:@"underline"];
    }else{
        [self ocTojs:@"ununderline"];
    }
}
-(void)justifyLeftButtonClick:(UIButton*)send
{
    
    if (!send.isSelected) {
        [self ocTojs:@"justifyLeft"];
        send.selected = !send.selected;
        self->justifyCenterButton.selected = NO;
    }
    
}




-(void)justifyCenterButtonClick:(UIButton*)send
{
    if (!send.isSelected) {
        [self ocTojs:@"justifyCenter"];
        send.selected = !send.selected;
        self->justifyLeftButton.selected = NO;
    }

}
-(void)insertImageButtonClick:(UIButton*)send
{
    [self ocTojs:@"insertImage"];
}
-(void)insertVideoButtonClick:(UIButton*)send
{
    [self ocTojs:@"insertVideo"];
}


-(void)closeKeyButtonClick:(UIButton*)send
{
    [self ocTojs:@"unfocus"];    
}
-(void)fontSizeButtonClick:(UIButton*)send
{
    [self ocTojs:@"fontSize"];
}




-(void)ocTojs:(NSString*)action
{
    NSString *jsString = [NSString stringWithFormat:@"ocTojsAction('%@')",action];
    [self.wkWebView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
    }];
}

//允许自动弹出键盘
- (void)allowDisplayingKeyboardWithoutUserAction {
    Class class = NSClassFromString(@"WKContentView");
    NSOperatingSystemVersion iOS_11_3_0 = (NSOperatingSystemVersion){11, 3, 0};
    NSOperatingSystemVersion iOS_12_2_0 = (NSOperatingSystemVersion){12, 2, 0};
    NSOperatingSystemVersion iOS_13_0_0 = (NSOperatingSystemVersion){13, 0, 0};
    char * methodSignature = "_startAssistingNode:userIsInteracting:blurPreviousNode:changingActivityState:userObject:";

    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_13_0_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:";
    } else if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_12_2_0]) {
        methodSignature = "_elementDidFocus:userIsInteracting:blurPreviousNode:changingActivityState:userObject:";
    }

    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: iOS_11_3_0]) {
        SEL selector = sel_getUid(methodSignature);
        Method method = class_getInstanceMethod(class, selector);
        IMP original = method_getImplementation(method);
        IMP override = imp_implementationWithBlock(^void(id me, void* arg0, BOOL arg1, BOOL arg2, BOOL arg3, id arg4) {
            ((void (*)(id, SEL, void*, BOOL, BOOL, BOOL, id))original)(me, selector, arg0, TRUE, arg2, arg3, arg4);
        });
        method_setImplementation(method, override);
    } else {
        SEL selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
        Method method = class_getInstanceMethod(class, selector);
        IMP original = method_getImplementation(method);
        IMP override = imp_implementationWithBlock(^void(id me, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
            ((void (*)(id, SEL, void*, BOOL, BOOL, id))original)(me, selector, arg0, TRUE, arg2, arg3);
        });
        method_setImplementation(method, override);
    }
}
@end

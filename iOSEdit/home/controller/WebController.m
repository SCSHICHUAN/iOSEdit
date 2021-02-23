//
//  WebController.m
//  iOSEdit
//
//  Created by Stan on 2021/2/20.
//

#import "WebController.h"
#import <WebKit/WebKit.h>
#import "ScriptDelegate.h"



@interface WebController ()
<WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate>
{
    UIButton *justifyLeftButton;
    UIButton *justifyCenterButton;
}
@property(nonatomic)WKWebView *wkWebView;
@property(nonatomic)UIView *bottomView;
@end

@implementation WebController

-(WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[self wkWebViewConfiguration]];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
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
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width, 44)];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        
        UIButton *boldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [boldButton setImage:[UIImage imageNamed:@"B"] forState:UIControlStateNormal];
        [boldButton setImage:[UIImage imageNamed:@"BHOVER"] forState:UIControlStateSelected];
        boldButton.frame = CGRectMake(0, 0, 44, 44);
        [_bottomView addSubview:boldButton];
        [boldButton addTarget:self action:@selector(boldButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *italicsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [italicsButton setImage:[UIImage imageNamed:@"I"] forState:UIControlStateNormal];
        [italicsButton setImage:[UIImage imageNamed:@"IHOVER"] forState:UIControlStateSelected];
        italicsButton.frame = CGRectMake(44, 0, 44, 44);
        [_bottomView addSubview:italicsButton];
        [italicsButton addTarget:self action:@selector(italicsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *underlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [underlineButton setImage:[UIImage imageNamed:@"u"] forState:UIControlStateNormal];
        [underlineButton setImage:[UIImage imageNamed:@"uHOVER"] forState:UIControlStateSelected];
        underlineButton.frame = CGRectMake(44*2, 0, 44, 44);
        [_bottomView addSubview:underlineButton];
        [underlineButton addTarget:self action:@selector(underlineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *justifyLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justifyLeftButton setImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
        [justifyLeftButton setImage:[UIImage imageNamed:@"zuohover"] forState:UIControlStateSelected];
        justifyLeftButton.frame = CGRectMake(44*3, 0, 44, 44);
        [_bottomView addSubview:justifyLeftButton];
        [justifyLeftButton addTarget:self action:@selector(justifyLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self->justifyLeftButton = justifyLeftButton;
        
        UIButton *justifyCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justifyCenterButton setImage:[UIImage imageNamed:@"zhong"] forState:UIControlStateNormal];
        [justifyCenterButton setImage:[UIImage imageNamed:@"zhonghover"] forState:UIControlStateSelected];
        justifyCenterButton.frame = CGRectMake(44*4, 0, 44, 44);
        [_bottomView addSubview:justifyCenterButton];
        [justifyCenterButton addTarget:self action:@selector(justifyCenterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self->justifyCenterButton = justifyCenterButton;
        
        UIButton *insertImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [insertImageButton setImage:[UIImage imageNamed:@"tupian"] forState:UIControlStateNormal];
        insertImageButton.frame = CGRectMake(44*5, 0, 44, 44);
        [insertImageButton addTarget:self action:@selector(insertImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:insertImageButton];
        
        
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
    [self.view addSubview:self.bottomView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark-WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

/**
 *   键盘弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    
    // 1.取出键盘的高度
    CGRect temp  = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = temp.size.height;
    // 2.让工具条向上平移
    // 2.1取出键盘弹出的动画时间
    NSTimeInterval timte = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:timte delay:0 options:7 << 16 animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -height);
    } completion:nil];
    
}
/**
 *  键盘隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 2.1取出键盘弹出的动画时间
    NSTimeInterval timte = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 清空transform
    [UIView animateWithDuration:timte delay:0 options:7 << 16 animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

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
    }
}

-(void)underlineButtonClick:(UIButton*)send
{
    send.selected = !send.selected;
    if (send.isSelected) {
        [self ocTojs:@"underline"];
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



-(void)ocTojs:(NSString*)action
{
    NSString *jsString = [NSString stringWithFormat:@"ocTojsAction('%@')",action];
    [self.wkWebView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
    }];
}


@end

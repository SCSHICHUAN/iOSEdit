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
@property(nonatomic)WKWebView *wkWebView;
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
    config.preferences = preferences;
    
    WKWebpagePreferences *pagePreferences = [[WKWebpagePreferences alloc] init];
    pagePreferences.allowsContentJavaScript = YES;
    config.defaultWebpagePreferences = pagePreferences;
    
    
    config.allowsInlineMediaPlayback = YES;
    config.mediaTypesRequiringUserActionForPlayback = YES;
    config.applicationNameForUserAgent = @"SCEdit";
    
    
    ScriptDelegate *scriDelegate = [[ScriptDelegate alloc] initWithScriptDelegate:self];
    WKUserContentController *wkUserVC = [[WKUserContentController alloc] init];
    [wkUserVC addScriptMessageHandler:scriDelegate name:@"jsToOCWithPrams"];
    config.userContentController = wkUserVC;
    
    return config;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载本地的html
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SCEdit.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.wkWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [self.view addSubview:self.wkWebView];
}
#pragma mark-WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

@end

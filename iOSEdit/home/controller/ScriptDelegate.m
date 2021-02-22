//
//  ScriptDelegate.m
//  iOSEdit
//
//  Created by AnX on 2021/2/22.
//

#import "ScriptDelegate.h"

@implementation ScriptDelegate
-(instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)delegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = delegate;
    }
    return self;
}
#pragma mark-WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end

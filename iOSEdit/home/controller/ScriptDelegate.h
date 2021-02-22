//
//  ScriptDelegate.h
//  iOSEdit
//
//  Created by AnX on 2021/2/22.
//

#import <Foundation/Foundation.h>
#import <WebKit/WKScriptMessageHandler.h>
NS_ASSUME_NONNULL_BEGIN

@interface ScriptDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic)id<WKScriptMessageHandler> scriptDelegate;
-(instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)delegate;
@end

NS_ASSUME_NONNULL_END

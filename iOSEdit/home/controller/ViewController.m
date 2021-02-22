//
//  ViewController.m
//  iOSEdit
//
//  Created by Stan on 2021/2/20.
//

#import "ViewController.h"
#import "WebController.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WebController *web = [[WebController alloc] init];
    web.modalPresentationStyle = 0;
    [self presentViewController:web animated:YES completion:nil];
}

@end

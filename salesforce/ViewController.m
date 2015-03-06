//
//  ViewController.m
//  salesforce
//
//  Created by prathiba on 16/02/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

//-(id)init{
//    if (self) {
//        self.appLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    }
//    return self;
//}
- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (!self.appLabel.text) {
        self.appLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.appLabel.text = [self buildAppLabel];
        self.appLabel.font = [UIFont systemFontOfSize:20.0];
    }
    [self.view addSubview:self.appLabel];
}


- (void)viewWillLayoutSubviews
{
    CGSize appLabelTextSize = [self.appLabel.text sizeWithAttributes:@{ NSFontAttributeName:self.appLabel.font }];
    CGFloat w = appLabelTextSize.width;
    CGFloat h = appLabelTextSize.height;
    CGFloat x = CGRectGetMidX(self.view.frame) - (w / 2.0);
    CGFloat y = CGRectGetMidY(self.view.frame) - (h / 2.0);
    self.appLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Private methods

- (NSString *)buildAppLabel

{
    NSDictionary *bundleInfoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appLabel = [NSString stringWithFormat:@"%@ Sample App", bundleInfoDict[@"CFBundleDisplayName"]];
    return appLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

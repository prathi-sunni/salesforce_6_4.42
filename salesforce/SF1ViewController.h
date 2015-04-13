//
//  SF1ViewController.h
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesForceBussinessClass.h"

@interface SF1ViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *Webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;

-(void)Temp;

@end


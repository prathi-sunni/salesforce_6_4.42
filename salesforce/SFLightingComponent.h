//
//  SFLightingComponent.h
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesForceBussinessClass.h"

@interface SFLightingComponent : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;

@end

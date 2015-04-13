//
//  SFLightingComponent.m
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "SFLightingComponent.h"

#define URL @"https://ap1.lightning.force.com/buddy/ml_demo.app"

@interface SFLightingComponent ()

@end

@implementation SFLightingComponent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      self.navigationController.navigationBar.hidden = TRUE;
  [SalesForceBussinessClass SharedInstance];
    
      [self CallWebservice:[SalesForceBussinessClass URLGeneration:URL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)CallWebservice:(NSString*)url
{
    
    NSURLRequest *requestURL = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [_webview loadRequest:requestURL];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityindicator startAnimating];
    _activityindicator.hidden = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_webview bringSubviewToFront:_activityindicator];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityindicator stopAnimating];
    _activityindicator.hidden = YES;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [_webview insertSubview:_activityindicator belowSubview:_webview];
}


@end

//
//  SF1ViewController.m
//  salesforce
//
//  Created by Prathibha on 25/03/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "SF1ViewController.h"

#define URL @"https://ap1.lightning.force.com/one/one.app"

@interface SF1ViewController ()

@end

@implementation SF1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.navigationController.navigationBar.hidden = TRUE;
//    [SalesForceBussinessClass SharedInstance];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);


    [self performSelectorOnMainThread:@selector(Temp) withObject:nil waitUntilDone:YES];
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self performSelector:@selector(Temp) withObject:nil afterDelay:4];
    
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

-(void)Temp
{
    
     [SalesForceBussinessClass SharedInstance];
//     [self CallWebservice:[SalesForceBussinessClass URLGeneration:URL]];
}

-(void)CallWebservice:(NSString*)url
{
   
    NSURLRequest *requestURL = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [_Webview loadRequest:requestURL];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityindicator startAnimating];
    _activityindicator.hidden = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_Webview bringSubviewToFront:_activityindicator];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityindicator stopAnimating];
    _activityindicator.hidden = YES;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [_Webview insertSubview:_activityindicator belowSubview:_Webview];
}


@end

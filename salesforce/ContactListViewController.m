//
//  ContactListViewController.m
//  salesforce
//
//  Created by prathiba on 18/02/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "ContactListViewController.h"
#import <SalesforceSDKCore/SFUserAccountManager.h>
#import <SalesforceSDKCore/SFIdentityData.h>
#import <SalesforceSDKCore/SFUserAccount.h>
#import <SalesforceSDKCore/SFAuthenticationManager.h>
#import <SalesforceRestAPI/SFRestAPI+Blocks.h>
#import "ContactDetailViewController.h"
#import "cellvalue.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ContactListViewController ()


@end


const int NumberofRows = 2;
static NSString * const kOAuthConsumerKey = @"3MVG9Y6d_Btp4xp4Q5L1TV0uyT1TDoKU19PhDWsKdzC2i1SDNMwQua7EKxWXf5HSBKz_omZLE1.T71SYYZuoF";
static NSString * const kOAuthRedirectURI = @"https://buddy.ap1.visual.force.com/apex/Task_vf";//@"https://ap1.lightning.force.com/buddy/ml_demo.app";//@"https://ap1.lightning.force.com/buddy/ml_demp.app";//@"https://login.salesforce.com/services/oauth2/success";



@implementation ContactListViewController

@synthesize Temp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self._tableview registerNib:[UINib nibWithNibName:@"Tableviewcell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"identifier"];
    self._tableview.estimatedRowHeight = 100.0;
    self._tableview.rowHeight = UITableViewAutomaticDimension;
    
    DueDate = [NSMutableArray array];
    Subject = [NSMutableArray array];
    Priority = [NSMutableArray array];
    Status = [NSMutableArray array];
    Temp = [NSMutableArray array];
    
    cellvalue *value1 = [[cellvalue alloc]init];
    value1.name = @"SalesForce";
    value1.imagename = @"salesforce.png";
    [Temp addObject:value1];
    
    cellvalue *value2 = [[cellvalue alloc]init];
    value2.name = @"Note";
    value2.imagename = @"notes.png";
    [Temp addObject:value2];
    
    cellvalue *value3 = [[cellvalue alloc]init];
    value3.name = @"Events";
    value3.imagename = @"event.png";
    [Temp addObject:value3];
    
    cellvalue *value4 = [[cellvalue alloc]init];
    value4.name = @"Task";
    value4.imagename = @"Task.png";
    [Temp addObject:value4];
    
    cellvalue *value5 = [[cellvalue alloc]init];
    value5.name = @"Opportunity";
    value5.imagename = @"opportunity.png";
    [Temp addObject:value5];
    
    cellvalue *value6 = [[cellvalue alloc]init];
    value6.name = @"Profile";
    value6.imagename = @"profile.png";
    [Temp addObject:value6];
    
    cellvalue *value7 = [[cellvalue alloc]init];
    value7.name = @"Financials";
    value7.imagename = @"Finacials.png";
    [Temp addObject:value7];
    
    cellvalue *value8 = [[cellvalue alloc]init];
    value8.name = @"Planning";
    value8.imagename = @"planning.png";
    [Temp addObject:value8];
    
    cellvalue *value9 = [[cellvalue alloc]init];
    value9.name = @"Operational Detail";
    value9.imagename = @"operations-details.png";
    [Temp addObject:value9];
    
    cellvalue *value10 = [[cellvalue alloc]init];
    value10.name = @"Status";
    value10.imagename = @"Status.png";
    [Temp addObject:value10];
    
    cellvalue *value11 = [[cellvalue alloc]init];
    value11.name = @"Recent Activity";
    value11.imagename = @"recentactivity.png";
    [Temp addObject:value11];
    
    cellvalue *value12 = [[cellvalue alloc]init];
    value12.name = @"Service Oppurtunities";
    value12.imagename = @"service_oppurtunities.png";
    [Temp addObject:value12];
    
    cellvalue *value13 = [[cellvalue alloc]init];
    value13.name = @"Solution Oppurtunities";
    value13.imagename = @"solution_oppurtunity.png";
    [Temp addObject:value13];
    
    
//    Temp = [NSArray arrayWithObjects:@"SalesForce",@"Note",@"Event",@"Task",@"Oppurtunity",@"Profile",@"Financials",@"Planning",@"Operational Detail",@"Status",@"Recent Activity",@"Service Oppurtunities",@"Solution Oppurtunities", nil];
    
    [_Account setTitle:@"Please Wait..." forState:UIControlStateNormal];
    
        
    [SFUserAccountManager sharedInstance].oauthClientId = kOAuthConsumerKey;
    
    [SFUserAccountManager sharedInstance].oauthCompletionUrl = kOAuthRedirectURI;
    
     [SFUserAccountManager sharedInstance].scopes = [NSSet setWithObjects:@"web", @"api", nil];
    
    [[SFAuthenticationManager sharedManager] addDelegate:self];
    
    [[SFAuthenticationManager sharedManager]
     loginWithCompletion:(SFOAuthFlowSuccessCallbackBlock)^(SFOAuthInfo *info) {
         
         NSLog(@"Authentication Done");
         
         [self CallWebservice:[self URLGeneration:@"https://ap1.salesforce.com/console?tsid=02u90000001N9gf"]];
         
         [self ByPassingLogin];
//         [self FetchtheAccountsDetails];
         
         
        
         
     }
     failure:(SFOAuthFlowFailureCallbackBlock)^(SFOAuthInfo *info, NSError *error) {
         NSLog(@"Authentication Failed");
         // handle error hare.
     }
     ];
    
 
   
}

- (void)authManager:(SFAuthenticationManager *)manager willDisplayAuthWebView:(UIWebView *)view{
    
    NSString *str = [view description];
    
}

- (void)authManagerDidFail:(SFAuthenticationManager *)manager error:(NSError*)error info:(SFOAuthInfo *)info{
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


-(void)ByPassingLogin
{
     _webview.delegate = self;
    SFIdentityData *claims = [SFAuthenticationManager sharedManager].idCoordinator.idData;
    NSLog(@"claims = %@",claims);
    
    NSLog(@"accessToken = %@", [SFAuthenticationManager sharedManager].coordinator.credentials.accessToken);
    
    
}

-(void)FetchtheAccountsDetails
{
    
    SFRestRequest *request1 = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT  ActivityDate, CallType,  Id,   Priority, Status, Subject FROM Task"];
    [[SFRestAPI sharedInstance] send:request1 delegate:self];
    
}


- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    
    NSArray *response = [jsonResponse objectForKey:@"records"];
    
    [DueDate removeAllObjects];
    [Subject removeAllObjects];
    [Priority removeAllObjects];
    [Status removeAllObjects];
    
    for (NSDictionary *dic in response) {
    [DueDate addObject:[dic valueForKey:@"ActivityDate"]];
    [Subject addObject:[dic valueForKey:@"Subject"]];
    [Priority addObject:[dic valueForKey:@"Priority"]];
    [Status addObject:[dic valueForKey:@"Status"]];
    }
    
        
        
        
    
//    self.dataCustomerDetailRows = records;
//    [self.tableCustomerList reloadData];

}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//     [_Account setTitle:@"Task Details" forState:UIControlStateNormal];
//}


- (IBAction)AccountDetails:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    detailController = [storyboard instantiateViewControllerWithIdentifier:@"ContactDetailView"];
     [detailController setSubject:Subject];
    [detailController setPriority:Priority];
    [detailController setStatus:Status];
    [detailController setDueDate:DueDate];
    [self.navigationController pushViewController:detailController animated:YES];

}

//*--------------- TABLE VIEW DELEGATE----------------------*
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Temp count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *identifier = @"identifier";
    _tableviewcell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
 
//    
//    if(_tableviewcell == nil)
//    {
//  _tableviewcell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    }
    NSLog(@"value is %@ AND %@",[(cellvalue*)[Temp objectAtIndex:indexPath.row] name],[(cellvalue*)[Temp objectAtIndex:indexPath.row]imagename]);
//    _tableviewcell.text.font = [UIFont fontWithName:@"Helvetica" size:13];
    [_tableviewcell.text setText:[(cellvalue*)[Temp objectAtIndex:indexPath.row] name]];
//    _tableviewcell.text.textColor = [UIColor whiteColor];
    [_tableviewcell.contentView setBackgroundColor:UIColorFromRGB(0x236FBD)];
//    [_tableviewcell setImage:[[UIImageView alloc]initWithImage:[UIImage imageNamed:[(cellvalue*)[Temp objectAtIndex:indexPath.row] imagename]]]];
    [_tableviewcell.image setImage:[UIImage imageNamed:[(cellvalue*)[Temp objectAtIndex:indexPath.row] imagename]]];
  
//    [_TableCell setBackgroundColor:[UIColor colorWithRed:35.0 green:111.0 blue:189.0 alpha:1]];
    
    
    return _tableviewcell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   BOOL value = [NSThread isMainThread];
    
    NSString *str = [NSThread currentThread].name;
    if(indexPath.row == 1)
    {
//        https://ap1.salesforce.com/console?tsid=Notes
        [self CallWebservice:[self URLGeneration:@"https://ap1.salesforce.com/apex/Notes"]];
    }
   else if(indexPath.row == 2)
    {
//        https://ap1.salesforce.com/console?tsid=ListEvents
        [self CallWebservice:[self URLGeneration:@"https://ap1.salesforce.com/apex/ListEvents"]];
        
    }
   else if(indexPath.row == 3)
    {
        [self CallWebservice:[self URLGeneration:@"https://ap1.salesforce.com/console?tsid=02u90000001N9gf"]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Feature yet to implement" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

-(NSString *)URLGeneration:(NSString*)requiredURL
{
    NSString *accesstoken = [SFAuthenticationManager sharedManager].coordinator.credentials.accessToken;
    NSString *url = [NSString stringWithFormat:@"https://ap1.salesforce.com/secur/frontdoor.jsp?sid=%@&retURL=%@",accesstoken,requiredURL];
    
    return url;
    
}


-(void)CallWebservice:(NSString*)url
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        _webview.delegate =self;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [_webview loadRequest:request];
        
        NSString *page = [NSString stringWithContentsOfURL:request.URL
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
        
        NSString *html = [_webview stringByEvaluatingJavaScriptFromString:
                          @"document.body.innerHTML"];
    });
   

}

- (IBAction)Back:(id)sender {
    
    float width = self.view.frame.size.width;
    float height1 = self.view.frame.size.height;
    
    if([__Back isSelected])
    {
        
    
    [UIView animateWithDuration:0.40f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{

                         [self.view setFrame:CGRectMake(-__tableview.frame.size.width, 0.0, width+__tableview.frame.size.width, height1)];
                         
                     }
                     completion:^(BOOL finished){
                         
                         // do whatever post processing you want (such as resetting what is "current" and what is "next")
                     }];
    }
    else
    {
        [UIView animateWithDuration:0.40f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [self.view setFrame:CGRectMake(0, 0.0, width-__tableview.frame.size.width, height1)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             // do whatever post processing you want (such as resetting what is "current" and what is "next")
                         }];
    }
    
    [__Back setSelected:![__Back isSelected]];
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

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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ContactListViewController ()


@end


const int NumberofRows = 2;
static NSString * const kOAuthConsumerKey = @"3MVG9Y6d_Btp4xp4Q5L1TV0uyT1TDoKU19PhDWsKdzC2i1SDNMwQua7EKxWXf5HSBKz_omZLE1.T71SYYZuoF";
static NSString * const kOAuthRedirectURI = @"https://buddy.ap1.visual.force.com/apex/Task_vf";//@"https://ap1.lightning.force.com/buddy/ml_demo.app";//@"https://ap1.lightning.force.com/buddy/ml_demp.app";//@"https://login.salesforce.com/services/oauth2/success";



@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DueDate = [NSMutableArray array];
    Subject = [NSMutableArray array];
    Priority = [NSMutableArray array];
    Status = [NSMutableArray array];
    
    Temp = [NSArray arrayWithObjects:@"SalesForce",@"Note",@"Event",@"Task",@"Oppurtunity",@"Profile",@"Financials",@"Planning",@"Operational Detail",@"Status",@"Recent Activity",@"Service Oppurtunities",@"Solution Oppurtunities", nil];
    
    [_Account setTitle:@"Please Wait..." forState:UIControlStateNormal];
    
        
    [SFUserAccountManager sharedInstance].oauthClientId = kOAuthConsumerKey;
    
    [SFUserAccountManager sharedInstance].oauthCompletionUrl = kOAuthRedirectURI;
    
     [SFUserAccountManager sharedInstance].scopes = [NSSet setWithObjects:@"web", @"api", nil];
    
    [[SFAuthenticationManager sharedManager] addDelegate:self];
    
    [[SFAuthenticationManager sharedManager]
     loginWithCompletion:(SFOAuthFlowSuccessCallbackBlock)^(SFOAuthInfo *info) {
         
         NSLog(@"Authentication Done");
         
         [self CallWebservice:[self URLGeneration:@"https://ap1.salesforce.com/console?tsid=02u90000001N9gf"]];
         
//         [self ByPassingLogin];
//         [self FetchtheAccountsDetails];
         
         
        
         
     }
     failure:(SFOAuthFlowFailureCallbackBlock)^(SFOAuthInfo *info, NSError *error) {
         NSLog(@"Authentication Failed");
         // handle error hare.
     }
     ];
    
 
   
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [_Account setTitle:@"Task Details" forState:UIControlStateNormal];
}


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
    UITableViewCell *_TableCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if(_TableCell == nil)
    {
    _TableCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    _TableCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    _TableCell.textLabel.text = [Temp objectAtIndex:indexPath.row];
    _TableCell.textLabel.textColor = [UIColor whiteColor];
    [_TableCell setBackgroundColor:UIColorFromRGB(0x236FBD)];
//    [_TableCell setBackgroundColor:[UIColor colorWithRed:35.0 green:111.0 blue:189.0 alpha:1]];
    
    
    return _TableCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3)
    {
        [self CallWebservice:@"https://ap1.lightning.force.com/buddy/ml_demo.app"];
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
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [_webview loadRequest:request];
   

}

- (IBAction)Back:(id)sender {
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    if([__Back isSelected])
    {
        
    
    [UIView animateWithDuration:0.60f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{

                         [self.view setFrame:CGRectMake(-__tableview.frame.size.width, 0.0, width+__tableview.frame.size.width, height)];
                         
                     }
                     completion:^(BOOL finished){
                         
                         // do whatever post processing you want (such as resetting what is "current" and what is "next")
                     }];
    }
    else
    {
        [UIView animateWithDuration:0.60f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [self.view setFrame:CGRectMake(0, 0.0, width-__tableview.frame.size.width, height)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             // do whatever post processing you want (such as resetting what is "current" and what is "next")
                         }];
    }
    
    [__Back setSelected:![__Back isSelected]];
}
@end

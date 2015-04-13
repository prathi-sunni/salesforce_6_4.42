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

@synthesize Icons;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = TRUE;
    
    DueDate = [NSMutableArray array];
    Subject = [NSMutableArray array];
    Priority = [NSMutableArray array];
    Status = [NSMutableArray array];
    
    Icons = [NSArray arrayWithObjects:@"dashboard.png",@"contact.png",@"event.png",@"task.png",@"feed.png",@"Lightning.png",@"opportunity.png",@"",@"",@"",@"",@"",@"",@"", nil];
    Temp = [NSArray arrayWithObjects:@"DashBoard",@"Contact",@"Event",@"Task",@"Feed",@"Lightning",@"Opportunity",@"Accounts",@"People",@"Settings",@"Help",@"LogOut", nil];
    
    [_Account setTitle:@"Please Wait..." forState:UIControlStateNormal];
    
    SFBC = [SalesForceBussinessClass SharedInstance];
    
//         [self CallWebservice:[SalesForceBussinessClass URLGeneration:@"https://ap1.salesforce.com/console?tsid=02u90000001N9gf"]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    [__tableview selectRowAtIndexPath:indexPath
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    [self tableView:__tableview didSelectRowAtIndexPath:indexPath];
    
 
   
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
    
//    SFRestRequest *request1 = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT  ActivityDate, CallType,  Id,   Priority, Status, Subject FROM Task"];
//    [[SFRestAPI sharedInstance] send:request1 delegate:self];
    
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
    return [Temp count]+2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *identifier = @"identifier";
    UITableViewCell *_TableCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if(_TableCell == nil)
    {
    _TableCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [tableView setSeparatorColor:UIColorFromRGB(0x2A4158)];
    }
    
    if(indexPath.row == 0)
    {
        UILabel *UserDetails = [[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, 90, 35)];
        UserDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        UserDetails.textAlignment = NSTextAlignmentCenter;
        UserDetails.text = @"Ajay Rao";
        UserDetails.textColor = [UIColor whiteColor];
        [_TableCell addSubview:UserDetails];
        
        UILabel *UserDetails1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 37.5,125, 35)];
        UserDetails1.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        UserDetails1.textAlignment = NSTextAlignmentCenter;
        UserDetails1.text = @"ap1.Salesforce.com";
        UserDetails1.textColor = [UIColor whiteColor];
        [_TableCell addSubview:UserDetails1];
        
       
        
        
    }
    else if(indexPath.row == 1)
    {
         UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 2.5, 140, 75)];
        [search setSearchBarStyle:UISearchBarStyleDefault];
        [search setPlaceholder:@"Search"];
        [search setBarTintColor:UIColorFromRGB(0x34495E)];
        [_TableCell addSubview:search];
    }
    
//    if(indexPath.row == 4)
//    {
//        [self tableView:self.tableView didSelectRowAtIndexPath:selectedCellIndexPath];
//    }
    
    else
    {
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(41, 17.5, 90, 35)];
    text.font = [UIFont fontWithName:@"Helvetica" size:17];
    text.textAlignment = NSTextAlignmentLeft;
    text.text = [Temp objectAtIndex:indexPath.row-2];
    text.textColor = [UIColor whiteColor];
   

    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(3, 17.5, 35, 35)];
    image.image = [UIImage imageNamed:[Icons objectAtIndex:indexPath.row-2]];
    [_TableCell addSubview:image];
    [_TableCell addSubview:text];
    }
     [_TableCell setBackgroundColor:UIColorFromRGB(0x34495E)];
    return _TableCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
 
//    if(indexPath.row == 1)
//    {
////        https://ap1.salesforce.com/console?tsid=Notes
//        [self CallWebservice:[SalesForceBussinessClass URLGeneration:@"https://ap1.salesforce.com/apex/Notes"]];
//    }
    if(indexPath.row == 4)
    {
//        https://ap1.salesforce.com/console?tsid=ListEvents
        [self CallWebservice:[SalesForceBussinessClass URLGeneration:@"https://ap1.salesforce.com/apex/ListEvents"]];
        
    }
   else if(indexPath.row == 5)
    {
        [self CallWebservice:[SalesForceBussinessClass URLGeneration:@"https://ap1.salesforce.com/console?tsid=02u90000001N9gf"]];
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




-(void)CallWebservice:(NSString*)url
{
    if(url != nil)
    {
   
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        _webview.delegate =self;

    
    [_webview loadRequest:request];
    
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Problem occurs while creating access token" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   

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

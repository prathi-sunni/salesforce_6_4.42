//
//  ContactListViewController.h
//  salesforce
//
//  Created by prathiba on 18/02/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <SalesforceRestAPI/SFRestAPI.h>
//#import <SalesforceOAuth/SFOAuthCoordinator.h>
//#import <SalesforceOAuth/SFOAuthCredentials.h>
//#import <SalesforceSDKCore/SFUserAccountManager.h>
//#import <SalesforceSDKCore/SFAuthenticationManager.h>
#import "ContactDetailViewController.h"
<<<<<<< HEAD
#import "SalesForceBussinessClass.h"
=======
#import "TableViewCell.h"
>>>>>>> origin/master

@interface ContactListViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    ContactDetailViewController *detailController;
    NSMutableArray *Subject;
    NSMutableArray *DueDate;
    NSMutableArray *Priority;
    NSMutableArray *Status;
    
    NSString *Backurl;
    
<<<<<<< HEAD
    NSArray *Temp;
    
    SalesForceBussinessClass *SFBC;
    NSString *token;
    
    
}

@property (weak,nonatomic)NSArray *Icons;
=======
  
   
    
}

//@property(nonatomic,weak)TableViewCell *tablecell;

@property(nonatomic,strong) NSMutableArray *Temp;
@property (weak, nonatomic) IBOutlet UILabel *tableviewcelllabel;
@property (weak, nonatomic) IBOutlet UIImageView *tableviewcellimage;
@property (weak, nonatomic) IBOutlet TableViewCell *tableviewcell;
>>>>>>> origin/master
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
@property (weak, nonatomic) IBOutlet UITableView *_tableview;
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *_Back;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)AccountDetails:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Account;

@end

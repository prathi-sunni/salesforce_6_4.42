//
//  ContactDetailViewController.h
//  salesforce
//
//  Created by prathiba on 18/02/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

}
- (IBAction)NewTask:(id)sender;

@property(nonatomic,strong)NSArray *Subject;
@property(nonatomic,strong)NSArray *Priority;
@property(nonatomic,strong)NSArray *DueDate;
@property(nonatomic,strong)NSArray *Status;

@end

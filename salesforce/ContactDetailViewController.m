//
//  ContactDetailViewController.m
//  salesforce
//
//  Created by prathiba on 18/02/15.
//  Copyright (c) 2015 prathiba. All rights reserved.
//

#import "ContactDetailViewController.h"

@interface ContactDetailViewController ()

@end



@implementation ContactDetailViewController

@synthesize DueDate,Subject,Status,Priority;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Subject count]+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"Identifier";
    
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];

    if(cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    }
    
    if(indexPath.row == 0)
    {
        
        UILabel *subject = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 242, 20)];
        subject.text = [NSString stringWithFormat:@"Subject"];
        subject.textColor = [UIColor blackColor];
        subject.font = [UIFont fontWithName:@"System-Bold" size:20];
        subject.textAlignment = NSTextAlignmentCenter;
        subject.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:subject];
        
        UILabel *duedate = [[UILabel alloc]initWithFrame:CGRectMake(262, 10, 242, 20)];
        duedate.text = [NSString stringWithFormat:@"Due Date"];
        duedate.textColor = [UIColor blackColor];
        duedate.font = [UIFont fontWithName:@"System-Bold" size:20];
        duedate.textAlignment = NSTextAlignmentCenter;
        duedate.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:duedate];
        UILabel *priority = [[UILabel alloc]initWithFrame:CGRectMake(524, 10, 242, 20)];
        priority.text = [NSString stringWithFormat:@"Priority"];
        priority.textColor = [UIColor blackColor];
        priority.font = [UIFont fontWithName:@"System-Bold" size:20];
        priority.textAlignment = NSTextAlignmentCenter;
        priority.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:priority];
        UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(786, 10, 242, 20)];
        status.text = [NSString stringWithFormat:@"Status"];
        status.textColor = [UIColor blackColor];
        status.font = [UIFont fontWithName:@"System-Bold" size:20];
        status.textAlignment = NSTextAlignmentCenter;
        status.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:status];
        
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    else
    {
        UILabel *subject = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 242, 20)];
        subject.text = [Subject objectAtIndex:indexPath.row-1];
        subject.textColor = [UIColor whiteColor];
        subject.font = [UIFont fontWithName:@"Helvetica" size:16];
        subject.textAlignment = NSTextAlignmentCenter;
        subject.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:subject];
        
       
        
        UILabel *duedate = [[UILabel alloc]initWithFrame:CGRectMake(274, 10, 242, 20)];
        
        if([[DueDate objectAtIndex:indexPath.row-1] isEqual:[NSNull null]])
        {
         duedate.text = @" - ";
            
        }
        else
        {
        duedate.text = [DueDate objectAtIndex:indexPath.row-1];
        
        }
        
         duedate.textAlignment = NSTextAlignmentCenter;
        duedate.textColor = [UIColor whiteColor];
        duedate.font = [UIFont fontWithName:@"Helvetica" size:16];
       
        duedate.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:duedate];
        UILabel *priority = [[UILabel alloc]initWithFrame:CGRectMake(536, 10, 242, 20)];
        priority.text = [Priority objectAtIndex:indexPath.row-1];
        priority.textColor = [UIColor whiteColor];
        priority.font = [UIFont fontWithName:@"Helvetica" size:16];
        priority.textAlignment = NSTextAlignmentCenter;
        priority.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:priority];
        UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(798, 10, 242, 20)];
        status.text = [Status objectAtIndex:indexPath.row-1];
        status.textColor = [UIColor whiteColor];
        status.font = [UIFont fontWithName:@"Helvetica" size:16];
        status.textAlignment = NSTextAlignmentCenter;
        status.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:status];

    cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}



- (IBAction)NewTask:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Feature yet to implement" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end

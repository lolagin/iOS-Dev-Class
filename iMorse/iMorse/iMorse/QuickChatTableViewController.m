//
//  QuickChatTableViewController.m
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "QuickChatTableViewController.h"
#import "PListData.h"
#import "HomeViewController.h"

@interface QuickChatTableViewController ()

@end

@implementation QuickChatTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PListData *p = [[PListData alloc] init];
    [p getInformation];
    
    self.stringArray = [[NSMutableArray alloc]initWithArray:p.information];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.stringArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plistdata"];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plistdata"];
    }
    
    cell.textLabel.text = self.stringArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(self.stringArray[indexPath.row]);
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end

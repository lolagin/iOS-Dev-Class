//
//  QuickChatTableViewController.m
//  iMorse
//
//  Created by Keith McClung on 5/18/14.
//  Copyright (c) 2014 Keith Mcclung. All rights reserved.
//

#import "QuickChatTableViewController.h"
#import "PListData.h"

@interface QuickChatTableViewController ()
@property (nonatomic,strong) PListData *p;

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
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFavorite)];
    self.navigationItem.rightBarButtonItem = addItem;
    self.p = [[PListData alloc] init];
    [self.p getInformation];
    
    self.stringArray = [[NSMutableArray alloc]initWithArray:self.p.information];
    
    
    
    
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
    //NSLog(self.stringArray[indexPath.row]);
    self.controllerRef.textField.text = self.stringArray[indexPath.row];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addFavorite
{
    UIAlertView *enterFav = [[UIAlertView alloc] initWithTitle:@"New Favorite" message:@"Enter your phrase here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",nil];

    
    enterFav.alertViewStyle = UIAlertViewStylePlainTextInput;
    [enterFav show];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0);
    {
        NSLog(@"Cancelled");
    }
    if(buttonIndex == 1)
    {
        NSLog(@"Selected Add");
        UITextField *alertText = [alertView textFieldAtIndex:0];
        [self.stringArray addObject:alertText.text];
        for(int i = 0;i<self.stringArray.count;i++)
        {
            NSLog(@"Element at %d is %@",i,self.stringArray[i]);
        }
        [self.tableView reloadData];

        NSString *path = [[NSBundle mainBundle] pathForResource:@"commonString" ofType:@"plist"];
        [self.stringArray writeToFile:path atomically:YES];

    }
}





@end
